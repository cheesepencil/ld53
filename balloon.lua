function _balloon_update(balloon)
    local speed = 0.25
    local amp = 12
    local y_offset = sin(t() * speed) * amp
    balloon.y = balloon.start_y + y_offset
end

function _balloon_draw(balloon)
    local outline_color = 0
    pal({
        [14] = outline_color,
        [7] = outline_color,
        [2] = outline_color,
        [4] = outline_color,
    })
    sspr(80, 0, 16, 16, balloon.x-1, balloon.y, balloon.w, balloon.h)
    sspr(80, 0, 16, 16, balloon.x+1, balloon.y, balloon.w, balloon.h)
    sspr(80, 0, 16, 16, balloon.x, balloon.y-1, balloon.w, balloon.h)
    sspr(80, 0, 16, 16, balloon.x, balloon.y+1, balloon.w, balloon.h)

    pal()
    sspr(80, 0, 16, 16, balloon.x, balloon.y, balloon.w, balloon.h)
end

function make_balloon(x, y, w, h)
    local balloon = {
        x = x or 0,
        y = y or 0,
        start_y = y or 0,
        w = w or 32,
        h = h or 32,
        y_offset = 0,
    }

    balloon.draw = _balloon_draw
    balloon.update = _balloon_update

    return balloon
end