function advance_dialog()
    player.state=5
    dialog_str=dialog_strs[1]
    deli(dialog_strs, 1)
end

function draw_dialog()
    if player.state==5 then
        if dialog_str==nil then
            player.state=0
            return
        end
        spr(231,cam_x,cam_y+ttop(14))
        for i=1,14 do
            spr(232,cam_x+ttop(i),cam_y+ttop(14))
        end
        spr(231,cam_x+ttop(15),cam_y+ttop(14),1,1,true)
        spr(231,cam_x,cam_y+ttop(15),1,1,false,true)
        for i=1,14 do
            spr(232,cam_x+ttop(i),cam_y+ttop(15),1,1,false,true)
        end
        spr(231,cam_x+ttop(15),cam_y+ttop(15),1,1,true,true)

        print(dialog_str,cam_x+ttop(1),cam_y+ttop(14)+4,5)
    end
end