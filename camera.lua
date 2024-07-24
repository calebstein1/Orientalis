function set_camera()
    cam_x=player.x-64+(player.w/2)
    if cam_x<map_d.x_start then
        cam_x=map_d.x_start
    end
    if cam_x>map_d.x_end-128 then
        cam_x=map_d.x_end-128
    end

    cam_y=player.y-64+(player.h/2)
    if cam_y<map_d.y_start then
        cam_y=map_d.y_start
    end
    if cam_y>map_d.y_end-128 then
        cam_y=map_d.y_end-128
    end

    camera(cam_x,cam_y)
end