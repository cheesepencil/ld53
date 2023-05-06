function _collide(a1, a2)
    if a1.x < a2.x + a2.w and
        a1.x + a1.w > a2.x and 
        a1.y < a2.y + a2.h and
        a1.h + a1.y > a2.y then
            return true
        else
            return false
        end
end

function collide_bird_vs_bullet(bird, bullet)
    local a1 = bird:get_hitbox()
    local a2 = {
        x = bullet.x,
        y = bullet.y,
        h = 1,
        w = 1,
    }

    return _collide(a1, a2)
end

function collide_bird_vs_gator(bird, gator)
    local a1 = bird:get_hitbox()
    local a2 = {
        x = gator.x - 2,
        y = gator.y,
        h = 7,
        w = 13
    }

    return _collide(a1, a2)
end

function collide_baby_vs_drone(baby, drone)
    local a1 = {
        x = baby.x,
        y = baby.y,
        h = 7,
        w = 7
    }
    local a2 = drone:get_hitbox()

    return _collide(a1, a2)
end

function collide_baby_vs_house(baby, house)
    local a1 = {
        x = baby.x,
        y = baby.y,
        h = 7,
        w = 7
    }
    local a2 = {
        x = house.x,
        y = house.y,
        h = 15,
        w = 15
    }

    return _collide(a1, a2)
end

function collide_bird_vs_balloon(bird, balloon)
    local a1 = bird:get_hitbox()
    local a2 = {
        x = balloon.x,
        y = balloon.y,
        h = balloon.h,
        w = balloon.w
    }

    return _collide(a1, a2)
end