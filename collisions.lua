function collide_long_bois(actor1, actor2)
    local a1 = {
        x = actor1.x,
        y = actor1.y,
        h = 8,
        w = 16
    }
    local a2 = {
        x = actor2.x,
        y = actor2.y,
        h = 8,
        w = 16
    }

    if a1.x < a2.x + a2.w and
        a1.x + a1.w > a2.x and 
        a1.y < a2.y + a2.h and
        a1.h + a1.y > a2.y then
            return true
        else
            return false
        end
end