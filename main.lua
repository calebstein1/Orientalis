function _init()
    frame=0
    overworld_timer=0
    poi_sp=105
    init_dialog()
    init_player()
    load_strings()
end

function _update()
    if frame==32000 then
        reset_timer()
    else
        frame+=1
        if frame%20==0 then
            if poi_sp==105 then
                poi_sp=106
            else
                poi_sp=105
            end
        end
    end
    set_map()
    set_camera()
    update_player()
end

function _draw()
    cls()
    map(0,0)
    draw_sprites()
    draw_dialog()
end