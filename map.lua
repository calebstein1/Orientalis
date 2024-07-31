--[[
0 combat
1 indoor house
2 outdoor chapter 1
3 chapter 1 cave
4 game over/main menu
5 southern woods
6 west cave
7 hilltop
8 snow forest
]]

function set_map()
    if p_map==0 then
        map_d={
            x_start=0,
            x_end=ttop(16),
            y_start=0,
            y_end=ttop(16)
        }
    elseif p_map==1 then
        map_d={
            x_start=ttop(34),
            x_end=ttop(50),
            y_start=0,
            y_end=ttop(16)
        }
    elseif p_map==2 then
        map_d={
            x_start=0,
            x_end=ttop(34),
            y_start=0,
            y_end=ttop(28)
        }
    elseif p_map==3 then
        map_d={
            x_start=ttop(34),
            x_end=ttop(50),
            y_start=ttop(16),
            y_end=ttop(44)
        }
    elseif p_map==4 then
        map_d={
            x_start=ttop(50),
            x_end=ttop(66),
            y_start=0,
            y_end=ttop(16)
        }
    elseif p_map==5 then
        map_d={
            x_start=0,
            x_end=ttop(34),
            y_start=ttop(28),
            y_end=ttop(44)
        }
    elseif p_map==6 then
        map_d={
            x_start=ttop(34),
            x_end=ttop(50),
            y_start=ttop(44),
            y_end=ttop(60)
        }
    elseif p_map==7 then
        map_d={
            x_start=ttop(50),
            x_end=ttop(66),
            y_start=ttop(48),
            y_end=ttop(64)
        }
    elseif p_map==8 then
        map_d={
            x_start=ttop(50),
            x_end=ttop(66),
            y_start=ttop(16),
            y_end=ttop(50)
        }
    end
end

function connected_map_warp()
    if p_map==2 and p_y>ttop(28) then
        p_map=5
    elseif p_map==5 and p_y<ttop(27) then
        p_map=2
    elseif p_map==7 and p_y<ttop(48) then
        p_map=8
    elseif p_map==8 and p_y>ttop(50) then
        p_map=7
    end
end

function set_warp()
    local wx=0
    local wy=0
    local wm=0

    if p_map==0 then
        return
    elseif p_map==1 then
        wm=2
        if p_submap==0 then
            wx=4
            wy=2
        elseif p_submap==1 then
            wx=8
            wy=2
        elseif p_submap==2 then
            wx=12
            wy=17
        elseif p_submap==3 then
            wx=28
            wy=9
        end
    elseif p_map==2 then
        --[[
        Default to house interior
        Individual warps will override values as needed
        ]]
        wx=42
        wy=13
        wm=1
        if p_x<ttop(2) then
            wx=48
            wy=57
            wm=6
        elseif p_x<ttop(6) then
            p_submap=0
        elseif p_x<ttop(10) then
            p_submap=1
        elseif p_x<ttop(14) then
            p_submap=2
        elseif p_x<ttop(30) then
            p_submap=3
        else
            wx=35
            wy=19
            wm=3
        end
    elseif p_map==3 then
        wx=32
        wy=15
        wm=2
    elseif p_map==6 then
        if p_x>ttop(42) then
            wx=1
            wy=15
            wm=2
        else
            wx=64
            wy=60
            wm=7
        end
    elseif p_map==7 then
        wx=35
        wy=46
        wm=6
    end
    p_warp={x=ttop(wx),y=ttop(wy),map=wm}
end

function draw_sprites()
    if p_map==0 then
        cls()
        set_colors(0)
        print_combat_string(c_str)
        print("hp: "..p_hp,ttop(7),ttop(14),7)
    elseif p_map==1 then
        set_colors(2)
        draw_map1_interior()
    elseif p_map==2 then
        if not event_flags[4] then
            set_colors(1)
        else
            set_colors(0)
            spr(114,ttop(27),ttop(14))
            spr(116,ttop(4),ttop(19))
        end
        if not event_flags[3] then
            spr(113,ttop(2),ttop(16))
        end
    elseif p_map==3 then
        set_colors(3)
        spr(112,ttop(43),ttop(18))
        if not event_flags[5] and p_y>ttop(24) and (p_x<ttop(43) or p_y<ttop(39)) then
            map_fog()
        end
        if event_flags[4] and not event_flags[5] then
            spr(poi_sp,ttop(44),ttop(40))
        end
    elseif p_map==4 then
        cls()
        set_colors(0)
        circfill(ttop(58),ttop(4)+4,48,6)
        if p_state==7 then
            draw_game_over()
        elseif p_state==8 then
            draw_main_menu()
        end
    elseif p_map==5 then
        set_colors(0)
        if p_x<ttop(16) or p_x>ttop(22) then
            map_fog()
        end
    elseif p_map==6 then
        set_colors(7)
    elseif m==7 then
        if not event_flags[4] then
            set_colors(1)
        else
            set_colors(0)
        end
        if not event_flags[3] then
            spr(poi_sp,ttop(58),ttop(54))
        end
    elseif p_map==8 then
        set_colors(5)
        if p_y>ttop(29) then
            map_fog()
        end
    end
    if event_flags[7] then
        pal(15,8)
    end
    if event_flags[6] and p_map==8 then
        spr(p_sp+10,p_x,p_y,1,1,p_flp)
    else
        spr(p_sp,p_x,p_y,1,1,p_flp)
    end
end

function do_overworld_hazard()
    if p_map==3 then
        knockback(4)
        p_hp-=1
    elseif p_map==8 then
        p_hp-=4
    end
    if p_hp<=0 then
        p_state=9
    end
end

function draw_main_menu()
    spr(69,ttop(57),ttop(2)+6,2,3)
    spr(p_a_over,ttop(58),ttop(3)+5)
    print("terradestined",ttop(54)+6,ttop(2),1)
    print("NEW GAME",ttop(56)+4,ttop(6),1)
    print("CONTINUE",ttop(56)+4,ttop(7),1)
end

function draw_game_over()
    spr(96,ttop(57),ttop(4),3,1)
    spr(p_a_over,ttop(59),ttop(4))
    print("game over!",ttop(55)+6,ttop(2),1)
    print("CONTINUE",ttop(56)+4,ttop(6),1)
    print("QUIT",ttop(56)+4,ttop(7),1)
end