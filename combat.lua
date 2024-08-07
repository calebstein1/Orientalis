function init_enemies()
    e_name={"the giant mole","the feral cat","the cave mole","","the killer wasp","the cave rat","","","","","the high shaman"}
    e_max_hp={20,5,7,0,4,3,0,0,0,0,22}
    e_hp={20,5,7,0,4,3,0,0,0,0,22}
    e_atk={5,2,3,0,8,1,0,0,0,0,8}
    e_def={1,0,0,0,0,0,0,0,0,0,0}
    e_speed={4,6,6,0,8,6,0,0,0,0,7}
    e_xp={25,3,8,0,11,2,0,0,0,0,50}
    e_atk_str={
        {"tears into tara","with its brutal claws"},
        {"scratches at tara","with its sharp claws"},
        {"throws a rock at tara's head"},
        {},
        {"charges tara with","its stinger"},
        {"tries to bite at","tara"},
        {},
        {},
        {},
        {},
        {"strikes tara with","a magic bolt"}
    }
end

function engage_combat(e)
    p_wx,p_wy,p_wm,p_state,p_x,p_y,p_flp,p_map,c_state,c_str,e_id=p_x/8,p_y/8,p_map,4,16,96,false,0,0,0,e
end

function print_combat_string(s)
    if s==0 then
        print("tara is attacked by",32,8,7)
        print(e_name[e_id].."!",32,16,7)
    elseif s==1 then
        print("what will you do?",32,8,7)
        print("attack",24,96,7)
        print("+ kit X"..p_heal_packs,72,96,7)
    elseif s==2 then
        local i=16
        print(e_name[e_id],32,8,7)
        for str in all(e_atk_str[e_id]) do
            print(str,32,i,7)
            i+=8
        end
        print("tara takes "..damage.." damage!",32,i+8,7)
    elseif s==3 then
        print(e_name[e_id].." is",32,8,7)
        print("defeated!",32,16,11)
        print("tara gains "..e_xp[e_id].."xp!",32,32,7)
    elseif s==4 then
        print("tara collapses from", 32,8,7)
        print(e_name[e_id].."'s",32,16,7)
        print("attack!", 32,24,7)
        print("tara is defeated!",32,40,8)
    elseif s==5 then
        print("tara strikes",32,8,7)
        print(e_name[e_id].." for "..damage,32,16,7)
        print("damage!",32,24,7)
    elseif s==6 then
        print("tara patches her",32,8,7)
        print("wounds with a",32,16,7)
        print("first aid kit!",32,24,7)
    elseif s==7 then
        print("tara levels up!",32,8,7)
    end
end

function advance_combat()
    local mod=.85+rnd(.15)

    if c_state==0 then
        if e_speed[e_id]>p_speed then
            c_state=2
        else
            c_state=1
        end
    end

    if c_state==1 then
        damage=flr(flr(((p_atk-e_def[e_id])*mod)+.5)/(p_homesick+1)+.5)
        player_turn()
    elseif c_state==2 then
        damage=flr(((e_atk[e_id]-p_def)*mod)+.5)
        enemy_turn()
    elseif c_state==3 then
        e_hp[e_id]=e_max_hp[e_id]
        player_victory()
    elseif c_state==4 then
        e_hp[e_id]=e_max_hp[e_id]
        game_over()
    elseif c_state==5 then
        player_result()
    elseif c_state==6 then
        player_death()
    end
    sfx(0)
end

function player_turn()
    c_str=1
    c_state=5
end

function player_death()
    c_str=4
    c_state=4
end

function player_result()
    if p_x==16 then
        e_hp[e_id]-=damage
        c_str=5
    elseif p_x==64 then
        if p_heal_packs==0 then
            return
        else
            c_str=6
            p_hp+=p_heal_rate
            if p_hp>p_max_hp then
                p_hp=p_max_hp
            end
            p_heal_packs-=1
        end
    end
    if e_hp[e_id]<=0 then
        c_str=3
        c_state=3
    else
        c_state=2
    end
end

function enemy_turn()
    p_hp-=damage
    if p_hp<=0 then
        c_str=2
        c_state=6
    else
        c_str=2
        c_state=1
    end
end

function player_victory()
    p_xp+=e_xp[e_id]
    if p_xp>=p_level_up then
        level_up()
        c_str=7
        c_state=3
    else
        end_combat()
    end
end

function level_up()
    p_level_up+=flr(p_level_up*.5+8*p_level)
    p_level+=1
    p_max_hp+=2+flr(rnd(5))
    if p_level%2==0 then
        p_atk+=1
    end
    if p_level%5==0 then
        p_def+=1
    end
    if p_level%3==0 then
        p_speed+=1
    end
    p_hp=p_max_hp
end

function end_combat()
    p_cooldown=frame+180
    p_state=0
    warp_player()
end