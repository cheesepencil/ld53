BIRD_PUFF_COOLDOWN = 0.125
BIRD_PUFF_DURATION = 0.25

function _bird_get_hitbox(bird)
    return {
        x = bird.x + 2,
        y = bird.y + 4,
        w = 11,
        h = 5,
    }
end

function _bird_update(bird, inputs)
    -- bird y    
    bird.y_velocity += GRAVITY
    if bird.y_velocity >= TERMINAL_VELOCITY then 
        bird.y_velocity = TERMINAL_VELOCITY 
    end

    if inputs.btn_o then
        if not bird.flapped then
            sfx(0)
            bird.flapped = true
            bird.y_velocity = -FLAP_POWER
            bird.x_velocity += FLAP_POWER * (bird.left and -1 or 1)
            bird.flapped_at = t()
            bird.sprite = 2
            bird.create_puffs_until = t() + BIRD_PUFF_DURATION
            bird.create_puff_after = t()
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
    if bird.y <= BIRD_MAX_ALTITUDE then 
        bird.y = BIRD_MAX_ALTITUDE 
    end
    
    -- bird x
    if inputs.left then
        bird.left = true
    elseif inputs.right then
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

    if t() < bird.create_puffs_until and t() >= bird.create_puff_after then
        bird.create_puff_after = t() + BIRD_PUFF_COOLDOWN
        function del_puff(puff_to_del)
            del(bird.puffs, puff_to_del)
        end

        local puff = make_puff({
            x = bird.x + 8 + rnd({0,1}),
            y = bird.y + 10 + rnd({0,1}),
            radius = 3,
            shrink_speed = 0.125,
            pattern = ░,
            callback = del_puff
        })
        add(bird.puffs, puff)
    end

    for puff in all(bird.puffs) do
        puff:update()
    end
end

function _bird_draw(bird)
    for puff in all(bird.puffs) do
        puff:draw()
    end

    local sprite = bird.y_velocity > 0 and 0 or 2
    spr(bird.sprite, bird.x, bird.y, 2, 2, bird.left)
end

function make_bird(world, x, y)
    local bird = {
        world = world,
        x = x or 24,
        x_velocity = 0,
        y = y or 18,
        y_velocity = 0,
        left = false,
        flapped = false,
        flapped_at = 0,
        sprite = 0,
        puffs = {},
        create_puff_after = t(),
        create_puffs_until = t(),
    }

    bird.update = _bird_update
    bird.draw = _bird_draw
    bird.get_hitbox = _bird_get_hitbox

    return bird
end