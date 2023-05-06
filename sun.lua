function _sun_update(sun, bird)
    if bird and bird.y <= BIRD_MAX_ALTITUDE then
        sun.strength += 0.5
        sun.strength = sun.strength > 10 and 10 or sun.strength
        if sun.strength == 10 then sun.danger = true end
    else
        sun.strength -= 0.1
        sun.strength = sun.strength < 0 and 0 or sun.strength
        sun.danger = false
    end
end

function _sun_draw(sun, cam)
    -- ▒
    -- ░
    local x0 = cam.x - 1
    local x1 = cam.x + 128
    local y0 = -sun.strength - 1
    local y1 = -1 + sun.strength

    local corona_modifier = 2
    local corona_modifier2 = 2.5

    fillp(░)
    ovalfill(x0 * - corona_modifier2, 
        y0 * corona_modifier2,
        x1 * corona_modifier2, 
        y1 * corona_modifier2, 
        8)

    fillp()
    ovalfill(x0, y0, x1, y1, 10)
    
    fillp(▒)
    ovalfill(x0 * -corona_modifier, 
        y0 * corona_modifier,
        x1 * corona_modifier, 
        y1 * corona_modifier, 
        9)

    fillp()
end

function make_sun()
    local sun = {}

    sun.strength = 0
    sun.danger = false

    sun.update = _sun_update
    sun.draw = _sun_draw

    return sun
end