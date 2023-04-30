function make_level_3(start_time, lives)
    local config = {}
    config.start_time = start_time or t()
    config.lives = lives or 0

    config.size = 128 * 5
    config.seed = 3.3333
    config.retry_callback = make_level_3
    config.next_level_callback = make_level_4

    local scene = make_scene(config)

    scene.tutorial = false

    local x = 180
    for i = 0, 12 do
        add(scene.drones, make_drone({
            x = x, 
            x_amp = 60,
            x_speed = 0.25,
            x_delay = i / 25,
            y = 0,
            y_amp = 60,
            y_speed = 0.25,
            y_delay = i / 25,
        }))
        add(scene.drones, make_drone({
            x = x, 
            x_amp = 60,
            x_speed = 0.25,
            x_delay = i / 25,
            y = 128,
            y_amp = 60,
            y_speed = 0.25,
            y_delay = i / 25,
        }))
    end

    add(scene.redhats, make_redhat(300, 415, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(440 + (610-440)\2 + 8, 610, scene.cam, scene.bird))
    add(scene.redhats, make_redhat(440, 440 + (610-440)\2, scene.cam, scene.bird))

    return scene
end