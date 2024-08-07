function _init()
    cartdata("calebstein1_terradestined_1")
    poke(0x5f2e, 1)
    init_timer()
    init_dialog()
    init_music()
    init_camera()
    init_map()
    init_player()
    init_npc()
    init_combat()
    load_strings()
end

function _update60()
    increment_or_reset_timer()
    set_camera()
    update_player()
    update_poi_sprite()
end

function _draw()
    cls(bg)
    map()
    draw_sprites()
    draw_active_npc()
    draw_dialog()
end