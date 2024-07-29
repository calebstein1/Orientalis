function _init()
    frame=0
    overworld_timer=0
    init_dialog()
    init_player()
    load_strings()
end

function _update()
    frame+=1
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