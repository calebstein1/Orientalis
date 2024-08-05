function init_player() 
    p_name="tara"
    p_sp,p_x,p_y,p_movement,p_w,p_h,p_cooldown,p_anim,p_a_over,p_flp,p_dir,p_state,
    p_max_hp,p_hp,p_heal_packs,p_heal_rate,p_atk,p_def,p_speed,p_level,p_xp,p_level_up,p_homesick,p_homesick_timer,
    p_wx,p_wy,p_wm,p_map,p_submap,num_event_flags=unpack(split("83,444,48,1,8,8,0,0,117,false,0,8,10,10,0,7,2,0,5,1,0,8,0,0,0,0,2,4,1,12"))
    event_flags={}
    for i=1,num_event_flags do
        event_flags[i]=false
    end
end

function update_player()
    if event_flags[8] and frame-overworld_timer>90 then
        event_flags[8]=false
        end_sleep()
    end
    check_events()
    player_controls()
    animate_player()
    set_warp()
    check_warp()
    check_combat()
    check_climbing()
    check_overworld_hazard()
    update_homesick()
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
            show_menu()
        end
        if btnp(5) then
            check_dialog()
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
        if btnp(5) then
            advance_combat()
        end
        if btnp(0) or btnp(1) then
            p_x=p_x==16 and 64 or 16
        end
    elseif p_state==5 then
        if (btnp(4) or btnp(5)) and not event_flags[8] then
            advance_dialog()
        end
    elseif p_state==7 or p_state==8 then
        if not p_quit and (btnp(2) or btnp(3)) then
            p_y=p_y==48 and 56 or 48
        end
        if btnp(5) then
            stop_music()
            sfx(0)
            if p_y==48 then
                if p_state==7 then
                    init_player()
                    load_game()
                else
                    init_player()
                    start_new_game()
                end
            else
                if p_state==7 then
                    main_menu()
                else
                    init_player()
                    load_game()
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
            p_a_over=p_a_over==99 and 100 or 99
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
        p_sp=p_sp==68 and 67 or 68
    elseif p_dir==1 then
        p_flp=false
        p_sp=p_sp==68 and 67 or 68
    elseif p_dir==2 then
        p_sp=81
        p_flp=not p_flp
    elseif p_dir==3 then
        p_sp=65
        p_flp=not p_flp
    end
end

function check_dialog()
    if (p_submap==1 or p_submap==4) and in_range(280,296,0,32) then
        overworld_timer=frame
        bed_save()
    else
        engage_dialog()
    end
end

function bed_save()
    p_hp=p_max_hp
    save_game()
    event_flags[8]=true
    p_x=280
    p_y=8
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
    if p_map>0 then
        stop_music()
    end
    p_x=p_wx*8
    p_y=p_wy*8
    set_map(p_wm)
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

    if (p_map==2 and p_x>160 and p_state==1 and frame-p_cooldown>21)
    or (p_map==3 and p_y>192 and p_state==1 and frame-p_cooldown>15 and not event_flags[5])
    or (p_map==5 and p_state==1 and frame-p_cooldown>18)
    or (p_map==6 and p_state==1 and frame-p_cooldown>12)
    then
        if frame-map_changed<30 then
            return
        end
        p_cooldown=frame
        if rnd()<0.2 then
            if p_speed>=e_speed[p_map] and p_atk-e_def[p_map]>=e_max_hp[p_map] then
                sfx(0)
                p_xp+=flr(e_xp[p_map]/2)
                dia={p_name.." defeats "..e_name[p_map].."!"}
                if p_xp>=p_level_up then
                    level_up()
                    add(dia, p_name.." levels up!")
                end
                for d in all(dia) do
                    add(dialog_strs,d)
                end
                advance_dialog()
                p_cooldown=frame+90
            else
                engage_combat(p_map)
            end
        end
    end
end

function check_overworld_hazard()
    if ((p_map==8 or p_map==12) and frame-p_cooldown>60 and not event_flags[6])
    or ((p_state==0 or p_state==1) and collide(p_dir,3) and frame-p_cooldown>3) then
        event_flags[7]=true
        do_overworld_hazard()
    else
        event_flags[7]=false
        return
    end
    p_cooldown=frame
end

function update_homesick()
    local dia
    if (p_state==0 or p_state==1 or p_state==2) and not (p_map==1 or p_map==2) then
        p_homesick_timer+=1
    end
    if p_homesick_timer==18000 and p_homesick<4 then
        p_homesick_timer=0
        p_homesick+=1
        if p_homesick==1 then
            dia=p_name.." feels lonely"
        elseif p_homesick==2 then
            dia=p_name.." misses home"
        elseif p_homesick==3 then
            dia=p_name.." wants to hug her mom"
        else
            dia=p_name.." is beginning to tear up"
        end

        add(dialog_strs,dia)
        advance_dialog()
    end
end

function end_sleep()
    p_x=288
    p_y=16
    p_state=0
    p_dir=1
end

function show_menu()
    sfx(0)
    local dia="hp:"..p_hp.."/"..p_max_hp.." +kits:"..p_heal_packs.." xp:"..p_xp.."/"..p_level_up
    add(dialog_strs,dia)
    advance_dialog()
end

function game_over()
    stop_music()
    p_a_over=99
    p_state=7
    p_map=4
    p_x=444
    p_y=48
    play_music(6,150)
end