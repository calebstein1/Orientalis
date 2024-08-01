function play_music_for_location()
    if not music_playing then
        music_playing=true

        if p_map==4 then
            music(0,300)
        end
    end
end

function stop_music()
    music_playing=false
    music(-1,300)
end