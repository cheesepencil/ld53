function _gators_update(gators)
    local interested_altitude = 128 - 48
    local death_zone = 128 - 16
    local interesting_baby = gators.baby and gators.baby.y >= interested_altitude and gators.baby or nil
    local interesting_bird = gators.bird and gators.bird.y >= interested_altitude and gators.bird or nil
    
    if interesting_baby or interesting_bird then
        if interesting_baby and interesting_bird then
            local left_interesting_creature
            local right_interesting_creature
            if interesting_bird.x <= interesting_baby.x then
                left_interesting_creature = interesting_bird
                right_interesting_creature = interesting_baby
            else
                left_interesting_creature = interesting_baby
                right_interesting_creature = interesting_bird
            end
            
            gators.left_gator.target_x = left_interesting_creature.x + 24
            gators.left_gator.distance = (left_interesting_creature.y - interested_altitude) / (death_zone - interested_altitude) 
            gators.left_gator.distance = gators.left_gator.distance > 1 and 1 or gators.left_gator.distance
            gators.left_gator.x = gators.cam.x - 16 + (gators.left_gator.target_x - gators.cam.x - 16) * gators.left_gator.distance

            gators.right_gator.target_x = right_interesting_creature.x
            gators.right_gator.distance = (right_interesting_creature.y - interested_altitude) / (death_zone - interested_altitude)
            gators.right_gator.distance = gators.right_gator.distance > 1 and 1 or gators.right_gator.distance
            gators.right_gator.x = gators.cam.x + 128 - (gators.cam.x + 128 - gators.right_gator.target_x) * gators.right_gator.distance
        else
            local interesting_creature = interesting_baby or interesting_bird
            gators.left_gator.target_x = interesting_creature.x + 24
            gators.left_gator.distance = (interesting_creature.y - interested_altitude) / (death_zone - interested_altitude) 
            gators.left_gator.distance = gators.left_gator.distance > 1 and 1 or gators.left_gator.distance
            gators.left_gator.x = gators.cam.x - 16 + (gators.left_gator.target_x - gators.cam.x - 16) * gators.left_gator.distance

            gators.right_gator.target_x = interesting_creature.x
            gators.right_gator.distance = (interesting_creature.y - interested_altitude) / (death_zone - interested_altitude)
            gators.right_gator.distance = gators.right_gator.distance > 1 and 1 or gators.right_gator.distance
            gators.right_gator.x = gators.cam.x + 128 - (gators.cam.x + 128 - gators.right_gator.target_x) * gators.right_gator.distance
        end
    else
        if gators.left_gator.x > gators.cam.x -16 then gators.left_gator.x -= 8 end
        if gators.right_gator.x < gators.cam.x + 128 then gators.right_gator.x += 8 end
    end

    if t() - gators.anim_timer_start > gators.anim_timer_duration then
        gators.anim_timer_start = t()
        gators.anim_timer_duration = GATOR_CHOMP_SPEED
        gators.left_gator.anim_frame = gators.left_gator.anim_frame == 6 and 22 or 6
        gators.right_gator.anim_frame = gators.right_gator.anim_frame == 6 and 22 or 6
    end

    if t() - gators.hop_timer_start > gators.hop_timer_duration then
        gators.hop_timer_start = t()
        gators.hop_timer_duration = GATOR_HOP_SPEED
        gators.left_gator.y = gators.left_gator.y == 128 - 15 and 128 - 19 or 128 - 15
        gators.right_gator.y = gators.right_gator.y == 128 - 15 and 128 - 19 or 128 - 15
    end
end

function _gators_draw(gators)
    local outline_color = 0
    
    -- left gator
    pal({
        [7] = outline_color,
        [3] = outline_color,
        [4] = outline_color,
    })
    spr(gators.left_gator.anim_frame, gators.left_gator.x-1, gators.left_gator.y, 2, 1)
    spr(gators.left_gator.anim_frame, gators.left_gator.x+1, gators.left_gator.y, 2, 1)
    spr(gators.left_gator.anim_frame, gators.left_gator.x, gators.left_gator.y-1, 2, 1)
    spr(gators.left_gator.anim_frame, gators.left_gator.x, gators.left_gator.y+1, 2, 1)
    
    pal()
    spr(gators.left_gator.anim_frame, gators.left_gator.x, gators.left_gator.y, 2, 1)

    -- right gator
    pal({
        [7] = outline_color,
        [3] = outline_color,
        [4] = outline_color,
    })
    spr(gators.right_gator.anim_frame, gators.right_gator.x-1, gators.right_gator.y, 2, 1, true)
    spr(gators.right_gator.anim_frame, gators.right_gator.x+1, gators.right_gator.y, 2, 1, true)
    spr(gators.right_gator.anim_frame, gators.right_gator.x, gators.right_gator.y-1, 2, 1, true)
    spr(gators.right_gator.anim_frame, gators.right_gator.x, gators.right_gator.y+1, 2, 1, true)

    pal()
    spr(gators.right_gator.anim_frame, gators.right_gator.x, gators.right_gator.y, 2, 1, true)
end

function make_gators(bird, baby, cam)
    local gators = {
        bird = bird,
        baby = baby,
        cam = cam,
        eating = false,
        anim_timer_start = t(),
        anim_timer_duration = GATOR_CHOMP_SPEED,
        hop_timer_start = t(),
        hop_timer_duration = GATOR_HOP_SPEED,
    }

    gators.left_gator = {
        x = cam.x - 16, 
        y = 128 - 19,
        target_x = cam.x, 
        distance = 1,
        anim_frame = 6,
    }
    gators.right_gator = {
        x = cam.x + 128, 
        y = 128 - 15,
        target_x = cam.x + 128,
        distance = 1,
        anim_frame = 22,
    }

    gators.update = _gators_update
    gators.draw = _gators_draw

    return gators
end