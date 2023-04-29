function _world_update(world)
    
end

function _world_draw(world)
    cls(1)
    rectfill(0, 0, world.width, 127, 12)
    if DEBUG then
        local screen_marker_count = world.width // 128
        for i = 0, screen_marker_count do
            local x = 128 * i
            line(x, 0, x, world.height, 11)
        end
    end
end

function make_world(width, height)
    local world = {
        width = width or 128,
        height = height or 128
    }

    world.update = _world_update
    world.draw = _world_draw

    return world
end