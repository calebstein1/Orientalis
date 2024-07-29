--[[
0 combat
1 indoor house
2 outdoor chapter 1
3 chapter 1 cave
4 game over/main menu
5 southern woods
]]

function set_map()
    local m=player.map

    if m==0 then
        map_d={
            x_start=0,
            x_end=ttop(16),
            y_start=0,
            y_end=ttop(16)
        }
    elseif m==1 then
        map_d={
            x_start=ttop(34),
            x_end=ttop(50),
            y_start=0,
            y_end=ttop(16)
        }
    elseif m==2 then
        map_d={
            x_start=0,
            x_end=ttop(34),
            y_start=0,
            y_end=ttop(28)
        }
    elseif m==3 then
        map_d={
            x_start=ttop(34),
            x_end=ttop(50),
            y_start=ttop(16),
            y_end=ttop(44)
        }
    elseif m==4 then
        map_d={
            x_start=ttop(50),
            x_end=ttop(66),
            y_start=0,
            y_end=ttop(16)
        }
    elseif m==5 then
        map_d={
            x_start=0,
            x_end=ttop(34),
            y_start=ttop(28),
            y_end=ttop(44)
        }
    end
end

function connected_map_warp()
    if player.map==2 and player.y>ttop(28) then
        player.map=5
    elseif player.map==5 and player.y<ttop(27) then
        player.map=2
    end
end

function set_warp()
    local m=player.map
    local sm=player.submap
    local wx=0
    local wy=0
    local wm=0

    if m==0 then
        return
    elseif m==1 then
        wm=2
        if sm==0 then
            wx=4
            wy=2
        elseif sm==1 then
            wx=8
            wy=2
        elseif sm==2 then
            wx=12
            wy=17
        elseif sm==3 then
            wx=28
            wy=9
        end
    elseif m==2 then
        --[[
        Default to house interior
        Individual warps will override values as needed
        ]]
        wx=42
        wy=13
        wm=1
        if player.x<ttop(2) then
        elseif player.x<ttop(6) then
            player.submap=0
        elseif player.x<ttop(10) then
            player.submap=1
        elseif player.x<ttop(14) then
            player.submap=2
        elseif player.x<ttop(30) then
            player.submap=3
        else
            wx=35
            wy=19
            wm=3
        end
    elseif m==3 then
        wx=32
        wy=15
        wm=2
    end
    player.warp={x=ttop(wx),y=ttop(wy),map=wm}
end

function draw_sprites()
    m=player.map
    sm=player.submap

    if m==0 then
        cls()
        set_colors(0)
        print_combat_string(c_str)
        print("hp: "..player.hp,ttop(7),ttop(14),7)
    elseif m==1 then
        set_colors(2)
        draw_map1_interior(sm)
    elseif m==2 then
        set_colors(0)
        if player.chapter==1 then
            spr(113,ttop(2),ttop(16))
        end
        spr(114,ttop(27),ttop(14))
        spr(116,ttop(4),ttop(19))
    elseif m==3 then
        set_colors(3)
        spr(113,ttop(43),ttop(18))
        if player.y>ttop(24) and (player.x<ttop(43) or player.y<ttop(39)) then
            map_fog()
        end
    elseif m==4 then
        cls()
        set_colors(0)
        circfill(ttop(58),ttop(4)+4,48,6)
        if player.state==7 then
            draw_game_over()
        elseif player.state==8 then
            draw_main_menu()
        end
    elseif m==5 then
        set_colors(0)
        if player.x<ttop(16) or player.x>ttop(22) then
            map_fog()
        end
    end
    if player.hazard_damage then
        pal(15,8)
    end
    spr(player.sp,player.x,player.y,1,1,player.flp)
end

function do_overworld_hazard()
    m=player.map
    if m==3 then
        player.hp-=1
        if player.hp<=0 then
            player.state=9
        else
            knockback(4)
        end
    end
end

function draw_main_menu()
    spr(69,ttop(57),ttop(2)+6,2,3)
    spr(player.a_over,ttop(58),ttop(3)+5)
    print("terradestined",ttop(54)+6,ttop(2),1)
    print("NEW GAME",ttop(56)+4,ttop(6),1)
    print("CONTINUE",ttop(56)+4,ttop(7),1)
end

function draw_game_over()
    spr(96,ttop(57),ttop(4),3,1)
    spr(player.a_over,ttop(59),ttop(4))
    print("game over!",ttop(55)+6,ttop(2),1)
    print("CONTINUE",ttop(56)+4,ttop(6),1)
    print("QUIT",ttop(56)+4,ttop(7),1)
end