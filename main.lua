scene = {}

function _init()
    scene = make_tutorial_level()
end

function _update()
    -- input
    inputs = {
        left = btn(⬅️),
        right = btn(➡️),
        btn_x = btn(❎),
        btn_o = btn(🅾️),
    }

    scene:update(inputs)
end

function _draw()
    scene:draw()
end