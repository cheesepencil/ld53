function _world_update(world)
    
end

function _world_draw(world)
    cls(1)

    -- sky
    rectfill(0, 0, world.width, 127, 12)

    -- dirt
    rectfill(0, world.ground_level, world.width, 127, 4)

    -- grass
    rectfill(0, world.ground_level, world.width, world.ground_level + 1, 11)

    -- shrubs
    for shrub in all(world.shrubs) do
        spr(shrub.sprite, shrub.x, shrub.y)
    end

    -- goal
    spr(8, world.goal.x, world.goal.y, 2, 2)

    if DEBUG then
        local screen_marker_count = world.width // 128
        for i = 0, screen_marker_count do
            local x = 128 * i
            line(x, 0, x, world.height, 11)
        end
    end
end

function make_world(width, height, seed)
    local world = {
        seed = seed or 0,
        width = width or 128,
        height = height or 128,
        ground_level = 120,
        shrubs = {}
    }

    world.goal = {
        x = width - 64 - 8,
        y = world.ground_level - 15,
    }

    --srand(seed)
    local shrub_count = world.width // 8
    for i = 1, shrub_count + 1 do
        for j = 1, 2 do
            add(world.shrubs, {
                sprite = rnd({5, 20, 21}),
                x = ((i - 1) * 8) + flr(rnd(5)) * rnd({-1, 1}),
                y = (world.ground_level - 8) + flr(rnd(9)),
            });
        end
    end

    world.update = _world_update
    world.draw = _world_draw

    return world
end