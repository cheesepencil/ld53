function _drone_update(drone)
    local x_offset = sin(t() * drone.x_speed) * drone.x_amp
    drone.x = drone.start_x + x_offset
    
    local y_offset = cos(t() * drone.y_speed) * drone.y_amp
    drone.y = drone.start_y + y_offset

    if t() - drone.anim_timer_start > drone.anim_timer_duration then
        drone.anim_timer_start = t()
        drone.anim_frame = drone.anim_frame == 12 and 13 or 12
    end
end

function _drone_draw(drone)
    spr(drone.anim_frame, drone.x, drone.y)
end

function make_drone(x, y, x_amp, x_speed, y_amp, y_speed)
    local drone = {
        x = x,
        y = y,
        start_x = x,
        start_y = y,
        x_amp = x_amp,
        x_speed = x_speed,
        y_amp = y_amp,
        y_speed = y_speed,
        anim_timer_start = t(),
        anim_timer_duration = DRONE_BLINK_SPEED,
        anim_frame = 12,
    }

    drone.update = _drone_update
    drone.draw = _drone_draw

    return drone
end