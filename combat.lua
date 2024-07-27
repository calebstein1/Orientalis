function engage_combat(e)
    --[[
    c_state values:
    0: intro
    1: player turn
    2: enemy turn
    3: player victory
    4: player defeat
    5: player turn result
    ]]
    player.warp={x=player.x-16,y=player.y-16,map=player.map}
    player.state=4
    player.x=ttop(2)
    player.y=ttop(12)
    player.flp=false
    player.map=0
    c_state=0
    c_str=0
    e_id=e
    e_def=0
end

function print_combat_string(s)
    if s==0 then
        print(player.name.." is attacked by",ttop(4),ttop(1),7)
        print(enemies[e_id].name.."!",ttop(4),ttop(2),7)
    elseif s==1 then
        print("what will you do?",ttop(4),ttop(1),7)
        print("attack",ttop(3),ttop(12),7)
        print("defend",ttop(9),ttop(12),7)
    elseif s==2 then
        print(enemies[e_id].name,ttop(4),ttop(1),7)
        for i, str in pairs(enemies[e_id].atk_str) do
            print(str,ttop(4),ttop(2+(i-1)),7)
        end
    elseif s==3 then
        print(enemies[e_id].name.." was", ttop(4),ttop(1),7)
        print("defeated!",ttop(4),ttop(2),7)
    elseif s==4 then
        print(player.name.." collapsed from", ttop(4),ttop(1),7)
        print(enemies[e_id].name.."'s attack!", ttop(4),ttop(2),7)
    elseif s==5 then
        print(player.name.." strikes",ttop(4),ttop(1),7)
        print(enemies[e_id].name.."!",ttop(4),ttop(2),7)
    elseif s==6 then
        print(player.name.." readies her",ttop(4),ttop(1),7)
        print("stance!",ttop(4),ttop(2),7)
    end
end

function advance_combat()
    if c_state==0 then
        if enemies[e_id].speed > player.speed then
            c_state=2
        else
            c_state=1
        end
    end

    if c_state==1 then
        player_turn()
    elseif c_state==2 then
        enemy_turn()
    elseif c_state==3 then
        enemies[e_id].hp=enemies[e_id].max_hp
        player_victory()
    elseif c_state==4 then
        enemies[e_id].hp=enemies[e_id].max_hp
        game_over()
    elseif c_state==5 then
        player_result()
    end
end

function player_turn()
    c_str=1
    c_state=5
end

function player_result()
    if player.x==ttop(2) then
        enemies[e_id].hp-=(player.atk-enemies[e_id].def)
        c_str=5
    elseif player.x==ttop(8) then
        e_def+=1
        c_str=6
    end
    if enemies[e_id].hp<=0 then
        c_str=3
        c_state=3
    else
        c_state=2
    end
end

function enemy_turn()
    player.hp-=(enemies[e_id].atk-player.def-e_def)
    if e_def>0 then
        e_def=0
    end
    if player.hp<=0 then
        c_str=4
        c_state=4
    else
        c_str=2
        c_state=1
    end
end

function player_victory()
    player.xp+=enemies[e_id].xp
    player.state=0
    warp_player(player.warp)
end