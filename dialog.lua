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
        spr(103,cam_x,cam_y+112)
        for i=8,112,8 do
            spr(104,cam_x+i,cam_y+112)
        end
        spr(103,cam_x+120,cam_y+112,1,1,true)
        spr(103,cam_x,cam_y+120,1,1,false,true)
        for i=8,112,8 do
            spr(104,cam_x+i,cam_y+120,1,1,false,true)
        end
        spr(103,cam_x+120,cam_y+120,1,1,true,true)

        print(dialog_str,cam_x+8,cam_y+112+4,5)
    end
end

function engage_dialog()
    if frame<dialog_finished+30 then
        return
    end

    local dia={}
    -- Mayor
    if p_submap==2 and in_range(360,384,8,32) then
        if event_flags[9] then
            dia=strings[1]
        else
            dia=strings[15]
        end
    -- Guy by west cave
    elseif not event_flags[3] and in_range(8,32,120,144) then
        dia=strings[2]
    -- Girl by fisherman hut
    elseif event_flags[4] and not event_flags[5] and in_range(208,232,104,128) then
        dia=strings[3]
    -- Hank the angry fisherman
    elseif p_submap==3 and in_range(328,352,80,104) then
        dia=strings[4]
    -- Woods warning
    elseif event_flags[4] and in_range(24,48,144,168) then
        dia=strings[5]
    -- Cave warning
    elseif in_range(336,360,136,160) then
        dia=strings[6]
    -- Brother
    elseif p_submap==1 and in_range(344,368,24,48) then
        if not event_flags[2] then
            event_flags[2]=true
            dia=strings[7]
            p_heal_packs+=3
        else
            dia=strings[8]
        end
    -- Future traveler
    elseif not event_flags[3] and in_range(456,480,432,456) then
        event_flags[3]=true
        dia=strings[9]
    -- Mom
    elseif p_submap==1 and not event_flags[3] and in_range(280,304,88,112) then
        dia=strings[10]
    elseif p_submap==1 and in_range(352,376,88,112) then
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
    -- Giant mole
    elseif event_flags[4] and not event_flags[5] and in_range(344,368,312,336) then
        engage_boss=true
        dia=strings[13]
    -- Forest village innkeeper
    elseif p_submap==4 and in_range(352,376,88,112) then
        dia=strings[16]
    -- Forest village inn customer
    elseif p_submap==4 and not event_flags[11] and in_range(280,304,88,112) then
        dia=strings[17]
    -- Clothing maker
    elseif p_submap==5 and in_range(352,376,88,112) then
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
    elseif in_range(208,232,448,472) then
        if not event_flags[5] then
            dia=strings[23]
        elseif event_flags[11] then
            dia=strings[24]
        else
            return
        end
    -- Cult high shaman
    elseif not event_flags[11] and in_range(456,480,48,72) then
        if not event_flags[10] then
            dia=strings[25]
            event_flags[12]=true
        else
            engage_boss=true
            dia=strings[26]
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