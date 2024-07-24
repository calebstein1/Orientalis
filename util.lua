function draw_sprites()
    m=player.map

    if m==0 then
        -- Combat map
    elseif m==1 then
        spr(player.sp,player.x,player.y,1,1,player.flp)
    elseif m==2 then
    end
end