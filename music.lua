--[[
Music tracks:
0 main theme
2 outdoor normal
4 cave
5 daybreak
6 game over
]]
music_tracks={-1,2,4,0,2,4,-1,-1,2,2,-1,-1}

function play_music_for_location()
    if not music_playing and frame-overworld_timer>=15 then
        music_playing=true
        music(music_tracks[p_map],500)
    end
end

function play_music(t,f)
    if not music_playing then
        music_playing=true
        music(t,f)
    end
end

function stop_music()
    overworld_timer=frame
    music_playing=false
    music(-1,500)
end