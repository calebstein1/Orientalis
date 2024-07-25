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
        dir:
        0 left
        1 right
        2 up
        3 down
        ]]
        dir=0,
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
        warp_x=0,
        warp_y=0,
        warp_map=2,
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
            player.x-=player.speed
        end
        if btn(1) and not collide(player,1,0) then
            player.dir=1
            player.state=1
            player.x+=player.speed
        end
        if btn(2) and not collide(player,2,0) then
            player.dir=2
            player.state=1
            player.y-=player.speed
        end
        if btn(3) and not collide(player,3,0) then
            player.dir=3
            player.state=1
            player.y+=player.speed
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
        player.map=player.warp_map
        player.x=player.warp_x
        player.y=player.warp_y
    end
end

function set_warp()
    local m=player.map
    local sm=player.submap

    if m==1 then
        player.warp_map=2
        if sm==0 then
            player.warp_x=2*8
            player.warp_y=2*8
        elseif sm==1 then
            player.warp_x=8*8
            player.warp_y=2*8
        elseif sm==2 then
            player.warp_x=3*8
            player.warp_y=14*8
        elseif sm==3 then
            player.warp_x=6*8
            player.warp_y=14*8
        elseif sm==4 then
            player.warp_x=10*8
            player.warp_y=17*8
        end
    elseif m==2 then
        if player.y<3*8 then
            if player.x>6*8 then
                player.warp_map=1
                player.submap=1
                player.warp_x=42*8
                player.warp_y=6*8
            else
                player.warp_map=1
                player.submap=0
                player.warp_x=42*8
                player.warp_y=6*8
            end
        elseif player.y<17*8 then
            if player.x<2*8 then
            elseif player.x<4*8 then
                player.warp_map=1
                player.submap=2
                player.warp_x=42*8
                player.warp_y=6*8
            elseif player.x<8*8 then
                player.warp_map=1
                player.submap=3
                player.warp_x=42*8
                player.warp_y=6*8
            elseif player.x<12*8 then
                player.warp_map=1
                player.submap=4
                player.warp_x=42*8
                player.warp_y=6*8
            else
            end
        end
    end
end