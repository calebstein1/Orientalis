function _init()
    init_player()
end

function _update()
    set_map()
    set_camera()
    update_player()
end

function _draw()
    cls()
    map(0,0)
    draw_sprites()
end