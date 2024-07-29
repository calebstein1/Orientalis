function init_c1_enemies()
    enemies={
        {
            name="the drunk fisherman",
            max_hp=20,
            hp=20,
            atk=100,
            def=2,
            speed=3,
            xp=20,
            atk_str={"shoots "..player.name.." in","the chest with his","shotgun"}
        },
        {
            name="the feral cat",
            max_hp=5,
            hp=5,
            atk=2,
            def=0,
            speed=6,
            xp=3,
            atk_str={"scratches at "..player.name,"with its sharp claws"}
        }
    }
end

function start_chapter1()
    player.x=ttop(36)
    player.y=ttop(4)
    player.money=100
    player.max_hp=10
    player.hp=player.max_hp
    player.map=1
    player.submap=1
    player.state=0
    player.chapter=1
    init_c1_enemies()
    seen_fisherman=false
end

function check_chapter1_events()
    if player.map==1 and player.submap==7 then
        if not seen_fisherman then
            drunk_fisherman_event()
            seen_fisherman=true
        end
        if seen_fisherman and not dialog_scene then
            engage_combat(player.map)
        end
    end
end

function chapter1_dialog()
    if frame<dialog_finished+30 then
        return
    end

    local dia={}
    if player.submap==4 and in_range(player.x,ttop(45),ttop(48)) and in_range (player.y,ttop(1),ttop(4)) then
        dia=strings[1]
    elseif in_range(player.x,ttop(1),ttop(4)) and in_range(player.y,ttop(15),ttop(18)) then
        dia=strings[2]
    elseif in_range(player.x,ttop(26),ttop(29)) and in_range(player.y,ttop(13),ttop(16)) then
        dia=strings[3]
    elseif in_range(player.x,ttop(3),ttop(6)) and in_range(player.y,ttop(18),ttop(21)) then
        dia=strings[5]
    end
    if dia==nil then
        return
    end
    for d in all(dia) do
        add(dialog_strs,d)
    end
    advance_dialog()
end

function draw_map1_interior(sm)
    if sm==1 then
        spr(44,ttop(39),ttop(1))
        spr(44,ttop(39),ttop(2))
        spr(44,ttop(39),ttop(4))
        spr(44,ttop(39),ttop(5))
        spr(54,ttop(35),ttop(2))
        spr(55,ttop(35),ttop(1))
    elseif sm==4 then
        spr(112,ttop(46),ttop(2))
    elseif sm==7 then
        spr(112,ttop(42),ttop(11))
    end
end

function drunk_fisherman_event()
    local dia=strings[4]
    for d in all(dia) do
        add(dialog_strs,d)
    end
    advance_dialog()
end