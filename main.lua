function _init()
    world = make_world(256)
    bird = make_bird(world)
    baby = make_baby(world, bird)
end

function _update()
    world:update()
    bird:update()
    baby:update()
end

function _draw()
    camera(bird.x - 64, 0)
    
    world:draw()
    bird:draw()
    baby:draw()
end