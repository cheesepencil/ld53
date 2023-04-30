function make_level_4(start_time, lives)
    local config = {}
    config.start_time = start_time or t()
    config.lives = lives or 5

    config.size = 128 * 6
    config.seed = 4.444
    config.retry_callback = make_level_4
    config.next_level_callback = make_level_5

    local scene = make_scene(config)

    scene.tutorial = false

    local x = 330 + 8
    for i = 0, 12 do
        add(scene.drones, make_drone({
            x = x, 
            x_amp = 40,
            x_speed = 0.25,
            x_delay = i / 25,
            y = 120,
            y_amp = 40,
            y_speed = 0.25,
            y_delay = i / 25,
        }))
        add(scene.drones, make_drone({
            x = 409 + 8, 
            x_amp = 40,
            x_speed = 0.25,
            x_delay = i / 25,
            y = 120,
            y_amp = 40,
            y_speed = 0.25,
            y_delay = i / 25,
        }))
    end

    for i = 1, 3 do
        add(scene.drones, make_drone({
            x = 128 + 64,
            x_amp = 60,
            x_speed = 0.25,
            x_delay = i / 25,
            y = 64,
            y_amp = -45,
            y_speed = 0.125,
            y_delay = i / 25,
        }))
    end


    add(scene.redhats, make_redhat(316 - 48, 316, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(409 + 16, 409 + 16 + 48, scene.cam, scene.bird))
    
    add(scene.redhats, make_redhat(570, 570 + 52, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(570 + 52, 570 + 52 * 2, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(570 + 52 * 2, 570 + 52 * 3, scene.cam, scene.bird))
    -- add(scene.redhats, make_redhat(300, 415, scene.cam, scene.bird))
    -- add(scene.redhats, make_redhat(440 + (610-440)\2 + 8, 610, scene.cam, scene.bird))
    -- add(scene.redhats, make_redhat(440, 440 + (610-440)\2, scene.cam, scene.bird))

    return scene
end