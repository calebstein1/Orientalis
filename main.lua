function _init()
    frame=0
    init_player()
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
end