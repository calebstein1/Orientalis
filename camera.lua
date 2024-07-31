function set_camera()
    cam_x=p_x-64+(p_w/2)
    if cam_x<map_d.x_start then
        cam_x=map_d.x_start
    end
    if cam_x>map_d.x_end-128 then
        cam_x=map_d.x_end-128
    end

    cam_y=p_y-64+(p_h/2)
    if cam_y<map_d.y_start then
        cam_y=map_d.y_start
    end
    if cam_y>map_d.y_end-128 then
        cam_y=map_d.y_end-128
    end

    camera(cam_x,cam_y)
end