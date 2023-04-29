-- constants
GRAVITY = 0.05
TERMINAL_VELOCITY = 3
FLAP_POWER = 1
BIRD_X_MODIFIER = 0.1
BIRD_MAX_X_VELOCITY = 1

bird = {
    x = 0,
    x_velocity = 0,
    y = 0,
    y_velocity = 0,
    left = false,
    flapped = false,
    flapped_at = 0,
    sprite = 0,
}

function _init()

end

function _update()
    bird.y_velocity += GRAVITY
    if bird.y_velocity >= TERMINAL_VELOCITY then 
        bird.y_velocity = TERMINAL_VELOCITY 
    end

    -- bird y    
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
    if bird.y > 128 - 8 then bird.y = 128 - 8 end
    
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

    if bird.x > 128 - 16 then
        bird.x = 128 - 16
        bird.x_velocity = 0
        bird.left = true
    elseif bird.x < 0 then
        bird.x = 0
        bird.x_velocity = 0
        bird.left = false
    end
end

function _draw()
    cls(12)
    print("mod * left: " .. tostr(BIRD_X_MODIFIER * (bird.left and -1 or 1)))
    print("bird.x_velocity: " .. tostr(bird.x_velocity), 11)
    local sprite = bird.y_velocity > 0 and 0 or 2
    spr(bird.sprite, bird.x, bird.y, 2, 2, bird.left)
    local baby_x = bird.left and -3 or 11
    spr(4, bird.x + baby_x, bird.y + 8, 1, 1, bird.left)
end