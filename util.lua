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
        y1=y+2
        y2=y+h-2
    elseif dir==1 then
        x1=x+w
        x2=x+w+1
        y1=y+2
        y2=y+h-2
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
    7 lush cave
    ]]
    if p==0 then
        return
    elseif p==1 then
        pal(4,5)
        pal(11,1)
    elseif p==2 then
        pal(3,6)
        pal(11,4)
    elseif p==3 then
        pal(11,5)
        pal(3,4)
    elseif p==4 then
    elseif p==5 then
        pal(3,6)
        pal(11,7)
    elseif p==6 then
        pal(11,6)
    elseif p==7 then
        pal(11,5)
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
    player.a_over=117
end

function knockback(f)
    if player.dir==0 then
        player.x+=f
    elseif player.dir==1 then
        player.x-=f
    elseif player.dir==2 then
        player.y+=f
    elseif player.dir==3 then
        player.y-=f
    end
end

function reset_timer()
    frame=0
    overworld_timer=0
    player.anim=0
    player.cooldown=0
end

function save_game()
    local i=16
    dset(0,player.x)
    dset(1,player.y)
    dset(2,player.max_hp)
    dset(3,player.hp)
    dset(4,player.heal_packs)
    dset(5,player.heal_rate)
    dset(6,player.atk)
    dset(7,player.def)
    dset(8,player.speed)
    dset(9,player.level)
    dset(10,player.xp)
    dset(11,player.level_up)
    dset(12,player.map)
    dset(13,player.submap)
    dset(14,player.chapter)
    for f in all(pevent_flags) do
        if f then
            dset(i,1)
        else
            dset(i,0)
        end
        i+=1
    end
    dset(15,i-16)
end

function load_game()
    local c=15
    for i=1,dget(c) do
        c+=1
        if dget(c)==1 then
            event_flags[i]=true
        end
    end
    player.x=dget(0)
    player.y=dget(1)
    player.max_hp=dget(2)
    player.hp=dget(3)
    player.heal_packs=dget(4)
    player.heal_rate=dget(5)
    player.atk=dget(6)
    player.def=dget(7)
    player.speed=dget(8)
    player.level=dget(9)
    player.xp=dget(10)
    player.level_up=dget(11)
    player.map=dget(12)
    player.submap=dget(13)
    player.chapter=dget(14)
    player.sp=64
    player.state=0
end