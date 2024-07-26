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
    local wx=0
    local wy=0
    local wm=0

    if m==1 then
        wm=2
        if sm==0 then
            wx=2*8
            wy=2*8
        elseif sm==1 then
            wx=8*8
            wy=2*8
        elseif sm==2 then
            wx=3*8
            wy=14*8
        elseif sm==3 then
            wx=6*8
            wy=14*8
        elseif sm==4 then
            wx=10*8
            wy=17*8
        elseif sm==5 then
            wx=3*8
            wy=19*8
        elseif sm==6 then
            wx=14*8
            wy=20*8
        end
    elseif m==2 then
        if player.y<3*8 then
            if player.x>6*8 then
                player.submap=1
                wx=42*8
                wy=13*8
                wm=1
            else
                player.submap=0
                wx=42*8
                wy=13*8
                wm=1
            end
        elseif player.y<15*8 then
            if player.x<2*8 then
            elseif player.x<4*8 then
                player.submap=2
                wx=42*8
                wy=13*8
                wm=1
            elseif player.x<8*8 then
                player.submap=3
                wx=42*8
                wy=13*8
                wm=1
            else
            end
        elseif player.y<21*8 then
            if player.x<5*8 then
                player.submap=5
                wx=42*8
                wy=13*8
                wm=1
            elseif player.x<12*8 then
                player.submap=4
                wx=42*8
                wy=13*8
                wm=1
            else
                player.submap=6
                wx=42*8
                wy=13*8
                wm=1
            end
        else
        end
    end
    player.warp={x=wx,y=wy,map=wm}
end