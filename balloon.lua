function _balloon_update(balloon)

end

function _balloon_draw(balloon)
    sspr(80, 0, 16, 16, 0, 0, 20, 20)
end

function make_balloon(x, y, w, h)
    local balloon = {
        x = x,
        y = y,
        w = w,
        h = h
    }

    balloon.draw = _balloon_draw
    balloon.update = _balloon_update

    return balloon
end