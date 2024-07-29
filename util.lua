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

function in_range(n,l,h)
    if l<n and n<h then
        return true
    end
    return false
end

function set_colors(p)
    for i=0,15 do
        pal(i,i)
    end
    --[[
    0 default
    1 outdoor night
    2 indoor house
    3 cave
    4 island
    5 snow
    6 menu
    ]]
    if p==0 then
        return
    elseif p==1 then
        pal(4,5)
        pal(11,1)
    elseif p==2 then
        pal(11,4)
    elseif p==3 then
        pal(11,5)
        pal(3,4)
    elseif p==4 then
    elseif p==5 then
    elseif p==6 then
        pal(11,6)
    end
end

function map_fog()
    rectfill(cam_x,cam_y,player.x-12,cam_y+ttop(16),6)
    rectfill(player.x+player.w+12,cam_y,player.x+ttop(16),cam_y+ttop(16),6)
    rectfill(cam_x,cam_y,cam_x+ttop(16),player.y-12,6)
    rectfill(cam_x,player.y+player.h+12,cam_x+ttop(16),cam_y+ttop(16),6)
end

function main_menu()
    player.state=8
    player.map=4
    player.x=ttop(55)+4
    player.y=ttop(6)
    player.chapter=0
end

function draw_main_menu()
    draw_map4_border()
    if player.game_over then
        spr(96,ttop(57),ttop(4),3,1)
        spr(player.a_over,ttop(59),ttop(4))
        print("game over!",ttop(55)+6,ttop(2),1)
    else
        spr(69,ttop(57),ttop(2)+6,2,3)
        spr(player.a_over,ttop(58),ttop(3)+5)
        print("terradestined",ttop(54)+6,ttop(2),1)
    end
    print("NEW GAME",ttop(56)+4,ttop(6),1)
    print("CONTINUE",ttop(56)+4,ttop(7),1)
end

function draw_game_over()
    draw_map4_border()
    spr(71,ttop(57),ttop(8)-1,2,2)
    spr(player.a_over,ttop(57),ttop(8)-2)
    print("get up, "..player.name..",",ttop(54)+2,ttop(2),1)
    print("the world is",ttop(54)+2,ttop(3),1)
    print("counting on you!",ttop(54)+2,ttop(4),1)
    print("CONTINUE",ttop(56)+4,ttop(6),1)
    print("QUIT",ttop(56)+4,ttop(7),1)
end

function draw_map4_border()
    spr(13,ttop(55),0)
    spr(13,ttop(54),ttop(1))
    spr(13,ttop(53),ttop(2))
    spr(13,ttop(52),ttop(3))
    spr(13,ttop(60),0,1,1,true)
    spr(13,ttop(61),ttop(1),1,1,true)
    spr(13,ttop(62),ttop(2),1,1,true)
    spr(13,ttop(63),ttop(3),1,1,true)
end