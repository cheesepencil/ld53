function _title_update(scene, inputs)
    if t() - scene.start_time > 1 and inputs.btn_o then
        change_scene(make_tutorial_level())
    end

    if t() - scene.flap_timer > 0.5 then
        scene.flap_timer = t()
        scene.bird_sprite = scene.bird_sprite == 0 and 2 or 0
    end

    if t() - scene.chomp_timer > 0.125 then
        scene.chomp_timer = t()
        scene.l_chomp_sprite = scene.l_chomp_sprite == 6 and 22 or 6
        scene.r_chomp_sprite = scene.r_chomp_sprite == 6 and 22 or 6
    end
end

function _title_draw(scene)
    camera()
    cls(14)
    fancy_text({
        text = "bundle dumper",
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
        text = "florida edition",
        text_colors = { 1 },
        background_color = 7,
        x = 50,
        y = 26,
        bubble_depth = 1,
    })

    local x = 64 - 8
    local y = 64 - 8
    circfill(x + 8, y + 8, 18, 15)
    circfill(x + 8, y + 8, 16, 12)
    spr(scene.bird_sprite, x, y, 2, 2)
    spr(4, x + 11, y + 8)

    spr(scene.l_chomp_sprite, 18, y + 8 , 2, 1)
    spr(scene.r_chomp_sprite, 128 - 16 - 18, y + 8, 2, 1, true)

    y = 64 - 16 + 48
    print('ludum dare 53 - "delivery"', 10, y + 2, 1)
    print("by cheesepencil", 32, y + 8, 1)

    fancy_text({
        text = "press 🅾️  to start!",
        x = 32 - 6,
        y = 127 - 10,
        background_color = 13,
        text_colors = { 10 },
        outline_color = 0
    })
end

function make_title_scene()
    local title = {}

    title.bird_sprite = 0
    title.l_chomp_sprite = 6
    title.r_chomp_sprite = 22
    title.flap_timer = t()
    title.chomp_timer = t()
    title.start_time = t()
    title.draw = _title_draw
    title.update = _title_update

    return title
end