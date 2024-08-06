npc_by_map={
    {
        {1,115,360,32,1},
        {2,73,288,96,1},
        {3,112,360,16,2},
        {4,112,336,88,3},
        {11,71,288,96,4},
        {12,112,360,96,4},
        {13,88,360,96,5}
    },
    {
        {5,114,216,112,9},
        {6,116,32,152,9},
        {7,113,16,128,1,3}
    },
    {
        {8,112,344,144,9},
        {9,poi_sp,352,320,4,5}
    },
    {},
    {},
    {},
    {
        {10,poi_sp,464,432,1,3}
    }
}

function set_active_npc_list()
    active_npc_list={}
    if p_map==1 then
        if event_flags[3] then
            npc_by_map[1][2][3]=360
        end
        for npc in all(npc_by_map[1]) do
            if npc[5]==p_submap then
                add(active_npc_list,npc)
            end
        end
    else
        for npc in all(npc_by_map[p_map]) do
            local sf=npc[5]
            local lf=npc[6]
            if event_flags[sf] and (lf==nil or not event_flags[lf]) then
                add(active_npc_list,npc)
            end
        end
    end
end

function draw_active_npc()
    for npc in all(active_npc_list) do
        spr(npc[2],npc[3],npc[4])
    end
end