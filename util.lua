function collide(dir,flag)
    local hb={
        [0]={p_x-1,p_x,p_y+2,p_y+p_h-2},
        {p_x+p_w,p_x+p_w+1,p_y+2,p_y+p_h-2},
        {p_x+2,p_x+p_w-2,p_y-1,p_y},
        {p_x+2,p_x+p_w-2,p_y+p_h,p_y+p_h+1}
    }

    local x1,x2,y1,y2=unpack(hb[dir])
    
    x1/=8
    x2/=8
    y1/=8
    y2/=8

    if fget(mget(x1,y1), flag)
    or fget(mget(x1,y2), flag)
    or fget(mget(x2,y1), flag)
    or fget(mget(x2,y2), flag) then
        return true
    else
        return false
    end
end

function in_range(xl,xh,yl,yh)
    if xl<p_x and p_x<xh and yl<p_y and p_y<yh then
        return true
    end
    return false
end

function set_colors(p)
    pal()
    pal(color_palette,1)
    if p==0 then
        return
    elseif p==1 then
        pal(4,5)
    elseif p==3 then
        pal(3,4)
    elseif p==5 then
        pal(3,6)
    end
end

function main_menu()
    p_state=8
    p_map=4
    p_x=444
    p_y=48
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
        poi_sp=poi_sp==105 and 106 or 105
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
    local i=1
    poke4(0x5e00,p_x,p_y,p_max_hp,p_hp,p_heal_packs,p_heal_rate,p_atk,p_def,p_speed,p_level,p_xp,p_level_up,p_map,p_submap,p_homesick)
    for f in all(event_flags) do
        poke(0x5e3f+i,tonum(f))
        i+=1
    end
end

function load_game()
    local vals={}
    for i=1,num_event_flags do
        event_flags[i]=peek(0x5e3f+i)==1 and true or false
    end
    for i=0,14 do
        vals[i]=peek4(0x5e00+i*4)
    end
    p_x,p_y,p_max_hp,p_hp,p_heal_packs,p_heal_rate,p_atk,p_def,p_speed,p_level,p_xp,p_level_up,p_map,p_submap,p_homesick,p_sp,p_state=unpack(vals,0)
    p_sp,p_state=64,0
end