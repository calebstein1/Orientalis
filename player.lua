function init_player() 
    player={
        name="Terra",
        sp=192,
        x=36*8,
        y=4*8,
        movement=1,
        w=8,
        h=8,
        anim=0,
        flp=false,
        dir=0,
        --[[
        state:
        0 idle
        1 walking
        2 cutscene
        3 combat
        4 dialog
        ]]
        state=0,
        hp=10,
        pp=10,
        atk=2,
        def=1,
        speed=5,
        mag=1,
        xp=0,
        level_up=10,
        warp={
            x=0,
            y=0,
            map=2
        },
        chapter=1,
        map=1,
        submap=1
    }
end

function update_player()
    player_controls()
    animate_player()
    set_warp()
    check_warp()
end

function player_controls()
    if player.state==0 or player.state==1 then
        if not btn(0)
        and not btn(1)
        and not btn(2)
        and not btn(3) then
            player.state=0
        end
        if btn(0) and not collide(player,0,0) then
            player.dir=0
            player.state=1
            player.x-=player.movement
        end
        if btn(1) and not collide(player,1,0) then
            player.dir=1
            player.state=1
            player.x+=player.movement
        end
        if btn(2) and not collide(player,2,0) then
            player.dir=2
            player.state=1
            player.y-=player.movement
        end
        if btn(3) and not collide(player,3,0) then
            player.dir=3
            player.state=1
            player.y+=player.movement
        end
    end
end

function animate_player()
    if player.state==0 then
        if player.dir==0 then
            player.sp=195
            player.flp=true
        elseif player.dir==1 then
            player.sp=195
            player.flp=false
        elseif player.dir==2 then
            player.sp=208
        elseif player.dir==3 then
            player.sp=192
        end
    elseif player.state==1 and time()-player.anim>0.3 then
        do_walk_anim()
        player.anim=time()
    end
end

function do_walk_anim()
    if player.dir==0 then
        player.flp=true
        if player.sp==196 then
            player.sp=195
        else
            player.sp=196
        end
    elseif player.dir==1 then
        player.flp=false
        if player.sp==196 then
            player.sp=195
        else
            player.sp=196
        end
    elseif player.dir==2 then
        if player.sp==209 then
            player.sp=210
        else
            player.sp=209
        end
    elseif player.dir==3 then
        if player.sp==193 then
            player.sp=194
        else
            player.sp=193
        end
    end
end

function check_warp()
    if collide(player,player.dir,1) then
        player.map=player.warp.map
        player.x=player.warp.x
        player.y=player.warp.y
    end
end