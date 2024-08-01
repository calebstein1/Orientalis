function init_c1_enemies()
    e_name={"the giant mole","the feral cat","the cave mole","","the killer wasp","the cave rat"}
    e_max_hp={20,5,7,0,4,3}
    e_hp={20,5,7,0,4,3}
    e_atk={5,2,3,0,8,1}
    e_def={1,0,0,0,0,0}
    e_speed={4,6,6,0,8,6}
    e_xp={25,3,8,0,11,2}
    e_atk_str={
        {"tears into "..p_name,"with its brutal claws"},
        {"scratches at "..p_name,"with its sharp claws"},
        {"throws a rock at",p_name.."'s head"},
        {},
        {"charges "..p_name.." with","its stinger"},
        {"tries to bite at",p_name},
    }
end

function start_chapter1()
    p_x=ttop(35)
    p_y=ttop(1)
    p_map=1
    p_submap=1
    p_state=3
    p_chapter=1
    p_sp=89
    init_c1_enemies()
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

function chapter1_dialog()
    if frame<dialog_finished+30 then
        return
    end

    local dia={}
    -- Mayor
    if p_submap==2 and in_range(p_x,ttop(45),ttop(48)) and in_range(p_y,ttop(1),ttop(4)) then
        dia=strings[1]
    -- Guy by west cave
    elseif not event_flags[3] and in_range(p_x,ttop(1),ttop(4)) and in_range(p_y,ttop(15),ttop(18)) then
        dia=strings[2]
    -- Girl by fisherman hut
    elseif event_flags[4] and in_range(p_x,ttop(26),ttop(29)) and in_range(p_y,ttop(13),ttop(16)) then
        dia=strings[3]
    -- Hank the angry fisherman
    elseif p_submap==3 and in_range(p_x,ttop(41),ttop(44)) and in_range(p_y,ttop(10),ttop(13)) then
        dia=strings[4]
    -- Woods warning
    elseif event_flags[4] and in_range(p_x,ttop(3),ttop(6)) and in_range(p_y,ttop(18),ttop(21)) then
        dia=strings[5]
    -- Cave warning
    elseif in_range(p_x,ttop(42),ttop(45)) and in_range(p_y,ttop(17),ttop(20)) then
        dia=strings[6]
    -- Brother
    elseif p_submap==1 and in_range(p_x,ttop(43),ttop(46)) and in_range(p_y,ttop(3),ttop(6)) then
        if not event_flags[2] then
            event_flags[2]=true
            dia=strings[7]
            p_heal_packs+=3
        else
            dia=strings[8]
        end
    -- Future traveler
    elseif not event_flags[3] and in_range(p_x,ttop(57),ttop(60)) and in_range(p_y,ttop(54),ttop(57)) then
        event_flags[3]=true
        dia=strings[9]
    -- Mom
    elseif p_submap==1 and not event_flags[3] and in_range(p_x,ttop(35),ttop(38)) and in_range(p_y,ttop(11),ttop(14)) then
        dia=strings[10]
    elseif p_submap==1 and in_range(p_x,ttop(44),ttop(47)) and in_range(p_y,ttop(11),ttop(14)) then
        if not event_flags[4] then
            event_flags[4]=true
            dia=strings[11]
        else
            if p_homesick>0 then
                dia=strings[14]
            else
                dia=strings[12]
            end
        end
        p_homesick=0
        p_homesick_timer=0
    -- Chapter 1 boss
    elseif event_flags[4] and not event_flags[5] and in_range(p_x,ttop(43),ttop(46)) and in_range(p_y,ttop(39),ttop(42)) then
        engage_boss=true
        dia=strings[13]
    end
    if dia==nil then
        return
    end
    for d in all(dia) do
        add(dialog_strs,d)
    end
    advance_dialog()
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
        spr(112,ttop(42),ttop(11))
    end
end

function intro_cutscene()
    p_x=ttop(36)
    p_y=ttop(2)
    p_state=0
    p_dir=1
    event_flags[1]=true
end