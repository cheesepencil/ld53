function _scene_update(scene, inputs)
    if inputs.btn_x then
        inputs.left = false
        inputs.right = false
        inputs.btn_o = false
    end

    scene.world:update()
    if scene.bird then scene.bird:update(inputs) end
    if scene.baby then scene.baby:update(inputs) end
    scene.cam:update()
    scene.gators:update()
    scene.balloon:update()
    for juice in all(scene.juice) do
        juice:update()
    end

        -- game state
    -- -- win conditions

    -- -- loss conditions

    -- -- collisions
    -- baby vs house
    if scene.baby then
        for goal in all(scene.world.goals) do
            if not goal.success and collide_baby_vs_house(scene.baby, goal) then
                goal.success = true
                scene.baby = nil
                scene.gators.baby = nil
                break
            end
        end
    end

    -- baby vs ground
    if scene.baby and scene.baby.y > 120 - 8 then
        local function print_dead_and_die(juice)
            del(scene.juice, juice)
        end
        add(scene.juice, make_splash(scene.baby.x, scene.baby.y, 8, print_dead_and_die))
        scene.baby = nil
        scene.gators.baby = nil
    end

    -- gators vs bird
    if scene.bird then
        local bird_collision = collide_bird_vs_gator(scene.bird, scene.gators.left_gator)
        bird_collision = bird_collision or collide_bird_vs_gator(scene.bird, scene.gators.right_gator)
        if bird_collision then
            local function print_dead_and_die(juice)
                del(scene.juice, juice)
            end
            add(scene.juice, make_splash(scene.bird.x + 8, scene.bird.y + 4, 8, print_dead_and_die))
            scene.bird = nil
            scene.gators.bird = nil
            if scene.baby then scene.baby.bird = nil end
            scene.cam.bird = nil
        end
    end

    -- bird vs balloon
    if scene.bird and not scene.baby and collide_bird_vs_balloon(scene.bird, scene.balloon) then
        scene.baby = make_baby(scene.world, scene.bird)
        scene.gators.baby = scene.baby
    end
end

function _scene_draw(scene)
    scene.cam:draw()
    scene.world:draw()

    if scene.tutorial then
        print("<-- get babies here", 32 + 16, 32, 1)
        print("tap 🅾️ to flap", 100, 64, 1)
        print("hold ❎ to aim", 200, 72, 1)
        print("release ❎ to deliver...", 270, 80, 1)
    end
    scene.balloon:draw()
    if scene.bird then scene.bird:draw() end
    if scene.baby then scene.baby:draw() end
    scene.gators:draw()
    for juice in all(scene.juice) do
        juice:draw()
    end
end

function make_scene(size, seed)
    seed = seed or 1234
    size = size or 128 * 3
    local scene = {}

    scene.world = make_world(size, seed)
    scene.bird = make_bird(scene.world)
    scene.cam = make_cam(scene.world, scene.bird)
    scene.baby = make_baby(scene.world, scene.bird)
    scene.gators = make_gators(scene.bird, scene.baby, scene.cam)
    scene.balloon = make_balloon(16, 16)
    scene.juice = {}

    scene.update = _scene_update
    scene.draw = _scene_draw

    return scene
end