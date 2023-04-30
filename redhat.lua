REDHAT_SHOOTING_COOLDOWNS = {1, 1.5, 2, 2.5}
REDHAT_SHOOTING_DURATION = 0.5
REDHAT_BULLET_COOLDOWN = 0.125
REDHAT_MOVEMENT_SPEED = 1

function _redhat_get_shoot_vector(redhat)
    local bird_center = {x = redhat.bird.x + 8, y = redhat.bird.y + 8}
    local redhat_center = {x = redhat.x + 8, y = redhat.y + 8}

    -- a true marksman leads a moving target
    if bird_center.x > redhat_center.x then
        bird_center.x += 32
    else
        bird_center.x -= 32
    end

    local big_vector = {
        x = bird_center.x - redhat_center.x,
        y = bird_center.y - redhat_center.y
    }

    local length = sqrt((big_vector.x ^ 2) + (big_vector.y ^ 2))

    local normalized_vector = {
        x = big_vector.x / length,
        y = big_vector.y / length
    }

    return normalized_vector
end

function _redhat_in_range(redhat)
    if redhat.x > redhat.cam.x - 32
        and redhat.x < redhat.cam.x + 128 + 32 then
            return true
        else
            return false
        end
end

function _redhat_update(redhat)
    if redhat.shooting then
        if t() >= redhat.shooting_ends then
            redhat.shooting = false
            redhat.next_shooting_begins = t() + rnd(REDHAT_SHOOTING_COOLDOWNS)
        elseif t() >= redhat.next_bullet_begins then
            sfx(8)
            redhat.next_bullet_begins = t() + REDHAT_BULLET_COOLDOWN
            add(redhat.bullets, {
                x = redhat.x + 8,
                y = redhat.y + 8,
                vector = redhat.shoot_vector,
                shot_time = t()
            })
        end
    else
        if redhat.bird and _redhat_in_range(redhat) then
            if redhat.bird.x > redhat.x then redhat.flip = false else redhat.flip = true end
            if redhat.x < redhat.bird.x then redhat.x += REDHAT_MOVEMENT_SPEED end
            if redhat.x > redhat.bird.x then redhat.x -= REDHAT_MOVEMENT_SPEED end
            redhat.x = redhat.x > redhat.max_x and redhat.max_x or redhat.x
            redhat.x = redhat.x < redhat.min_x and redhat.min_x or redhat.x
            if t() >= redhat.next_shooting_begins then
                redhat.shooting = true
                redhat.shooting_ends = t() + REDHAT_SHOOTING_DURATION
                redhat.next_bullet_begins = t()
                redhat.shoot_vector = _redhat_get_shoot_vector(redhat)
            end
        else
            redhat.next_shooting_begins = t() + rnd(REDHAT_SHOOTING_COOLDOWNS)
        end
    end

    local speed = 4
    local amp = 2
    local y_offset = sin(t() * speed) * amp
    redhat.y = redhat.start_y + y_offset

    for bullet in all(redhat.bullets) do
        bullet.x += bullet.vector.x * 2.5
        bullet.y += bullet.vector.y * 2.5
        if t() - bullet.shot_time > 10 then del(redhat.bullets, bullet) end
    end
end

function _redhat_draw(redhat)
    spr(14, redhat.x, redhat.y, 2, 2, redhat.flip)
    for bullet in all(redhat.bullets) do
        circfill(bullet.x, bullet.y, 1, 0)
    end
end

function make_redhat(min_x, max_x, cam, bird)
    local redhat = {}

    redhat.flip = false
    redhat.min_x = min_x
    redhat.max_x = max_x
    redhat.x = min_x
    redhat.target_x = max_x
    redhat.start_y = 112
    redhat.y = 112
    redhat.bird = bird
    redhat.cam = cam
    redhat.shooting = false
    redhat.next_shooting_begins = t() + rnd(redhat.shoot_cooldowns)
    redhat.shooting_ends = 0
    redhat.next_bullet_begins = 0
    redhat.shoot_vector = { x = 0, y = 0}
    redhat.bullets = {}

    redhat.update = _redhat_update
    redhat.draw = _redhat_draw

    return redhat
end