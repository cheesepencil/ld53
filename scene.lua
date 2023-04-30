function _scene_revive_bird(scene)
    scene.lives -= 1
    scene.bird = make_bird(scene.world, scene.balloon.x + 8, scene.balloon.y + 16)
    scene.cam.bird = scene.bird
    scene.gators.bird = scene.bird
end

function _scene_kill_bird(scene)
    scene.revive_cooldown = true
    local function clean_up(juice)
        del(scene.juice, juice)
        if scene.lives > 0 then scene.revive_cooldown = false end
    end
    add(scene.juice, make_splash(scene.bird.x + 8, scene.bird.y + 4, 8, clean_up))
    scene.bird = nil
    scene.gators.bird = nil
    if scene.baby then scene.baby.bird = nil end
    scene.cam.bird = nil
end

function _scene_kill_baby(scene)
    local function clean_up(juice)
        del(scene.juice, juice)
    end
    add(scene.juice, make_splash(scene.baby.x, scene.baby.y, 8, clean_up))
    scene.baby = nil
    scene.gators.baby = nil
end

function _scene_update(scene, inputs)
    -- scene level input
    if inputs.btn_x then
        inputs.left = false
        inputs.right = false
        inputs.btn_o = false
    end

    if not scene.bird 
        and not scene.revive_cooldown 
        and not scene.over
        and inputs.btn_o then 
            _scene_revive_bird(scene) 
        end

    if scene.over and t() - scene.input_cooldown_timer_start > SCENE_ADVANCE_COOLDOWN_DURATION and inputs.btn_o then
        if scene.won then
            change_scene(make_title_scene())
        elseif scene.lost then
            change_scene(make_title_scene())
        end
    end

    scene.world:update()
    if scene.bird and not scene.over then scene.bird:update(inputs) end
    if scene.baby then scene.baby:update(inputs) end
    scene.cam:update()
    scene.gators:update()
    scene.balloon:update()
    for drone in all(scene.drones) do
        drone:update()
    end
    for juice in all(scene.juice) do
        juice:update()
    end

    -- win
    if not scene.over and scene.world.successes == #scene.world.goals then
        scene.over = true
        scene.won = true
        scene.input_cooldown_timer_start = t()
    end

    -- loss
    if not scene.over 
        and not scene.won
        and not scene.bird
        and scene.lives == 0 then
            scene.over = true
            scene.lost = true
            scene.input_cooldown_timer_start = t()
    end

    -- collisions
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
        _scene_kill_baby(scene)
    end

    -- gators vs bird
    if scene.bird then
        local bird_collision = collide_bird_vs_gator(scene.bird, scene.gators.left_gator)
        bird_collision = bird_collision or collide_bird_vs_gator(scene.bird, scene.gators.right_gator)
        if bird_collision then _scene_kill_bird(scene) end
    end

    -- drone vs bird
    if scene.bird then
        for drone in all(scene.drones) do
            local collision = collide_bird_vs_drone(scene.bird, drone)
            if collision then
                _scene_kill_bird(scene)
                break
            end
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
        print("tap 🅾️ to flap", 72, 72, 1)
        print("hold ❎ to aim", 150, 32, 1)
        print("release ❎ to deliver...", 170, 42, 1)
        print("avoid drones", 128 * 3 - 72 - 24, 64, 1)
        print("and other hazards", 128 * 3 - 72 - 24, 72, 1)
        print("deliver baby here -->", 128 * 3 - 100 - 10, 110)
    end

    scene.balloon:draw()
    if scene.bird then scene.bird:draw() end
    if scene.baby then scene.baby:draw() end
    scene.gators:draw()
    for juice in all(scene.juice) do
        juice:draw()
    end
    for drone in all(scene.drones) do
        drone:draw()
    end

    local outline_color = 2
    local text_color = 7
    print("deliveries: " .. scene.world.successes .. "/" .. #scene.world.goals, scene.cam.x + 66 - 1,   2, outline_color)
    print("deliveries: " .. scene.world.successes .. "/" .. #scene.world.goals, scene.cam.x + 66 + 1,   2, outline_color)
    print("deliveries: " .. scene.world.successes .. "/" .. #scene.world.goals, scene.cam.x + 66,       2 + 1, outline_color)
    print("deliveries: " .. scene.world.successes .. "/" .. #scene.world.goals, scene.cam.x + 66,       2 - 1, outline_color)
    print("deliveries: " .. scene.world.successes .. "/" .. #scene.world.goals, scene.cam.x + 66,       2, text_color)
    print("storks: " .. scene.lives, scene.cam.x + 3,       2 - 1, outline_color)
    print("storks: " .. scene.lives, scene.cam.x + 3,       2 + 1, outline_color)
    print("storks: " .. scene.lives, scene.cam.x + 3 + 1,   2, outline_color)
    print("storks: " .. scene.lives, scene.cam.x + 3 - 1,   2, outline_color)
    print("storks: " .. scene.lives, scene.cam.x + 3,       2, text_color)

    if scene.over and scene.won then
        fancy_text({
            text = "complete!",
            text_colors = { 11 },
            background_color = 7,
            bubble_depth = 2,
            x = scene.cam.x + 13,
            y = 58,
            outline_color = 0,
            wiggle = {
                amp = 1.25,
                speed = 1.5,
                offset = 0.33
            },
            letter_width = 12,
            big = true
        })
    elseif scene.over and scene.lost then
        fancy_text({
            text = "game over",
            text_colors = { 8 },
            background_color = 7,
            bubble_depth = 2,
            x = scene.cam.x + 13,
            y = 58,
            outline_color = 0,
            wiggle = {
                amp = 1.25,
                speed = 1.5,
                offset = 0.33
            },
            letter_width = 12,
            big = true
        })
    end
end

function make_scene(size, seed)
    seed = seed or 1234
    size = size or 128 * 3
    local scene = {}

    scene.over = false
    scene.won = false
    scene.lost = false
    scene.lives = 4
    scene.start_time = t()
    scene.revive_cooldown = false
    scene.scene_advance_cooldown = false
    scene.world = make_world(size, seed)
    scene.bird = make_bird(scene.world)
    scene.cam = make_cam(scene.world, scene.bird)
    scene.baby = make_baby(scene.world, scene.bird)
    scene.gators = make_gators(scene.bird, scene.baby, scene.cam)
    scene.balloon = make_balloon(16, 16)
    scene.drones = {}
    scene.juice = {}

    scene.update = _scene_update
    scene.draw = _scene_draw

    return scene
end