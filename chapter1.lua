function init_c1_enemies()
    enemies={
        {},
        {
            name="the feral cat",
            max_hp=5,
            hp=5,
            atk=2,
            def=0,
            speed=6,
            xp=3,
            atk_str={"scratches at "..player.name,"with its sharp claws"}
        },
        {
            name="the cave mole",
            max_hp=7,
            hp=7,
            atk=3,
            def=0,
            speed=6,
            xp=8,
            atk_str={"throws a rock at",player.name.."'s head"}
        },
        {},
        {
            name="the giant killer wasp",
            max_hp=4,
            hp=4,
            atk=8,
            def=0,
            speed=8,
            xp=11,
            atk_str={"charges "..player.name.." with","its stinger"}
        },
        {
            name="the cave rat",
            max_hp=3,
            hp=3,
            atk=1,
            def=0,
            speed=4,
            xp=2,
            atk_str={"tries to bite at",player.name}
        }
    }
end

function start_chapter1()
    player.x=ttop(35)
    player.y=ttop(1)
    player.map=1
    player.submap=1
    player.state=3
    player.chapter=1
    player.sp=89
    init_c1_enemies()
    overworld_timer=frame
end

function check_chapter1_events()
    if not player.event_flags[1] and frame-overworld_timer>120 then
        intro_cutscene()
    end
end

function chapter1_dialog()
    if frame<dialog_finished+30 then
        return
    end

    local dia={}
    if player.submap==2 and in_range(player.x,ttop(45),ttop(48)) and in_range(player.y,ttop(1),ttop(4)) then
        dia=strings[1]
    elseif in_range(player.x,ttop(1),ttop(4)) and in_range(player.y,ttop(15),ttop(18)) then
        dia=strings[2]
    elseif in_range(player.x,ttop(26),ttop(29)) and in_range(player.y,ttop(13),ttop(16)) then
        dia=strings[3]
    elseif player.submap==3 and in_range(player.x,ttop(41),ttop(44)) and in_range(player.y,ttop(10),ttop(13)) then
        dia=strings[4]
    elseif in_range(player.x,ttop(3),ttop(6)) and in_range(player.y,ttop(18),ttop(21)) then
        dia=strings[5]
    elseif in_range(player.x,ttop(42),ttop(45)) and in_range(player.y,ttop(17),ttop(20)) then
        dia=strings[6]
    elseif player.submap==1 and in_range(player.x,ttop(43),ttop(46)) and in_range(player.y,ttop(3),ttop(6)) then
        if not player.event_flags[2] then
            player.event_flags[2]=true
            dia=strings[7]
            player.heal_packs+=3
        else
            dia=strings[8]
        end
    elseif not player.event_flags[3] and in_range(player.x,ttop(57),ttop(60)) and in_range(player.y,ttop(54),ttop(57)) then
        player.event_flags[3]=true
        dia=strings[9]
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
        spr(42,ttop(48),ttop(1),1,2)
        spr(42,ttop(35),ttop(10),1,2)
        spr(115,ttop(45),ttop(4))
        spr(73,ttop(36),ttop(12))
    elseif sm==2 then
        spr(112,ttop(46),ttop(2))
    elseif sm==3 then
        spr(112,ttop(42),ttop(11))
    end
end

function intro_cutscene()
    player.x=ttop(36)
    player.y=ttop(2)
    player.state=0
    player.dir=1
    player.event_flags[1]=true
end