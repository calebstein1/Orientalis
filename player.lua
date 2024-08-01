function init_player() 
    p_name="tara"
    p_sp=83
    p_x=ttop(55)+4
    p_y=ttop(6)
    p_movement=1
    p_w=8
    p_h=8
    p_cooldown=0
    p_anim=0
    p_a_over=117
    p_flp=false
    p_dir=0
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
    p_state=8
    p_max_hp=10
    p_hp=10
    p_heal_packs=0
    p_heal_rate=7
    p_atk=2
    p_def=0
    p_speed=5
    p_level=1
    p_xp=0
    p_level_up=8
    p_wx=0
    p_wy=0
    p_wm=2
    p_chapter=0
    p_map=4
    p_submap=1
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
    if p_chapter==1 then
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
    if p_state==0 or p_state==1 then
        if not btn(0)
        and not btn(1)
        and not btn(2)
        and not btn(3) then
            p_state=0
        end
        if btn(0) and not collide(0,0) then
            p_dir=0
            p_state=1
            p_x-=p_movement
        end
        if btn(1) and not collide(1,0) then
            p_dir=1
            p_state=1
            p_x+=p_movement
        end
        if btn(2) and not collide(2,0) then
            p_dir=2
            p_state=1
            p_y-=p_movement
        end
        if btn(3) and not collide(3,0) then
            p_dir=3
            p_state=1
            p_y+=p_movement
        end
        if btnp(4) then
            check_dialog()
        end
        if btnp(5) then
            show_menu()
        end
    elseif p_state==2 then
        if btn(2) then
            p_dir=2
            p_y-=p_movement/1.5
        end
        if btn(3) then
            p_dir=3
            p_y+=p_movement/1.5
        end
    elseif p_state==4 then
        if btnp(4) then
            advance_combat()
        end
        if btnp(0) or btnp(1) then
            if p_x==ttop(2) then
                p_x=ttop(8)
            else
                p_x=ttop(2)
            end
        end
    elseif p_state==5 then
        if btnp(4) or btnp(5) then
            advance_dialog()
        end
    elseif p_state==7 or p_state==8 then
        if not p_quit and (btnp(2) or btnp(3)) then
            if p_y==ttop(6) then
                p_y=ttop(7)
            else
                p_y=ttop(6)
            end
        end
        if btnp(4) then
            stop_music()
            sfx(0)
            if p_y==ttop(6) then
                if p_state==7 then
                    init_player()
                    load_game()
                else
                    init_player()
                    start_chapter1()
                end
            else
                if p_state==7 then
                    main_menu()
                else
                    init_player()
                    load_game()
                    if p_chapter==1 then
                        init_c1_enemies()
                    end
                end
            end          
        end
    end
end

function animate_player()
    if p_state==0 then
        if p_dir==0 then
            p_sp=67
            p_flp=true
        elseif p_dir==1 then
            p_sp=67
            p_flp=false
        elseif p_dir==2 then
            p_sp=80
        elseif p_dir==3 then
            p_sp=64
        end
    elseif p_state==1 and frame-p_anim>9 then
        do_walk_anim()
        p_anim=frame
    elseif p_state==2 then
        p_sp=84
        if (btn(2) or btn(3)) and frame-p_anim>9 then
            p_flp=not p_flp
            p_anim=frame
        end
    elseif p_state==4 or p_state==7 or p_state==8 then
        p_sp=83
        p_flp=false
        if p_state==7 and frame-p_anim>15 then
            if p_a_over==99 then
                p_a_over=100
            else
                p_a_over=99
            end
            p_anim=frame
        elseif p_state==8 and frame-p_anim>24 then
            if p_a_over==117 or p_a_over==118 or p_a_over==119 then
                p_a_over+=1
            else
                p_a_over=117
            end
            p_anim=frame
        end
    elseif p_state==9 and frame-p_anim>30 then
        if p_sp==66 then
            p_sp=82
        elseif p_sp==82 then
            game_over()
        else
            p_sp=66
        end
        p_anim=frame
    end
end

function do_walk_anim()
    if p_dir==0 then
        p_flp=true
        if p_sp==68 then
            p_sp=67
        else
            p_sp=68
        end
    elseif p_dir==1 then
        p_flp=false
        if p_sp==68 then
            p_sp=67
        else
            p_sp=68
        end
    elseif p_dir==2 then
        p_sp=81
        p_flp=not p_flp
    elseif p_dir==3 then
        p_sp=65
        p_flp=not p_flp
    end
end

function check_dialog()
    if p_submap==1 and in_range(p_x,ttop(35),ttop(37)) and in_range(p_y,0,ttop(4)) then
        overworld_timer=frame
        bed_save()
    elseif p_chapter==1 then
        chapter1_dialog()
    end
end

function bed_save()
    p_hp=p_max_hp
    save_game()
    event_flags[8]=true
    p_x=ttop(35)
    p_y=ttop(1)
    p_sp=89
    dialog_strs={"saving game..."}
    advance_dialog()
end

function check_warp()
    if collide(p_dir,1) then
        warp_player()
    else
        connected_map_warp()
    end
end

function warp_player()
    stop_music()
    p_x=ttop(p_wx)
    p_y=ttop(p_wy)
    p_map=p_wm
end

function check_climbing()
    if collide(p_dir,2) then
        p_state=2
    elseif p_state==2 then
        p_state=0
    end
end

function check_combat()
    local dia={}

    if (p_map==2 and p_x>ttop(20) and p_state==1 and frame-p_cooldown>21)
    or (p_map==3 and p_y>ttop(24) and p_state==1 and frame-p_cooldown>15 and not event_flags[5])
    or (p_map==5 and p_state==1 and frame-p_cooldown>18)
    or (p_map==6 and p_state==1 and frame-p_cooldown>12)
    then
        p_cooldown=frame
        if rnd()<0.2 then
            if p_speed>=enemies[p_map].speed and p_atk-enemies[p_map].def>=enemies[p_map].max_hp then
                p_xp+=flr(enemies[p_map].xp/2)
                dia={p_name.." defeats "..enemies[p_map].name.."!"}
                if p_xp>=p_level_up then
                    level_up()
                    add(dia, p_name.." levels up!")
                end
                for d in all(dia) do
                    add(dialog_strs,d)
                end
                advance_dialog()
            else
                engage_combat(p_map)
            end
        end
    end
end

function check_overworld_hazard()
    if (p_map==8 and frame-p_cooldown>60 and not event_flags[6])
    or ((p_state==0 or p_state==1) and collide(p_dir,3) and frame-p_cooldown>3) then
        event_flags[7]=true
        do_overworld_hazard()
    else
        event_flags[7]=false
        return
    end
    p_cooldown=frame
end

function show_menu()
    dia="hp:"..p_hp.."/"..p_max_hp.." +kits:"..p_heal_packs.." xp:"..p_xp.."/"..p_level_up
    add(dialog_strs,dia)
    advance_dialog()
end

function game_over()
    p_a_over=99
    p_state=7
    p_map=4
    p_x=ttop(55)+4
    p_y=ttop(6)
end