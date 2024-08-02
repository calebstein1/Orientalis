function _init()
    cartdata("calebstein1_terradestined_1")
    poke(0x5f2e, 1)
    color_palette={[0]=0,129,2,131,4,5,6,7,136,137,10,139,140,13,142,143}
    bg=0
    music_playing=false
    frame=0
    overworld_timer=0
    map_changed=0
    poi_sp=105
    init_dialog()
    init_player()
    init_enemies()
    load_strings()
end

function _update()
    increment_or_reset_timer()
    set_camera()
    update_player()
    update_poi_sprite()
    set_bg()
    play_music_for_location()
end

function _draw()
    cls(bg)
    map(0,0)
    draw_sprites()
    draw_dialog()
end