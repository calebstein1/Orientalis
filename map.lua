--[[
0 combat
1 indoor house
2 outdoor chapter 1
3 chapter 1 cave
]]

function set_map()
    local m=player.map

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

function set_warp()
    local m=player.map
    local sm=player.submap

    if m==1 then
        player.warp_map=2
        if sm==0 then
            player.warp_x=2*8
            player.warp_y=2*8
        elseif sm==1 then
            player.warp_x=8*8
            player.warp_y=2*8
        elseif sm==2 then
            player.warp_x=3*8
            player.warp_y=14*8
        elseif sm==3 then
            player.warp_x=6*8
            player.warp_y=14*8
        elseif sm==4 then
            player.warp_x=10*8
            player.warp_y=17*8
        elseif sm==5 then
            player.warp_x=3*8
            player.warp_y=19*8
        elseif sm==6 then
            player.warp_x=14*8
            player.warp_y=20*8
        end
    elseif m==2 then
        if player.y<3*8 then
            if player.x>6*8 then
                player.warp_map=1
                player.submap=1
                player.warp_x=42*8
                player.warp_y=6*8
            else
                player.warp_map=1
                player.submap=0
                player.warp_x=42*8
                player.warp_y=6*8
            end
        elseif player.y<15*8 then
            if player.x<2*8 then
            elseif player.x<4*8 then
                player.warp_map=1
                player.submap=2
                player.warp_x=42*8
                player.warp_y=6*8
            elseif player.x<8*8 then
                player.warp_map=1
                player.submap=3
                player.warp_x=42*8
                player.warp_y=6*8
            else
            end
        elseif player.y<21*8 then
            if player.x<5*8 then
                player.warp_map=1
                player.submap=5
                player.warp_x=42*8
                player.warp_y=6*8
            elseif player.x<12*8 then
                player.warp_map=1
                player.submap=4
                player.warp_x=42*8
                player.warp_y=6*8
            else
                player.warp_map=1
                player.submap=6
                player.warp_x=42*8
                player.warp_y=6*8
            end
        else
        end
    end
end