function _scene_revive_bird(scene)
    scene.lives -= 1
    scene.bird = make_bird(scene.world, scene.balloon.x + 8, scene.balloon.y + 16)
    scene.cam.bird = scene.bird
    scene.gators.bird = scene.bird
    for redhat in all(scene.redhats) do
        redhat.bird = scene.bird
    end
end

function _scene_kill_bird(scene, color)
    color = color or 8
    scene.revive_cooldown = true
    local function clean_up(juice)
        del(scene.juice, juice)
        if scene.lives > 0 then scene.revive_cooldown = false end
    end
    add(scene.juice, make_splash(scene.bird.x + 8, scene.bird.y + 4, color, clean_up))
    scene.bird = nil
    scene.gators.bird = nil
    if scene.baby then scene.baby.bird = nil end
    scene.cam.bird = nil
    for redhat in all(scene.redhats) do
        redhat.bird = nil
    end
end

function _scene_kill_baby(scene, color)
    color = color or 8
    local function clean_up(juice)
        del(scene.juice, juice)
    end
    add(scene.juice, make_splash(scene.baby.x, scene.baby.y, color, clean_up))
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

    if scene.over and t() - scene.input_cooldown_timer_start > SCENE_ADVANCE_COOLDOWN_DURATION then
        if scene.won then
            if inputs.btn_o then
                next_level = scene.next_level_callback(scene.start_time, scene.lives)
                change_scene(next_level) 
            end
        elseif scene.lost then
            if inputs.btn_x then change_scene(scene.retry_callback()) end
            if inputs.btn_o then
                change_scene(scene.retry_callback(scene.start_time))
            end
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
    for redhat in all(scene.redhats) do
        redhat:update()
    end
    for juice in all(scene.juice) do
        juice:update()
    end
    scene.sun:update(scene.bird)

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
    if scene.baby and scene.baby.dropped then
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

    -- baby vs drone
    if scene.baby and not DEBUG then
        for drone in all(scene.drones) do
            local collision = collide_bird_vs_drone(scene.baby, drone)
            if collision then
                _scene_kill_baby(scene)
                break
            end
        end
    end

    -- gators vs bird
    if scene.bird and not DEBUG then
        local bird_collision = collide_bird_vs_gator(scene.bird, scene.gators.left_gator)
        bird_collision = bird_collision or collide_bird_vs_gator(scene.bird, scene.gators.right_gator)
        if bird_collision then _scene_kill_bird(scene) end
    end

    -- drone vs bird
    if scene.bird and not DEBUG then
        for drone in all(scene.drones) do
            local collision = collide_bird_vs_drone(scene.bird, drone)
            if collision then
                _scene_kill_bird(scene)
                break
            end
        end
    end

    -- bird vs sun
    if scene.bird and scene.sun.danger and not DEBUG then
        _scene_kill_bird(scene, 0)
        if scene.baby and not scene.baby.dropped then
            _scene_kill_baby(scene, 0)
        end
    end

    -- bird vs bullets
    if scene.bird and #scene.redhats > 0 and not DEBUG then
        for redhat in all(scene.redhats) do
            local broken = false
            for bullet in all(redhat.bullets) do
                local collision = collide_bird_vs_bullet(scene.bird, bullet)
                if collision then
                    _scene_kill_bird(scene)
                    broken = true
                    break
                end
            end
            if broken then break end
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
        print("<- baby dispenser", 32 + 16, 32, 1)
        print("tap 🅾️ to flap", 72, 72, 1)
        print("⬅️ and ➡️ to change direction", 72 - 10, 72 + 24, 1)
        print("hold ❎ to aim", 150, 32, 1)
        print("release ❎ to deliver...", 170, 42, 1)
        print("<- missed? get more babies", 178, 58, 1)
        print("avoid drones", 128 * 3 - 72 - 24, 64, 1)
        print("and other hazards", 128 * 3 - 72 - 24, 72, 1)
        print("deliver baby here ->", 128 * 3 - 100 - 10, 110)
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
    for redhat in all(scene.redhats) do
        redhat:draw()
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

    scene.sun:draw(scene.cam)

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
        fancy_text({
            text = "press 🅾️  to continue!",
            x = scene.cam.x + 32 - 6,
            y = 127 - 32,
            background_color = 13,
            text_colors = { 10 },
            outline_color = 0
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
        fancy_text({
            text = "🅾️  retry",
            x = scene.cam.x + 32 - 6,
            y = 127 - 32,
            background_color = 13,
            text_colors = { 10 },
            outline_color = 0
        })
        fancy_text({
            text = "❎  give up",
            x = scene.cam.x + 32 - 6 + 6 * 8,
            y = 127 - 32,
            background_color = 13,
            text_colors = { 10 },
            outline_color = 0
        })
    end
    if scene.start_time and DEBUG then
        print(tostr(t() - scene.start_time), scene.cam.x + 2, 22, 0)
        print("bird x: " .. (scene.bird and scene.bird.x or "no bird"), scene.cam.x + 2, 14)
    end

    if DEBUG and btnp(⬇️) then
        printh("bird at: " .. (scene.bird and flr(scene.bird.x) or "no bird..."))
    end
    if DEBUG and btnp(⬆️) and scene.bird then
        scene.bird.update = function() printh() end
    end
end

function make_scene(config)
    config = config or {}
    config.seed = config.seed or 1234 -- tutorial
    config.size = config.size or 128 * 3 -- tutorial
    config.start_time = config.start_time or t()
    config.lives = config.lives or 5
    config.retry_callback = config.retry_callback or make_title_scene
    config.next_level_callback = config.next_level_callback or make_title_scene
    local scene = {}

    scene.retry_callback = config.retry_callback
    scene.next_level_callback = config.next_level_callback
    scene.over = false
    scene.won = false
    scene.lost = false
    scene.lives = config.lives
    scene.start_time = config.start_time
    scene.revive_cooldown = false
    scene.scene_advance_cooldown = false

    scene.world = make_world(config.size, config.seed)
    scene.bird = make_bird(scene.world)
    scene.cam = make_cam(scene.world, scene.bird)
    scene.baby = make_baby(scene.world, scene.bird)
    scene.gators = make_gators(scene.bird, scene.baby, scene.cam)
    scene.balloon = make_balloon(16, 16)
    scene.sun = make_sun()
    scene.redhats = {}
    scene.drones = {}
    scene.juice = {}

    scene.update = _scene_update
    scene.draw = _scene_draw

    return scene
end