function engage_combat(e)
    --[[
    c_state values:
    0: intro
    1: player turn
    2: enemy turn
    3: player victory
    4: player defeat
    5: player turn result
    6: game over message
    ]]
    p_wx=ptot(p_x)
    p_wy=ptot(p_y)
    p_wm=p_map
    p_state=4
    p_x=ttop(2)
    p_y=ttop(12)
    p_flp=false
    p_map=0
    c_state=0
    c_str=0
    e_id=e
end

function print_combat_string(s)
    if s==0 then
        print(p_name.." is attacked by",ttop(4),ttop(1),7)
        print(enemies[e_id].name.."!",ttop(4),ttop(2),7)
    elseif s==1 then
        print("what will you do?",ttop(4),ttop(1),7)
        print("attack",ttop(3),ttop(12),7)
        print("+ kit X"..p_heal_packs,ttop(9),ttop(12),7)
    elseif s==2 then
        local i=2
        print(enemies[e_id].name,ttop(4),ttop(1),7)
        for str in all(enemies[e_id].atk_str) do
            print(str,ttop(4),ttop(i),7)
            i+=1
        end
        print(p_name.." takes "..damage.." damage!",ttop(4),ttop(i+1),7)
    elseif s==3 then
        print(enemies[e_id].name.." is",ttop(4),ttop(1),7)
        print("defeated!",ttop(4),ttop(2),11)
        print(p_name.." gains "..enemies[e_id].xp.."xp!",ttop(4),ttop(4),7)
    elseif s==4 then
        print(p_name.." collapses from", ttop(4),ttop(1),7)
        print(enemies[e_id].name.."'s",ttop(4),ttop(2),7)
        print("attack!", ttop(4),ttop(3),7)
        print(p_name.." is defeated!",ttop(4),ttop(5),8)
    elseif s==5 then
        print(p_name.." strikes",ttop(4),ttop(1),7)
        print(enemies[e_id].name.." for "..damage,ttop(4),ttop(2),7)
        print("damage!",ttop(4),ttop(3),7)
    elseif s==6 then
        print(p_name.." patches her",ttop(4),ttop(1),7)
        print("wounds with a",ttop(4),ttop(2),7)
        print("first aid kit!",ttop(4),ttop(3),7)
    elseif s==7 then
        print(p_name.." levels up!",ttop(4),ttop(1),7)
    end
end

function advance_combat()
    local mod=.85+rnd(.15)

    if c_state==0 then
        if enemies[e_id].speed>p_speed then
            c_state=2
        else
            c_state=1
        end
    end

    if c_state==1 then
        damage=flr(((p_atk-enemies[e_id].def)*mod)+.5)
        player_turn()
    elseif c_state==2 then
        damage=flr(((enemies[e_id].atk-p_def)*mod)+.5)
        enemy_turn()
    elseif c_state==3 then
        enemies[e_id].hp=enemies[e_id].max_hp
        player_victory()
    elseif c_state==4 then
        enemies[e_id].hp=enemies[e_id].max_hp
        game_over()
    elseif c_state==5 then
        player_result()
    elseif c_state==6 then
        player_death()
    end
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
    if p_x==ttop(2) then
        enemies[e_id].hp-=damage
        c_str=5
    elseif p_x==ttop(8) then
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
    if enemies[e_id].hp<=0 then
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
    p_xp+=enemies[e_id].xp
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
    p_cooldown=frame+90
    p_state=0
    warp_player()
end