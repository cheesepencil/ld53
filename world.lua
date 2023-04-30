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

    -- shrubs
    for shrub in all(world.shrubs) do
        spr(shrub.sprite, shrub.x, shrub.y)
    end

    -- goal
    for goal in all(world.goals) do
        spr(28, goal.x + 6, goal.y + 2 - goal.success_y)
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

function make_world(width, height, seed)
    srand(seed)
    local world = {
        width = width or 128 * 3, -- multiples of 128 please! 384 min
        height = height or 128,
        ground_level = 120,
        shrubs = {},
        goals = {},
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

    if DEBUG then
        for goal in all(world.goals) do
            printh("goal at: " .. goal.x)
        end
    end

    local shrub_count = world.width // 8
    for i = 1, shrub_count + 1 do
        for j = 1, 2 do
            add(world.shrubs, {
                sprite = rnd({5, 20, 21}),
                x = ((i - 1) * 8) + flr(rnd(5)) * rnd({-1, 1}),
                y = (world.ground_level - 8) + flr(rnd(9)),
                rnd({true, false})
            })
        end
    end

    world.update = _world_update
    world.draw = _world_draw

    return world
end