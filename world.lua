function _world_update(world)
    
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
        shrubs = {}
    }

    world.goals = {}
    local goal_count = flr(world.width / 128) - 2
    for i = 1, goal_count do
        local goal_offset = flr(rnd(128 - 16 * 2) + 16)
        add(world.goals, {
            x = width - i * 128 + goal_offset,
            y = world.ground_level - 15,
        })
    end

    local shrub_count = world.width // 8
    for i = 1, shrub_count + 1 do
        for j = 1, 2 do
            add(world.shrubs, {
                sprite = rnd({5, 20, 21}),
                x = ((i - 1) * 8) + flr(rnd(5)) * rnd({-1, 1}),
                y = (world.ground_level - 8) + flr(rnd(9)),
                rnd({true, false})
            });
        end
    end

    world.update = _world_update
    world.draw = _world_draw

    return world
end