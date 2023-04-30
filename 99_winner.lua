function _winner_update(scene, inputs)
    if t() - scene.start_time > 2 and inputs.btn_o then
        change_scene(make_title_scene())
    end
end

function _winner_draw(scene)
    camera()
    cls(12)
    rectfill(0, 64, 128, 128, 9)
    fillp(░)
    rectfill(0, 64, 128, 128, 10)
    fillp()

    for i = 0, 48 do
        line(i, 128, i - 9, 64, 1)
        rectfill(0, 64, 30, 128, 1)
    end

    spr(128, 64, 48, 8, 8)
    fancy_text({
        text = "you win!",
        text_colors = { 15 },
        background_color = 7,
        bubble_depth = 2,
        x = 13,
        y = 8,
        outline_color = 1,
        wiggle = {
            amp = 1.25,
            speed = 1.5,
            offset = 0.33
        },
        letter_width = 8,
        big = true
    })

    fancy_text({
        text = "all babies delivered",
        text_colors = { 1 },
        background_color = 7,
        x = 40,
        y = 26,
        bubble_depth = 1,
    })

    local y = 64 - 16
    local minutes = flr(scene.elapsed_time / 60)
    local seconds = flr(scene.elapsed_time) % 60
    print("elapsed time:", 10, y + 2, 1)
    print(minutes .. "m " .. seconds .. "s", 32, y + 8, 1)

    fancy_text({
        text = "press 🅾️  to retry!",
        x = 32 - 6,
        y = 127 - 10,
        background_color = 13,
        text_colors = { 10 },
        outline_color = 0
    })
end

function make_winner_scene(game_start_time)
    local winner = {}

    game_start_time = game_start_time or t()

    winner.start_time = t()
    winner.elapsed_time = t() - game_start_time
    winner.draw = _winner_draw
    winner.update = _winner_update

    return winner
end