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

function _baby_update(baby, inputs)
    baby.left = baby.bird.left
    if baby.bird then
        baby.x = baby.bird.x + _get_baby_bird_x_offset(baby)
        baby.y = baby.bird.y + _get_baby_bird_y_offset(baby)

        if inputs.btn_x then
            baby.targeting = true
        else
            baby.targeting = false
        end
    end
end

function _draw_baby_trajectory(baby)
    line(baby.x, baby.y, baby.x, baby.y, 8)
    local x = baby.x
    local y = baby.y
    local y_velocity = 0 
    local x_velocity = baby.bird.x_velocity * 0.80
    for i = 0, 90 do
        x = x + x_velocity
        y_velocity += GRAVITY
        y = y + y_velocity
        line(x, y, 8)
    end
end

function _baby_draw(baby)
    if baby.targeting then _draw_baby_trajectory(baby) end
    spr(4, baby.x, baby.y, 1, 1, baby.left)
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
        targeting = false,
    }

    baby.x = _get_baby_bird_x_offset(baby)
    baby.update = _baby_update
    baby.draw = _baby_draw

    return baby
end