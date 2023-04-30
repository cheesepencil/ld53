scene = {}

function change_scene(new_scene)
    scene = new_scene
end

function _init()
    scene = make_title_scene()
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