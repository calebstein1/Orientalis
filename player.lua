function init_player() 
    player={
        sp=192,
        x=0,
        y=0,
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
        ]]
        state=0,
        chapter=1,
        map=1
    }
end