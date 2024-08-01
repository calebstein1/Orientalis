function _init()
    cartdata("calebstein1_terradestined_1")
    poke(0x5f2e, 1)
    color_palette={[0]=0,129,2,131,4,5,6,7,136,137,10,139,140,13,142,143}
    bg=0
    music_playing=false
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
    set_camera()
    update_player()
    set_bg()
    play_music_for_location()
end

function _draw()
    cls(bg)
    map(0,0)
    draw_sprites()
    draw_dialog()
end