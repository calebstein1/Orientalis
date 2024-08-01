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
    if not event_flags[1] and frame-overworld_timer>120 then
        intro_cutscene()
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