function init_dialog()
    dialog_list={7,10,15,4,3,5,2,6,13,9,23,17,16,18,25,27}
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
    if event_flags[5] then
        dialog_list[14]+=1
    end
    if event_flags[6] then
        dialog_list[14]+=1
    end
    if event_flags[9] then
        dialog_list[3]=1
    end
    if event_flags[10] then
        dialog_list[14]+=1
        dialog_list[15]=26
    end
    if event_flags[11] then
        dialog_list[11]=24
        dialog_list[14]+=1
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
    elseif npc_id==14 then
        if event_flags[5] and not event_flags[10] then
            event_flags[10]=true
            update_dialog()
        elseif event_flags[11] then
            event_flags[6]=true
            update_dialog()
        end
    elseif npc_id==15 and not event_flags[10] then
        event_flags[12]=true
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