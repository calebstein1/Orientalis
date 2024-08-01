function play_music_for_location()
    if not music_playing then
        music_playing=true
        local m

        if p_map==0 then
            m=-1
        elseif p_map==1 then
            m=-1
        elseif p_map==2 then
            m=-1
        elseif p_map==3 then
            m=-1
        elseif p_map==4 then
            if p_state==7 then
                m=-1
            else
                m=0
            end
        elseif p_map==5 then
            m=-1
        elseif p_map==6 then
            m=-1
        elseif p_map==7 then
            m=-1
        elseif p_map==8 then
            m=-1
        elseif p_map==9 then
            m=-1
        end

        music(m,300)
    end
end

function stop_music()
    music_playing=false
    music(-1,300)
end