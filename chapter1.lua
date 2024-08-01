function start_chapter1()
    p_x=ttop(35)
    p_y=ttop(1)
    p_map=1
    p_submap=1
    p_state=3
    p_chapter=1
    p_sp=89
    overworld_timer=frame
    engage_boss=false
end

function check_chapter1_events()
    if not event_flags[1] then
        if not scene_list[1] then
            pan_cam(ttop(18),ttop(48),ttop(18),ttop(29),5,7,1,150,60)
        elseif not scene_list[2] then
            pan_cam(ttop(50),ttop(40),ttop(50),ttop(48),7,2,2,60,60)
        elseif not scene_list[3] then
            pan_cam(ttop(5),ttop(12),0,0,2,1,3,90,60)
        elseif frame-overworld_timer>540 then
            intro_cutscene()
            reset_cinematic()
        end
    end
    if engage_boss and not dialog_scene then
        engage_boss=false
        event_flags[5]=true
        engage_combat(1)
    end
end

function intro_cutscene()
    p_x=ttop(36)
    p_y=ttop(2)
    p_state=0
    p_dir=1
    event_flags[1]=true
end