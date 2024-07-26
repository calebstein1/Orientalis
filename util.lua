function draw_sprites()
    m=player.map
    sm=player.submap

    if m==0 then
        -- Combat map
    elseif m==1 then
        pal(11,4)
        draw_map1_interior(sm)
    elseif m==2 then
        pal(11,11)
        if player.chapter==1 then
            spr(241,ttop(2),ttop(16))
        end
        spr(242,ttop(27),ttop(14))
    elseif m==4 then
        pal(11,6)
        spr(13,ttop(56),0)
        spr(13,ttop(55),ttop(1))
        spr(13,ttop(54),ttop(2))
        spr(13,ttop(53),ttop(3))
        spr(13,ttop(59),0,1,1,true)
        spr(13,ttop(60),ttop(1),1,1,true)
        spr(13,ttop(61),ttop(2),1,1,true)
        spr(13,ttop(62),ttop(3),1,1,true)
        spr(player.sp+1,player.x+8,player.y,1,1,player.flp)
        spr(player.head,player.x+16,player.y,1,1,player.flp)
        print("game over!",ttop(55)+4,ttop(4),1)
    end
    spr(player.sp,player.x,player.y,1,1,player.flp)
end

function collide(obj,dir,flag)
    local x=obj.x
    local y=obj.y
    local w=obj.w
    local h=obj.h

    local x1=0
    local x2=0
    local y1=0
    local y2=0

    if dir==0 then
        x1=x-1
        x2=x
        y1=y
        y2=y+h-1
    elseif dir==1 then
        x1=x+w
        x2=x+w+1
        y1=y
        y2=y+h-1
    elseif dir==2 then
        x1=x+2
        x2=x+w-2
        y1=y-1
        y2=y
    elseif dir==3 then
        x1=x+2
        x2=x+w-2
        y1=y+h
        y2=y+h+1
    end

    x1=ptot(x1)
    x2=ptot(x2)
    y1=ptot(y1)
    y2=ptot(y2)

    if fget(mget(x1,y1), flag)
    or fget(mget(x1,y2), flag)
    or fget(mget(x2,y1), flag)
    or fget(mget(x2,y2), flag) then
        return true
    else
        return false
    end
end

-- Tile to Pixel
function ttop(n)
    return n*8
end

-- Pixel to Tile
function ptot(n)
    return n/8
end