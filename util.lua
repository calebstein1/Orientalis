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
        if player.go_spr>0.5 then
            spr(224,ttop(57),ttop(4),3,1)
            spr(player.a_over,ttop(59),ttop(4))
        else
            spr(201,ttop(57),ttop(4),3,1)
            spr(player.a_over,ttop(57),ttop(4))
        end
        print("game over!",ttop(55)+6,ttop(2),1)
    else
        spr(197,ttop(57),ttop(2)+6,2,3)
        spr(player.a_over,ttop(58),ttop(3)+5)
        print("terradestined",ttop(54)+6,ttop(2),1)
    end
    print("NEW GAME",ttop(56)+4,ttop(6),1)
    print("CONTINUE",ttop(56)+4,ttop(7),1)
end

function draw_game_over()
    draw_map4_border()
    spr(199,ttop(57),ttop(8)-1,2,2)
    spr(player.a_over,ttop(57),ttop(8)-1)
    print("you can do this,",ttop(54)+2,ttop(2),1)
    print(player.name..", the world",ttop(54)+2,ttop(3),1)
    print("is counting on you!",ttop(54)+2,ttop(4),1)
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