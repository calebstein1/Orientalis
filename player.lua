function init_player() 
    player={
        name="tara",
        sp=83,
        x=ttop(55)+4,
        y=ttop(6),
        movement=1,
        w=8,
        h=8,
        cooldown=0,
        anim=0,
        a_over=117,
        flp=false,
        dir=0,
        --[[
        state:
        0 idle
        1 walking
        2 climbing
        3 cutscene
        4 combat
        5 dialog
        6 select
        7 game over
        8 main menu
        9 overworld game over
        ]]
        state=8,
        max_hp=10,
        hp=10,
        heal_packs=0,
        heal_rate=7,
        atk=2,
        def=0,
        speed=5,
        level=1,
        xp=0,
        level_up=8,
        warp={
            x=0,
            y=0,
            map=2
        },
        chapter=0,
        map=4,
        submap=1,
        --[[
        event flags:
        1 intro cutscene done
        2 spoken to brother
        3 hilltop event
        4 first morning
        5 chapter 1 complete
        6 has parka
        7 hazard damage
        8 sleeping
        ]]
    }

    num_event_flags=8
    event_flags={}
    for i=1,num_event_flags do
        event_flags[i]=false
    end
end

function update_player()
    if event_flags[8] and frame-overworld_timer>90 then
       event_flags[8]=false
        intro_cutscene()
    end
    if player.chapter==1 then
        check_chapter1_events()
    end
    player_controls()
    animate_player()
    set_warp()
    check_warp()
    check_combat()
    check_climbing()
    check_overworld_hazard()
end

function player_controls()
    if player.state==0 or player.state==1 then
        if not btn(0)
        and not btn(1)
        and not btn(2)
        and not btn(3) then
            player.state=0
        end
        if btn(0) and not collide(player,0,0) then
            player.dir=0
            player.state=1
            player.x-=player.movement
        end
        if btn(1) and not collide(player,1,0) then
            player.dir=1
            player.state=1
            player.x+=player.movement
        end
        if btn(2) and not collide(player,2,0) then
            player.dir=2
            player.state=1
            player.y-=player.movement
        end
        if btn(3) and not collide(player,3,0) then
            player.dir=3
            player.state=1
            player.y+=player.movement
        end
        if btnp(4) then
            check_dialog()
        end
        if btnp(5) then
            show_menu()
        end
    elseif player.state==2 then
        if btn(2) then
            player.dir=2
            player.y-=player.movement/1.5
        end
        if btn(3) then
            player.dir=3
            player.y+=player.movement/1.5
        end
    elseif player.state==4 then
        if btnp(4) then
            advance_combat()
        end
        if btnp(0) or btnp(1) then
            if player.x==ttop(2) then
                player.x=ttop(8)
            else
                player.x=ttop(2)
            end
        end
    elseif player.state==5 then
        if btnp(4) or btnp(5) then
            advance_dialog()
        end
    elseif player.state==7 or player.state==8 then
        if not player.quit and (btnp(2) or btnp(3)) then
            if player.y==ttop(6) then
                player.y=ttop(7)
            else
                player.y=ttop(6)
            end
        end
        if btnp(4) then
            if player.y==ttop(6) then
                if player.state==7 then
                    init_player()
                    load_game()
                else
                    init_player()
                    start_chapter1()
                end
            else
                if player.state==7 then
                    main_menu()
                else
                    init_player()
                    load_game()
                    if player.chapter==1 then
                        init_c1_enemies()
                    end
                end
            end          
        end
    end
end

function animate_player()
    if player.state==0 then
        if player.dir==0 then
            player.sp=67
            player.flp=true
        elseif player.dir==1 then
            player.sp=67
            player.flp=false
        elseif player.dir==2 then
            player.sp=80
        elseif player.dir==3 then
            player.sp=64
        end
    elseif player.state==1 and frame-player.anim>9 then
        do_walk_anim()
        player.anim=frame
    elseif player.state==2 then
        player.sp=84
        if (btn(2) or btn(3)) and frame-player.anim>9 then
            player.flp=not player.flp
            player.anim=frame
        end
    elseif player.state==4 or player.state==7 or player.state==8 then
        player.sp=83
        player.flp=false
        if player.state==7 and frame-player.anim>15 then
            if player.a_over==99 then
                player.a_over=100
            else
                player.a_over=99
            end
            player.anim=frame
        elseif player.state==8 and frame-player.anim>24 then
            if player.a_over==117 or player.a_over==118 or player.a_over==119 then
                player.a_over+=1
            else
                player.a_over=117
            end
            player.anim=frame
        end
    elseif player.state==9 and frame-player.anim>30 then
        if player.sp==66 then
            player.sp=82
        elseif player.sp==82 then
            game_over()
        else
            player.sp=66
        end
        player.anim=frame
    end
end

function do_walk_anim()
    if player.dir==0 then
        player.flp=true
        if player.sp==68 then
            player.sp=67
        else
            player.sp=68
        end
    elseif player.dir==1 then
        player.flp=false
        if player.sp==68 then
            player.sp=67
        else
            player.sp=68
        end
    elseif player.dir==2 then
        player.sp=81
        player.flp=not player.flp
    elseif player.dir==3 then
        player.sp=65
        player.flp=not player.flp
    end
end

function check_dialog()
    if player.submap==1 and in_range(player.x,ttop(35),ttop(37)) and in_range(player.y,0,ttop(4)) then
        overworld_timer=frame
        bed_save()
    elseif player.chapter==1 then
        chapter1_dialog()
    end
end

function bed_save()
    player.hp=player.max_hp
    save_game()
    event_flags[8]=true
    player.x=ttop(35)
    player.y=ttop(1)
    player.sp=89
    dialog_strs={"saving game..."}
    advance_dialog()
end

function check_warp()
    if collide(player,player.dir,1) then
        warp_player(player.warp)
        return
    end
    connected_map_warp()
end

function check_climbing()
    if collide(player,player.dir,2) then
        player.state=2
    elseif player.state==2 then
        player.state=0
    end
end

function warp_player(w)
    player.x=w.x
    player.y=w.y
    player.map=w.map
end

function check_combat()
    m=player.map
    if (m==2 and player.x>ttop(20) and player.state==1 and frame-player.cooldown>21)
    or (m==3 and player.y>ttop(24) and player.state==1 and frame-player.cooldown>15 and not event_flags[5])
    or (m==5 and player.state==1 and frame-player.cooldown>18)
    or (m==6 and player.state==1 and frame-player.cooldown>12)
    then
        player.cooldown=frame
        if rnd()<0.2 then
            engage_combat(m)
        end
    end
end

function check_overworld_hazard()
    if (player.map==8 and frame-player.cooldown>60 and not event_flags[6])
    or ((player.state==0 or player.state==1) and collide(player,player.dir,3) and frame-player.cooldown>3) then
        event_flags[7]=true
        do_overworld_hazard()
    else
        event_flags[7]=false
        return
    end
    player.cooldown=frame
end

function show_menu()
    dia="hp:"..player.hp.."/"..player.max_hp.." +kits:"..player.heal_packs.." xp:"..player.xp.."/"..player.level_up
    add(dialog_strs,dia)
    advance_dialog()
end

function game_over()
    player.a_over=99
    player.state=7
    player.map=4
    player.x=ttop(55)+4
    player.y=ttop(6)
end