function init_player() 
    player={
        name="terra",
        sp=211,
        x=ttop(55)+4,
        y=ttop(6),
        movement=1,
        w=8,
        h=8,
        anim=0,
        a_over=245,
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
        ]]
        state=8,
        max_hp=10,
        hp=10,
        pp=10,
        atk=2,
        def=1,
        speed=5,
        mag=1,
        xp=0,
        level_up=10,
        warp={
            x=0,
            y=0,
            map=2
        },
        chapter=0,
        map=4,
        submap=1,
        game_over=false,
        go_spr=0
    }
end

function update_player()
    player_controls()
    animate_player()
    set_warp()
    check_warp()
    check_combat()
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
        if btnp(5) then
            game_over()
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
                start_chapter1()
            else
                if player.state==7 then
                    player.game_over=true
                    main_menu()
                end
            end          
        end
    end
end

function animate_player()
    if player.state==0 then
        if player.dir==0 then
            player.sp=195
            player.flp=true
        elseif player.dir==1 then
            player.sp=195
            player.flp=false
        elseif player.dir==2 then
            player.sp=208
        elseif player.dir==3 then
            player.sp=192
        end
    elseif player.state==1 and time()-player.anim>0.3 then
        do_walk_anim()
        player.anim=time()
    elseif player.state==4 or player.state==7 or player.state==8 then
        player.sp=211
        player.flp=false
        if (player.state==7 or (player.state==8 and player.game_over)) and time()-player.anim>0.5 then
            if player.a_over==227 then
                player.a_over=228
            else
                player.a_over=227
            end
            player.anim=time()
        elseif player.state==8 and time()-player.anim>0.8 then
            if player.a_over==245 or player.a_over==246 or player.a_over==247 then
                player.a_over+=1
            else
                player.a_over=245
            end
            player.anim=time()
        end
    end
end

function do_walk_anim()
    if player.dir==0 then
        player.flp=true
        if player.sp==196 then
            player.sp=195
        else
            player.sp=196
        end
    elseif player.dir==1 then
        player.flp=false
        if player.sp==196 then
            player.sp=195
        else
            player.sp=196
        end
    elseif player.dir==2 then
        if player.sp==209 then
            player.sp=210
        else
            player.sp=209
        end
    elseif player.dir==3 then
        if player.sp==193 then
            player.sp=194
        else
            player.sp=193
        end
    end
end

function check_warp()
    if collide(player,player.dir,1) then
        warp_player(player.warp)
    end
end

function warp_player(w)
    player.x=w.x
    player.y=w.y
    player.map=w.map
end

function check_combat()
    if collide(player,player.dir,2) then
        engage_combat(player.map)
    end
end

function game_over()
    player.a_over=227
    player.state=7
    player.map=4
    player.x=ttop(55)+4
    player.y=ttop(6)
    player.go_spr=frame%2
end