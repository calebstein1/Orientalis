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
    sfx(0)
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