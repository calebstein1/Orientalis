function collide(dir,flag)
    local x1
    local x2
    local y1
    local y2

    if dir==0 then
        x1=p_x-1
        x2=p_x
        y1=p_y+2
        y2=p_y+p_h-2
    elseif dir==1 then
        x1=p_x+p_w
        x2=p_x+p_w+1
        y1=p_y+2
        y2=p_y+p_h-2
    elseif dir==2 then
        x1=p_x+2
        x2=p_x+p_w-2
        y1=p_y-1
        y2=p_y
    elseif dir==3 then
        x1=p_x+2
        x2=p_x+p_w-2
        y1=p_y+p_h
        y2=p_y+p_h+1
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
    pal()
    pal(color_palette,1)
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
    elseif p==2 then
        pal(3,6)
    elseif p==3 then
        pal(3,4)
    elseif p==5 then
        pal(3,6)
    end
end

function main_menu()
    p_state=8
    p_map=4
    p_x=ttop(55)+4
    p_y=ttop(6)
    p_a_over=117
end

function knockback(f)
    if p_dir==0 then
        p_x+=f
    elseif p_dir==1 then
        p_x-=f
    elseif p_dir==2 then
        p_y+=f
    elseif p_dir==3 then
        p_y-=f
    end
end

function update_poi_sprite()
    if frame%20==0 then
        if poi_sp==105 then
            poi_sp=106
        else
            poi_sp=105
        end
    end
end

function increment_or_reset_timer()
    if frame==32000 then
        frame=0
        overworld_timer=0
        p_anim=0
        p_cooldown=0
    else
        frame+=1
    end
end

function save_game()
    local i=16
    dset(0,p_x)
    dset(1,p_y)
    dset(2,p_max_hp)
    dset(3,p_hp)
    dset(4,p_heal_packs)
    dset(5,p_heal_rate)
    dset(6,p_atk)
    dset(7,p_def)
    dset(8,p_speed)
    dset(9,p_level)
    dset(10,p_xp)
    dset(11,p_level_up)
    dset(12,p_map)
    dset(13,p_submap)
    dset(15,p_homesick)
    for f in all(event_flags) do
        if f then
            dset(i,1)
        else
            dset(i,0)
        end
        i+=1
    end
end

function load_game()
    for i=1,num_event_flags do
        if dget(i+15)==1 then
            event_flags[i]=true
        end
    end
    p_x=dget(0)
    p_y=dget(1)
    p_max_hp=dget(2)
    p_hp=dget(3)
    p_heal_packs=dget(4)
    p_heal_rate=dget(5)
    p_atk=dget(6)
    p_def=dget(7)
    p_speed=dget(8)
    p_level=dget(9)
    p_xp=dget(10)
    p_level_up=dget(11)
    p_map=dget(12)
    p_submap=dget(13)
    p_homesick=dget(15)
    p_sp=64
    p_state=0
end