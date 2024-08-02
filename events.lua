function start_new_game()
    p_x=ttop(35)
    p_y=ttop(1)
    p_submap=1
    p_state=3
    p_sp=89
    overworld_timer=frame
    engage_boss=false
end

function check_events()
    if p_state==7 or p_state==8 then
        return
    end

    if not event_flags[1] then
        intro_cutscene()
    elseif not event_flags[5] and engage_boss and not dialog_scene then
        engage_boss=false
        event_flags[5]=true
        engage_combat(1)
    elseif p_map==7 and not event_flags[3] then
        play_music(0,500)
    elseif p_map==2 and event_flags[4] and not event_flags[9] then
        p_state=3
        daybreak_scene()
    elseif event_flags[12] and not dialog_scene then
        p_state=9
    end
end

function intro_cutscene()
    if not scene_list[1] then
        pan_cam(ttop(18),ttop(48),ttop(18),ttop(40),5,7,1,90,45)
    elseif not scene_list[2] then
        pan_cam(ttop(50),ttop(40),ttop(50),ttop(48),7,2,2,60,45)
    elseif not scene_list[3] then
        pan_cam(ttop(5),ttop(12),0,0,2,1,3,90,60)
    elseif frame-overworld_timer>520 then
        end_sleep()
        event_flags[1]=true
        reset_cinematic()
    end
end

function daybreak_scene()
    play_music(5,300)
    if frame-map_changed>240 then
        music_playing=false
        p_state=0
        event_flags[9]=true
    end
end