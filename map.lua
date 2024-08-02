--[[
0 combat
1 indoor house
2 first town
3 east cave
4 game over/main menu
5 southern woods
6 west cave
7 hilltop
8 snow forest
9 forest village
10 deep forest
11 cult camp
]]

map_d={
    [0]={
        x_start=0,
        x_end=ttop(16),
        y_start=0,
        y_end=ttop(16)
    },
    -- 1
    {
        x_start=ttop(34),
        x_end=ttop(50),
        y_start=0,
        y_end=ttop(16)
    },
    -- 2
    {
        x_start=0,
        x_end=ttop(34),
        y_start=0,
        y_end=ttop(28)
    },
    -- 3
    {
        x_start=ttop(34),
        x_end=ttop(50),
        y_start=ttop(16),
        y_end=ttop(44)
    },
    -- 4
    {
        x_start=ttop(50),
        x_end=ttop(66),
        y_start=0,
        y_end=ttop(16)
    },
    -- 5
    {
        x_start=0,
        x_end=ttop(34),
        y_start=ttop(28),
        y_end=ttop(44)
    },
    -- 6
    {
        x_start=ttop(34),
        x_end=ttop(50),
        y_start=ttop(44),
        y_end=ttop(64)
    },
    -- 7
    {
        x_start=ttop(50),
        x_end=ttop(66),
        y_start=ttop(48),
        y_end=ttop(64)
    },
    -- 8
    {
        x_start=ttop(50),
        x_end=ttop(66),
        y_start=ttop(16),
        y_end=ttop(50)
    },
    -- 9
    {
        x_start=ttop(18),
        x_end=ttop(34),
        y_start=ttop(42),
        y_end=ttop(64)
    },
    -- 10
    {
        x_start=0,
        x_end=ttop(18),
        y_start=ttop(42),
        y_end=ttop(64)
    },
    -- 11
    {
        x_start=ttop(50),
        x_end=ttop(66),
        y_start=0,
        y_end=ttop(16)
    }
}
map_bg={4,11,5,0,11,5,11,7,11,11,11}

function connected_map_warp()
    if p_state==3 then
        return
    end
    if p_map==2 and p_y>ttop(28) then
        set_map(5)
    elseif p_map==5 then
        if p_y<ttop(27) then
            set_map(2)
        elseif p_y>ttop(44) then
            set_map(9)
        end
    elseif p_map==7 and p_y<ttop(48) then
        stop_music()
        set_map(8)
    elseif p_map==8 and p_y>ttop(50) then
        stop_music()
        set_map(7)
    elseif p_map==9 then
        if p_y<ttop(43) then
            set_map(5)
        elseif p_x<ttop(17) then
            set_map(10)
        end
    elseif p_map==10 then
        if p_x>ttop(18) then
            set_map(9)
        end
    end
end

function set_map(n)
    p_map=n
    map_changed=frame
end

function set_warp()
    if p_map==0 then
        return
    elseif p_map==1 then
        local sm_x={8,12,28}
        local sm_y={2,17,9}
        p_wm=2
        p_wx=sm_x[p_submap]
        p_wy=sm_y[p_submap]
    elseif p_map==2 then
        --[[
        Default to house interior
        Individual warps will override values as needed
        ]]
        p_wx=42
        p_wy=14
        p_wm=1
        if p_x<ttop(2) then
            p_wx=48
            p_wy=57
            p_wm=6
        elseif p_x<ttop(10) then
            p_submap=1
        elseif p_x<ttop(14) then
            p_submap=2
        elseif p_x<ttop(30) then
            p_submap=3
        else
            p_wx=35
            p_wy=19
            p_wm=3
        end
    elseif p_map==3 then
        p_wx=32
        p_wy=15
        p_wm=2
    elseif p_map==6 then
        if p_x>ttop(42) then
            p_wx=1
            p_wy=15
            p_wm=2
        else
            p_wx=64
            p_wy=60
            p_wm=7
        end
    elseif p_map==7 then
        p_wx=35
        p_wy=46
        p_wm=6
    elseif p_map==10 then
        p_wx=64
        p_wy=11
        p_wm=11
    elseif p_map==11 then
        p_wx=1
        p_wy=53
        p_wm=10
    end
end

function set_bg()
    bg=map_bg[p_map]
    if bg==11 and not event_flags[9] then
        bg=1
    end
end

function draw_sprites()
    set_colors(0)
    if p_map==0 then
        cls()
        print_combat_string(c_str)
        print("hp: "..p_hp,ttop(7),ttop(14),7)
    elseif p_map==1 then
        draw_map1_interior()
    elseif p_map==2 then
        if not event_flags[9] then
            set_colors(1)
        else
            if not event_flags[5] then
                spr(114,ttop(27),ttop(14))
            end
            spr(116,ttop(4),ttop(19))
            spr(40,ttop(30),ttop(4))
        end
        if not event_flags[3] then
            spr(113,ttop(2),ttop(16))
        end
    elseif p_map==3 then
        set_colors(3)
        spr(112,ttop(43),ttop(18))
        if not event_flags[5] and p_y>ttop(24) and (p_x<ttop(43) or p_y<ttop(39)) then
            map_fog(0)
        end
        if event_flags[4] and not event_flags[5] then
            spr(poi_sp,ttop(44),ttop(40))
        end
    elseif p_map==4 then
        cls()
        circfill(ttop(58),ttop(4)+4,48,6)
        if p_state==7 then
            draw_game_over()
        elseif p_state==8 then
            draw_main_menu()
        end
    elseif p_map==5 then
        if not event_flags[4] then
            set_colors(1)
            map_fog(0)
        else
            map_fog(5)
        end
    elseif p_map==6 then
        set_colors(7)
    elseif p_map==7 then
        if not event_flags[4] then
            set_colors(1)
        end
        if not event_flags[3] then
            spr(poi_sp,ttop(58),ttop(54))
        end
    elseif p_map==8 then
        set_colors(5)
        if p_y>ttop(29) then
            map_fog(5)
        end
    elseif p_map==9 then
    elseif p_map==10 then
        map_fog(5)
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

function draw_map1_interior()
    if p_submap==1 then
        spr(42,ttop(48),ttop(1),1,2)
        spr(42,ttop(35),ttop(10),1,2)
        spr(115,ttop(45),ttop(4))
        if not event_flags[3] then
            spr(73,ttop(36),ttop(12))
        else
            spr(73,ttop(45),ttop(12))
        end
    elseif p_submap==2 then
        spr(112,ttop(46),ttop(2))
    elseif p_submap==3 then
        spr(42,ttop(48),ttop(1),1,2)
        spr(112,ttop(42),ttop(11))
        if not event_flags[9] then
            spr(121,ttop(48),ttop(1))
        end
    end
end

function do_overworld_hazard()
    if p_map==3 or p_map==5 or p_map==6 or p_map==10 then
        knockback(4)
        p_hp-=1
    elseif p_map==8 then
        p_hp-=4
    end
    if p_hp<=0 then
        p_state=9
    end
end

function map_fog(c)
    if p_state==3 then
        return
    end
    rectfill(cam_x,cam_y,p_x-12,cam_y+ttop(16),c)
    rectfill(p_x+p_w+12,cam_y,p_x+ttop(16),cam_y+ttop(16),c)
    rectfill(cam_x,cam_y,cam_x+ttop(16),p_y-12,c)
    rectfill(cam_x,p_y+p_h+12,cam_x+ttop(16),cam_y+ttop(16),c)
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