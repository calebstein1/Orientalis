function init_player() 
    player={
        sp=192,
        x=36*8,
        y=4*8,
        speed=0.5,
        w=8,
        h=8,
        anim=0,
        flp=false,
        --[[
        state:
        0 idle
        1 walking
        2 cutscene
        3 combat
        ]]
        state=0,
        hp=10,
        pp=10,
        atk=2,
        def=1,
        mag=1,
        chapter=1,
        map=1
    }
end