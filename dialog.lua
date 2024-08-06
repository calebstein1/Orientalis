function init_dialog()
    dialog_list={7,10,15,4,3,5,2,6,13,9}
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

function update_dialog()
    if event_flags[2] then
        dialog_list[1]=8
    end
    if event_flags[3] then
        dialog_list[2]=11
    end
    if event_flags[4] then
        dialog_list[2]=p_homesick>0 and 14 or 12
    end
    if event_flags[9] then
        dialog_list[3]=1
    end
end

function dialog_action(npc_id)
    if npc_id==1 and not event_flags[2] then
        event_flags[2]=true
        p_heal_packs+=3
        update_dialog()
    elseif npc_id==2 then 
        if event_flags[3] and not event_flags[4] then
            event_flags[4]=true
        end
        p_homesick,p_homesick_timer=0,0
        update_dialog()
    elseif npc_id==9 then
        engage_boss=true
    elseif npc_id==10 then
        event_flags[3]=true
    end
end

function do_dialog()
    if frame<dialog_finished+30 then
        return
    end

    local dia={}
    local npc_id=collide_npc()
    if not npc_id then return end

    dia=strings[dialog_list[npc_id]]
    for d in all(dia) do
        add(dialog_strs,d)
    end
    dialog_action(npc_id)
    sfx(0)
    advance_dialog()
end

-- DEPRICATED
function engage_dialog()
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