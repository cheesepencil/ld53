scene = {}

function _init()
    scene.world = make_world(512)
    scene.bird = make_bird(scene.world)
    scene.cam = make_cam(scene.world, scene.bird)
    scene.baby = make_baby(scene.world, scene.bird)
end

function _update()
    inputs = {
        left = btn(⬅️),
        right = btn(➡️),
        btn_x = btn(❎),
        btn_o = btn(🅾️),
    }

    -- baby targeting disables flight controls! muhahaha
    if inputs.btn_x then
        inputs.left = false
        inputs.right = false
        inputs.btn_o = false
    end

    scene.world:update()
    scene.bird:update(inputs)
    scene.baby:update(inputs)
    scene.cam:update()
end

function _draw()
    scene.cam:draw()
    scene.world:draw()
    scene.bird:draw()
    scene.baby:draw()
end