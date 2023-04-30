function make_tutorial_level()
    local scene = make_scene(128 * 3, 1234)

    scene.tutorial = true
    scene.drones = {
        make_drone(128 * 3 - 72, 64, 32, 0.25, 32, 0.25),
        make_drone(128 * 3 - 72 - 8, 72, -32, 0.25, 32, 0.25)
    }

    return scene
end