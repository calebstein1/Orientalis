function _init()
    init_player()
    draw_map()
end

function _update()
    set_camera()
end

function _draw()
    cls()
    map(0,0)
    draw_sprites()
end