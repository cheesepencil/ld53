PUFF_SHRINK_SPEED = 0.5

function _puff_update(puff)
    puff.radius -= PUFF_SHRINK_SPEED

    if puff.radius <= 0 then puff:callback() end
end

function _puff_draw(puff)
    fillp(▒)
    circfill(puff.x, puff.y, puff.radius, puff.color)
    fillp()
end

function make_puff(config)
    local puff = {
        x = config.x or 64,
        y = config.y or 64,
        radius = config.radius or 16,
        color = config.color or 7,
        callback = config.callback or EMPTY_FUNCTION
    }

    puff.update = _puff_update
    puff.draw = _puff_draw

    return puff
end