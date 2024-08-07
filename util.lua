function init_timer()
    frame=0
    overworld_timer=0
end

function collide(flag)
    hb={
        [0]={p_x-1,p_x,p_y+2,p_y+p_h-2},
        {p_x+p_w,p_x+p_w+1,p_y+2,p_y+p_h-2},
        {p_x+2,p_x+p_w-2,p_y-1,p_y},
        {p_x+2,p_x+p_w-2,p_y+p_h,p_y+p_h+1}
    }

    hb_x1,hb_x2,hb_y1,hb_y2=unpack(hb[p_dir])

    if flag==0 and collide_npc() then
        return true
    end
    
    if fget(mget(hb_x1/8,hb_y1/8), flag)
    or fget(mget(hb_x1/8,hb_y2/8), flag)
    or fget(mget(hb_x2/8,hb_y1/8), flag)
    or fget(mget(hb_x2/8,hb_y2/8), flag) then
        return true
    end

    return false
end

function collide_npc()
    for npc in all(active_npc_list) do
        if ((npc[3]<=hb_x1 and hb_x1<=npc[3]+8)
            or (npc[3]<=hb_x2 and hb_x2<=npc[3]+8))
        and ((npc[4]<=hb_y1 and hb_y1<=npc[4]+8)
            or (npc[4]<=hb_y2 and hb_y2<=npc[4]+8)) then
            return npc[1]
        end
    end
    return false
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
        for npc in all(active_npc_list) do
            if npc[2]==105 then
                npc[2]=106
            elseif npc[2]==106 then
                npc[2]=105
            end
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
        event_flags[i]=peek(0x5e3f+i)==1
    end
    for i=0,14 do
        vals[i]=peek4(0x5e00+i*4)
    end
    p_x,p_y,p_max_hp,p_hp,p_heal_packs,p_heal_rate,p_atk,p_def,p_speed,p_level,p_xp,p_level_up,p_map,p_submap,p_homesick,p_sp,p_state=unpack(vals,0)
    p_sp,p_state=64,0
    set_map(p_map)
end