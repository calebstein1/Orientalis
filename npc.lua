function init_npc()
    npc_by_map={
        {
            {1,115,360,32,1},
            {2,73,288,96,1},
            {3,112,360,16,2},
            {4,112,336,88,3},
            {12,71,288,96,4},
            {13,112,360,96,4},
            {14,88,360,96,5}
        },
        {
            {5,114,216,112,9,5},
            {6,116,32,152,9},
            {7,113,16,128,1,3}
        },
        {
            {8,112,344,144,9},
            {9,105,352,320,4,5}
        },
        {},
        {},
        {},
        {
            {10,105,464,432,1,3}
        },
        {},
        {
            {11,115,216,456,1,5},
            {11,115,216,456,11},
            {17,71,192,360,5,11},
            {16,71,224,392,5,11},
            {16,72,208,456,5,11},
            {16,72,184,408,5,11}
        },
        {},
        {
            {15,87,464,56,1,11},
            {16,71,472,88,1,11},
            {16,71,480,64,1,11},
            {16,72,448,64,1,11},
            {16,72,456,88,1,11}
        }
    }
end

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