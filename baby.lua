function _get_baby_bird_x_offset(baby)
    if baby.bird then
        return baby.bird.left and -3 or 11
    else
        return 0
    end
end

function _get_baby_bird_y_offset(baby)
    if baby.bird then
        return 7
    else
        return 0
    end
end

function _baby_update(baby)
    if baby.bird then
        baby.x = baby.bird.x + _get_baby_bird_x_offset(baby)
        baby.y = baby.bird.y + _get_baby_bird_y_offset(baby)
    end
end

function _baby_draw(baby)
    spr(4, baby.x, baby.y, 1, 1, baby.bird.left)
end

function make_baby(world, bird)
    local baby = {
        bird = bird,
        world = world,
        x = 0,
        x_velocity = 0,
        y = 0,
        y_velocity = 0,
        left = false,
        sprite = 4,
    }

    baby.x = _get_baby_bird_x_offset(baby)
    baby.update = _baby_update
    baby.draw = _baby_draw

    return baby
end