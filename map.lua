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
            wx=2
            wy=2
        elseif sm==1 then
            wx=8
            wy=2
        elseif sm==2 then
            wx=3
            wy=14
        elseif sm==3 then
            wx=7
            wy=14
        elseif sm==4 then
            wx=10
            wy=17
        elseif sm==5 then
            wx=3
            wy=19
        elseif sm==6 then
            wx=14
            wy=20
        elseif sm==7 then
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
        if player.y<ttop(3) then
            if player.x>ttop(6) then
                player.submap=1
            else
                player.submap=0
            end
        elseif player.y<ttop(15) then
            if player.x<ttop(2) then
            elseif player.x<ttop(5) then
                player.submap=2
            elseif player.x<ttop(9) then
                player.submap=3
            elseif player.x<ttop(30) then
                player.submap=7
            else
            end
        elseif player.y<ttop(21) then
            if player.x<ttop(5) then
                player.submap=5
            elseif player.x<ttop(12) then
                player.submap=4
            else
                player.submap=6
            end
        else
        end
    end
    player.warp={x=ttop(wx),y=ttop(wy),map=wm}
end

function draw_sprites()
    m=player.map
    sm=player.submap

    if m==0 then
        cls()
        print_combat_string(c_str)
        print("hp: "..player.hp,ttop(7),ttop(14),7)
        print("pp: "..player.pp,ttop(7),ttop(15),7)
    elseif m==1 then
        set_colors(2)
        draw_map1_interior(sm)
    elseif m==2 then
        set_colors(0)
        if player.chapter==1 then
            spr(113,ttop(2),ttop(16))
        end
        spr(114,ttop(27),ttop(14))
    elseif m==3 then
    elseif m==4 then
        cls()
        rectfill(ttop(56),0,ttop(59)+8,8,6)
        rectfill(ttop(55),ttop(1),ttop(60)+8,ttop(1)+8,6)
        rectfill(ttop(54),ttop(2),ttop(61)+8,ttop(2)+8,6)
        rectfill(ttop(53),ttop(3),ttop(62)+8,ttop(3)+8,6)
        rectfill(ttop(52),ttop(4),ttop(63)+8,ttop(9)+8,6)
        if player.state==7 then
            draw_game_over()
        elseif player.state==8 then
            draw_main_menu()
        end
    end
    spr(player.sp,player.x,player.y,1,1,player.flp)
end