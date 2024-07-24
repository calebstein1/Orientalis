--[[
0 combat
1 indoor house
2 outdoor chapter 1
3 chapter 1 cave
]]

function draw_map()
    m=player.map

    if m==0 then
        -- Combat map
    elseif m==1 then
        map_d={
            x_start=34*8,
            x_end=50*8,
            y_start=0,
            y_end=16*8
        }
    elseif m==2 then
        map_d={
            x_start=0,
            x_end=34*8,
            y_start=0,
            y_end=28*8
        }
    end
end