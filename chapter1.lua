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
            atk_str={"scratched at "..player.name,"with its sharp claws"}
        }
    }
end

function start_chapter1()
    player.x=ttop(36)
    player.y=ttop(4)
    player.max_hp=10
    player.hp=player.max_hp
    player.map=1
    player.submap=1
    player.state=0
    player.chapter=1
    init_c1_enemies()
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
        spr(240,ttop(46),ttop(2))
    end
end