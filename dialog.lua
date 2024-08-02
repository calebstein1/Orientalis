function init_dialog()
    dialog_strs={}
    dialog_scene=false
    dialog_finished=0
end

function advance_dialog()
    dialog_scene=true
    p_state=5
    dialog_str=dialog_strs[1]
    deli(dialog_strs, 1)
end

function draw_dialog()
    if p_state==5 then
        if dialog_str==nil then
            dialog_finished=frame
            p_state=0
            dialog_scene=false
            return
        end
        spr(103,cam_x,cam_y+ttop(14))
        for i=1,14 do
            spr(104,cam_x+ttop(i),cam_y+ttop(14))
        end
        spr(103,cam_x+ttop(15),cam_y+ttop(14),1,1,true)
        spr(103,cam_x,cam_y+ttop(15),1,1,false,true)
        for i=1,14 do
            spr(104,cam_x+ttop(i),cam_y+ttop(15),1,1,false,true)
        end
        spr(103,cam_x+ttop(15),cam_y+ttop(15),1,1,true,true)

        print(dialog_str,cam_x+ttop(1),cam_y+ttop(14)+4,5)
    end
end

function engage_dialog()
    if frame<dialog_finished+30 then
        return
    end

    local dia={}
    -- Mayor
    if p_submap==2 and in_range(p_x,ttop(45),ttop(48)) and in_range(p_y,ttop(1),ttop(4)) then
        if event_flags[9] then
            dia=strings[1]
        else
            dia=strings[15]
        end
    -- Guy by west cave
    elseif not event_flags[3] and in_range(p_x,ttop(1),ttop(4)) and in_range(p_y,ttop(15),ttop(18)) then
        dia=strings[2]
    -- Girl by fisherman hut
    elseif event_flags[4] and not event_flags[5] and in_range(p_x,ttop(26),ttop(29)) and in_range(p_y,ttop(13),ttop(16)) then
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
    -- Forest village innkeeper
    elseif p_submap==4 and in_range(p_x,ttop(44),ttop(47)) and in_range(p_y,ttop(11),ttop(14)) then
        dia=strings[16]
    -- Forest village inn customer
    elseif p_submap==4 and in_range(p_x,ttop(35),ttop(38)) and in_range(p_y,ttop(11),ttop(14)) then
        dia=strings[17]
    -- Clothing maker
    elseif p_submap==5 and in_range(p_x,ttop(44),ttop(47)) and in_range(p_y,ttop(11),ttop(14)) then
        if not event_flags[5] then
            dia=strings[18]
        elseif not event_flags[10] then
            dia=strings[19]
            event_flags[10]=true
        elseif not event_flags[11] then
            dia=strings[20]
        elseif not event_flags[6] then
            dia=strings[21]
            event_flags[6]=true
        else
            dia=strings[22]
        end
    -- Clothing maker's son
    elseif in_range(p_x,ttop(26),ttop(29)) and in_range(p_y,ttop(56),ttop(59)) then
        if not event_flags[5] then
            dia=strings[23]
        elseif event_flags[11] then
            dia=strings[24]
        else
            return
        end
    -- No dialog
    else
        return
    end

    for d in all(dia) do
        add(dialog_strs,d)
    end
    sfx(0)
    advance_dialog()
end