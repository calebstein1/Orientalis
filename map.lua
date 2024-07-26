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
            x_start=ttop(34),
            x_end=ttop(50),
            y_start=0,
            y_end=ttop(16)
        }
    elseif m==2 then
        map_d={
            x_start=0,
            x_end=ttop(34),
            y_start=0,
            y_end=ttop(28)
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
            wx=2
            wy=2
        elseif sm==1 then
            wx=8
            wy=2
        elseif sm==2 then
            wx=3
            wy=14
        elseif sm==3 then
            wx=6
            wy=14
        elseif sm==4 then
            wx=10
            wy=17
        elseif sm==5 then
            wx=3
            wy=19
        elseif sm==6 then
            wx=14
            wy=20
        end
    elseif m==2 then
        if player.y<ttop(3) then
            if player.x>ttop(6) then
                player.submap=1
                wx=42
                wy=13
                wm=1
            else
                player.submap=0
                wx=42
                wy=13
                wm=1
            end
        elseif player.y<ttop(15) then
            if player.x<ttop(2) then
            elseif player.x<ttop(4) then
                player.submap=2
                wx=42
                wy=13
                wm=1
            elseif player.x<ttop(8) then
                player.submap=3
                wx=42
                wy=13
                wm=1
            else
            end
        elseif player.y<ttop(21) then
            if player.x<ttop(5) then
                player.submap=5
                wx=42
                wy=13
                wm=1
            elseif player.x<ttop(12) then
                player.submap=4
                wx=42
                wy=13
                wm=1
            else
                player.submap=6
                wx=42
                wy=13
                wm=1
            end
        else
        end
    end
    player.warp={x=ttop(wx),y=ttop(wy),map=wm}
end