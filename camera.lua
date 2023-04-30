function _cam_update(cam)
    local target_cam_x = cam.bird and cam.bird.x + _get_cam_target_offset(cam) or cam.x
    cam.y = 0

    if (cam.bird and cam.bird.left) then
        cam.x += cam.bird.x_velocity - cam.speed / 3
        if cam.x < target_cam_x then cam.x = target_cam_x end
    elseif (cam.bird) then
        cam.x += cam.bird.x_velocity + cam.speed / 3
        if cam.x > target_cam_x then cam.x = target_cam_x end
    end
    if cam.x < 0 then cam.x = 0 end
    if cam.x > cam.world.width - 128 then cam.x = cam.world.width - 128 end
end

function _cam_draw(cam)
    camera(cam.x, cam.y)
end

function _get_cam_target_offset(cam)
    if cam.bird.left then
        return -128 + 16 + cam.bird_offset
    else
        return -cam.bird_offset
    end
end

function make_cam(world, bird)
    local cam = {
        world = world,
        bird = bird,
        bird_offset = 20,
        speed = 2,
        x = bird.x - 64,
        y = 0,
    }

    cam.update = _cam_update
    cam.draw = _cam_draw

    return cam
end