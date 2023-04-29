function _bird_update(bird)
    -- bird y    
    bird.y_velocity += GRAVITY
    if bird.y_velocity >= TERMINAL_VELOCITY then 
        bird.y_velocity = TERMINAL_VELOCITY 
    end

    if btn(🅾️) then
        if not bird.flapped then
            bird.flapped = true
            bird.y_velocity = -FLAP_POWER
            bird.flapped_at = t()
            bird.sprite = 2
        end
    else
        bird.flapped = false
        if t() - bird.flapped_at > 0.125 then
            bird.sprite = 0
        end
    end
    
    bird.y += bird.y_velocity
    local min_altitude = bird.world.ground_level - 12
    if bird.y > min_altitude then bird.y = min_altitude end
    local max_altitude = -6
    if bird.y <= max_altitude then 
        bird.y = max_altitude 
    end
    
    -- bird x
    if btn(⬅️) then
        bird.left = true
    elseif btn(➡️) then
        bird.left = false
    end

    bird.x_velocity += BIRD_X_MODIFIER * (bird.left and -1 or 1)
    if abs(bird.x_velocity) > BIRD_MAX_X_VELOCITY then
        bird.x_velocity = BIRD_MAX_X_VELOCITY * (bird.left and -1 or 1)
    end
    bird.x += bird.x_velocity

    if bird.x > bird.world.width - 16 then
        bird.x = bird.world.width - 16
        bird.x_velocity = 0
        bird.left = true
    elseif bird.x < 0 then
        bird.x = 0
        bird.x_velocity = 0
        bird.left = false
    end
end

function _bird_draw(bird)
    local sprite = bird.y_velocity > 0 and 0 or 2
    spr(bird.sprite, bird.x, bird.y, 2, 2, bird.left)
end

function make_bird(world)
    local bird = {
        world = world,
        x = 0,
        x_velocity = 0,
        y = 0,
        y_velocity = 0,
        left = false,
        flapped = false,
        flapped_at = 0,
        sprite = 0,
    }

    bird.update = _bird_update
    bird.draw = _bird_draw

    return bird
end