auto_camera=true
scene_list={}

function set_camera()
    if auto_camera then
        auto_cam()
    else
        if (cam_sx<cam_ex and cam_x<cam_ex) or (cam_sx>cam_ex and cam_x>cam_ex) then
            cam_x+=cam_dx
        end
        if (cam_sy<cam_ey and cam_y<cam_ey) or (cam_sy>cam_ey and cam_y>cam_ey) then
            cam_y+=cam_dy
        end
        if frame>=cam_hold then
            scene_list[cam_cur_scene]=true
            p_map=n_map
            auto_camera=true
        end
    end
    camera(cam_x,cam_y)
end

function auto_cam()
    local d=map_d[p_map]
    cam_x=p_x-64+(p_w/2)
    if cam_x<d.x_start then
        cam_x=d.x_start
    end
    if cam_x>d.x_end-128 then
        cam_x=d.x_end-128
    end

    cam_y=p_y-64+(p_h/2)
    if cam_y<d.y_start then
        cam_y=d.y_start
    end
    if cam_y>d.y_end-128 then
        cam_y=d.y_end-128
    end
end

function pan_cam(sx,sy,ex,ey,m,nm,s,f,h)
    if auto_camera then
        auto_camera=false
        p_map=m
        n_map=nm
        cam_hold=frame+f+h
        cam_sx=sx
        cam_sy=sy
        cam_ex=ex
        cam_ey=ey
        cam_x=cam_sx
        cam_y=cam_sy
        cam_cur_scene=s

        cam_dx=(ex-sx)/f
        cam_dy=(ey-sy)/f
    end
end

function reset_cinematic()
    scene_list={}
end