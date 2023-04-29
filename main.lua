scene = {}

function _init()
    scene.world = make_world(512)
    scene.bird = make_bird(scene.world)
    scene.cam = make_cam(scene.world, scene.bird)
    scene.baby = make_baby(scene.world, scene.bird)
end

function _update()
    scene.world:update()
    scene.bird:update()
    scene.baby:update()
    scene.cam:update()
end

function _draw()
    scene.cam:draw()
    scene.world:draw()
    scene.bird:draw()
    scene.baby:draw()
end