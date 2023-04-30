function make_level_5(start_time, lives)
    local config = {}
    config.start_time = start_time or t()
    config.lives = lives or 5

    config.size = 128 * 7
    config.seed = 5.555
    config.retry_callback = make_level_5
    config.next_level_callback = make_winner_scene

    local scene = make_scene(config)

    scene.tutorial = false

    local x = 128
    for i = 1, 16 do
        add(scene.drones, make_drone({
            x = x + i * 8, 
            y = 0,
            y_amp = 60,
            y_speed = 0.25,
            y_delay = i * 0.001
        }))
        add(scene.drones, make_drone({
            x = x + i * 8, 
            y = 120,
            y_amp = 60,
            y_speed = 0.25,
            y_delay = i * 0.001
        }))      
    end

    x = 388 + 16 + 4
    local delay = 8
    for i = 0, 7 do
        add(scene.drones, make_drone({
            x = x, 
            x_amp = 40,
            x_speed = 0.25,
            x_delay = i / delay,
            y = 120,
            y_amp = 40,
            y_speed = 0.25,
            y_delay = i / delay,
        }))
        add(scene.drones, make_drone({
            x = 512 - 10, 
            x_amp = 20,
            x_speed = 0.25,
            x_delay = i / delay,
            y = 120,
            y_amp = 20,
            y_speed = 0.25,
            y_delay = i / delay,
        }))
        add(scene.drones, make_drone({
            x = 512 - 10, 
            x_amp = 20,
            x_speed = 0.25,
            x_delay = i / delay,
            y = 16,
            y_amp = 20,
            y_speed = 0.25,
            y_delay = i / delay,
        }))
    end

    local x_offset = 16
    local y_offset = 16
    add(scene.drones, make_drone({
        x = 537 + x_offset, 
        y = 32 + y_offset,
    }))
    add(scene.drones, make_drone({
        x = 537 + 64 + x_offset, 
        y = 32+ y_offset - 11,
    }))
    add(scene.drones, make_drone({
        x = 537 + 64 + x_offset, 
        y = 32+ y_offset + 32 + 11,
    }))
    add(scene.drones, make_drone({
        x = 537 + 64 * 2 + x_offset, 
        y = 32+ y_offset + 8,
    }))

    add(scene.redhats, make_redhat(196, 340, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(547, 547+66-8, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(547+66-8, 547+66*2-8, scene.cam, scene.bird))

    add(scene.redhats, make_redhat(855-8,855-8, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(855-8-16,855-8-16, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(855-8-16*2,855-8-16*2, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(855-8-16*3,855-8-16*3, scene.cam, scene.bird))

    return scene
end