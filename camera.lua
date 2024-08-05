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
    cam_x=p_x-64+(p_w/2)
    if cam_x<m_xs[p_map] then
        cam_x=m_xs[p_map]
    end
    if cam_x>m_xe[p_map]-128 then
        cam_x=m_xe[p_map]-128
    end

    cam_y=p_y-64+(p_h/2)
    if cam_y<m_ys[p_map] then
        cam_y=m_ys[p_map]
    end
    if cam_y>m_ye[p_map]-128 then
        cam_y=m_ye[p_map]-128
    end
end

function pan_cam(sx,sy,ex,ey,m,nm,s,f,h)
    if auto_camera then
        auto_camera,p_map,n_map,cam_hold,cam_sx,cam_sy,cam_ex,cam_ey,cam_x,cam_y,cam_cur_scene,cam_dx,cam_dy=false,m,nm,frame+f+h,sx,sy,ex,ey,sx,sy,s,(ex-sx)/f,(ey-sy)/f
    end
end

function reset_cinematic()
    scene_list={}
end