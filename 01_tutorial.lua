function make_tutorial_level(start_time, lives)
    local config = {}
    config.start_time = start_time or t()
    config.lives = lives or 5
    config.retry_callback = make_tutorial_level
    config.next_level_callback = make_level_2

    local scene = make_scene(config)

    scene.tutorial = true
    scene.drones = {
        make_drone({
            x = 128 * 3 - 72,
            x_amp = 32,
            x_speed = 0.25,
            y_amp = 32,
            y_speed = 0.25
        }),
        make_drone({
            x = 128 * 3 - 72 - 8,
            x_amp = -32,
            x_speed = 0.25,
            y_amp = 32,
            y_speed = 0.25
        })
    }

    scene.tutorial = make_tutorial_text(scene.cam)

    return scene
end