function init_player() 
    player={
        sp=192,
        x=36*8,
        y=4*8,
        speed=1,
        w=8,
        h=8,
        anim=0,
        flp=false,
        --[[
        facing:
        0 down
        1 up
        ]]
        facing=0,
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

function update_player()
    player_controls()
    animate_player()
end

function player_controls()
    if player.state==0 or player.state==1 then
        if not btn(0)
        and not btn(1)
        and not btn(2)
        and not btn(3) then
            player.state=0
        end
        if btn(0) then
            player.state=1
            player.x-=player.speed
        end
        if btn(1) then
            player.state=1
            player.x+=player.speed
        end
        if btn(2) then
            player.state=1
            player.facing=1
            player.y-=player.speed
        end
        if btn(3) then
            player.state=1
            player.facing=0
            player.y+=player.speed
        end
    end
end

function animate_player()
    if player.state==0 then
        if player.facing==0 then
            player.sp=192
        elseif player.facing==1 then
            player.sp=208
        end
    elseif player.state==1 and time()-player.anim>0.3 then
        do_walk_anim()
        player.anim=time()
    end
end

function do_walk_anim()
    if player.facing==0 then
        if player.sp==193 then
            player.sp=194
        else
            player.sp=193
        end
    elseif player.facing==1 then
        if player.sp==209 then
            player.sp=210
        else
            player.sp=209
        end
    end
end