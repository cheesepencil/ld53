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

function collide_bird_vs_gator(bird, gator)
    local a1 = {
        x = bird.x,
        y = bird.y,
        h = 6,
        w = 16
    }
    local a2 = {
        x = gator.x - 2,
        y = gator.y,
        h = 8,
        w = 16
    }

    return _collide(a1, a2)
end

function collide_bird_vs_drone(bird, drone)
    local a1 = {
        x = bird.x,
        y = bird.y,
        h = 6,
        w = 16
    }
    local a2 = {
        x = drone.x + 2,
        y = drone.y + 2,
        h = 4,
        w = 4
    }

    return _collide(a1, a2)
end

function collide_baby_vs_drone(baby, drone)
    local a1 = {
        x = baby.x,
        y = baby.y,
        h = 8,
        w = 8
    }
    local a2 = {
        x = drone.x + 2,
        y = drone.y + 2,
        h = 8,
        w = 8
    }

    return _collide(a1, a2)
end

function collide_baby_vs_house(baby, house)
    local a1 = {
        x = baby.x,
        y = baby.y,
        h = 8,
        w = 8
    }
    local a2 = {
        x = house.x,
        y = house.y,
        h = 16,
        w = 16
    }

    return _collide(a1, a2)
end

function collide_bird_vs_balloon(bird, balloon)
    local a1 = {
        x = bird.x,
        y = bird.y,
        h = 8,
        w = 16
    }
    local a2 = {
        x = balloon.x,
        y = balloon.y,
        h = balloon.h,
        w = balloon.w
    }

    return _collide(a1, a2)
end