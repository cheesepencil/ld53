function _world_update(world)
    local successes = 0
    for goal in all(world.goals) do
        if goal.success then 
            successes += 1
            goal.success_y += FLAG_RAISE_SPEED
            if goal.success_y > FLAG_RAISE_MAX then goal.success_y = FLAG_RAISE_MAX end
        end
    end
    world.successes = successes
end

function _world_draw(world)
    cls(1)

    -- sky
    rectfill(0, 0, world.width, 127, 12)

    -- dirt
    rectfill(0, world.ground_level, world.width, 127, 4)

    -- grass
    rectfill(0, world.ground_level, world.width, world.ground_level + 1, 5)

    -- ocean
    rectfill(0, world.ground_level - 1, world.width, world.ground_level - 4, 1)

    -- trees
    for tree in all(world.trees) do
        spr(32, tree.x, tree.y, 2, 2, tree.flip)
    end

    -- shrubs
    for shrub in all(world.shrubs) do
        spr(shrub.sprite, shrub.x, shrub.y, 1, 1, shrub.flip)
    end

    -- goal
    for goal in all(world.goals) do
        local outline_color = 7
        pal({
            [5] = outline_color,
            [14] = outline_color,
            [2] = outline_color,
        })
        spr(28, goal.x + 5, goal.y + 2 - goal.success_y)
        spr(28, goal.x + 7, goal.y + 2 - goal.success_y)
        spr(28, goal.x + 6, goal.y + 1 - goal.success_y)
        spr(28, goal.x + 6, goal.y + 3 - goal.success_y)
        pal()
        spr(28, goal.x + 6, goal.y + 2 - goal.success_y)
        
        outline_color = 0
        pal({
            [1] = outline_color,
            [5] = outline_color,
            [10] = outline_color,
            [9] = outline_color,
            [4] = outline_color,
            [7] = outline_color,
        })
        spr(8, goal.x+1, goal.y, 2, 2)
        spr(8, goal.x-1, goal.y, 2, 2)
        spr(8, goal.x, goal.y+1, 2, 2)
        spr(8, goal.x, goal.y-1, 2, 2)
        pal()
        spr(8, goal.x, goal.y, 2, 2)
    end

    if DEBUG then
        local screen_marker_count = world.width // 128
        for i = 0, screen_marker_count do
            local x = 128 * i
            line(x, 0, x, world.height, 11)
        end
    end
end

function make_world(width, seed)
    srand(nil)
    local world = {
        width = width or 128 * 3, -- multiples of 128 please! 384 min
        height = height or 128,
        ground_level = 120,
        shrubs = {},
        goals = {},
        trees = {},
        successes = 0,
    }

    local goal_count = flr(world.width / 128) - 2
    for i = 1, goal_count do
        local goal_offset = flr(rnd(128 - 16 * 2) + 16)
        add(world.goals, {
            x = width - i * 128 + goal_offset,
            y = world.ground_level - 15,
            success = false,
            success_y = 0,
        })
    end

    srand(seed and seed + 4.333 or 4.333)
    local tree_count = flr(world.width / 128) * 2
    for i = 1, tree_count do
        add(world.trees, {
            x = i * 64 + (18 * rnd({1, -1})),
            y = world.ground_level - 14 + rnd({-1,0,1}),
            flip = rnd({true, false})
        })
    end

    if DEBUG then
        for goal in all(world.goals) do
            printh("goal at: " .. goal.x)
        end
    end

    srand(seed)
    local shrub_count = world.width // 8
    for i = 1, shrub_count + 1 do
        for j = 1, 2 do
            add(world.shrubs, {
                sprite = rnd({5, 20, 21}),
                x = ((i - 1) * 8) + flr(rnd(5)) * rnd({-1, 1}),
                y = (world.ground_level - 8) + flr(rnd(9)),
                flip = rnd({true, false})
            })
        end
    end

    world.update = _world_update
    world.draw = _world_draw

    return world
end