function _tutorial_update(tutorial)
    printh()
end

function _tutorial_text(text, min_x, y, cam)
    local x = cam.x + 1 > min_x and cam.x + 1 or min_x
    print(text, x, y, 1)
end

function _tutorial_draw(tutorial, cam)
    _tutorial_text("<- baby dispenser", 48, 24, cam)

    local tut_count = 0
    local tuts = {
        "⬅️ and ➡️ to turn",
        "🅾️ to flap",
        "hold ❎ to aim",
        "release ❎ to deliver...",
        "<- missed? get more babies"
    }
    for tut in all(tuts) do
        _tutorial_text(tut, 80 + (tut_count * 32), 31 + (tut_count * 7), cam)
        tut_count += 1
    end

    print("avoid drones", 128 * 3 - 72 - 24, 72, 1)
    print("and other hazards", 128 * 3 - 72 - 24, 79, 1)
    print("deliver baby here ->", 128 * 3 - 100 - 10, 110)
end

function make_tutorial_text()
    local tutorial = {}

    tutorial.draw = _tutorial_draw
    tutorial.update = _tutorial_update

    return tutorial
end