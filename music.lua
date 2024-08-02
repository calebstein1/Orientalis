music_tracks={[0]=-1,-1,2,4,0,-1,4,0,-1,-1}

function play_music_for_location()
    if event_flags[3] then
        music_tracks[7]=-1
    end
    if p_state==7 then
        music_tracks[4]=-1
    else
        music_tracks[4]=0
    end

    if not music_playing and frame-overworld_timer>=15 then
        music_playing=true
        music(music_tracks[p_map],500)
    end
end

function stop_music()
    overworld_timer=frame
    music_playing=false
    music(-1,500)
end

function play_music(t,f)
    if not music_playing then
        music_playing=true
        music(t,f)
    end
end