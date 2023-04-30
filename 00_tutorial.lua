function make_tutorial_level()
    local scene = make_scene(128 * 3, 1234)

    scene.tutorial = true

    return scene
end