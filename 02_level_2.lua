function make_level_2(start_time, lives)
    local config = {}
    config.start_time = start_time or t()
    config.lives = lives or 0

    config.size = 128 * 4
    config.seed = 2.1234
    config.retry_callback = make_level_2
    config.next_level_callback = make_winner_scene

    local scene = make_scene(config)

    scene.tutorial = false

    scene.drones = {}

    local x = 128
    for i = 0, 10 do
        add(scene.drones, make_drone({
            x = x + i * 8, 
            y = 32,
            y_amp = 24,
            y_speed = 1,
            y_delay = i / 10,
        }))
    end

    for i = 1, 12 do
        add(scene.drones, make_drone({
            x = 360,
            y_amp = 48,
            x_amp = 48,
            y_speed = -0.25,
            x_speed = 0.25,
            x_delay = i / 20,
            y_delay = -i / 20,
        }))
    end

    -- for i = 1, 6 do
    --     add(scene.drones, make_drone({
    --         y_amp = -48,
    --         x_amp = 48,
    --         y_speed = -0.25,
    --         x_speed = 0.25,
    --         x_delay = -i / 20,
    --         y_delay = i / 20,
    --     }))
    -- end

    return scene
end