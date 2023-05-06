function _drone_get_hitbox(drone)
    return {
        x = drone.x,
        y = drone.y + 1,
        w = 7,
        h = 3
    }
end

function _drone_update(drone, drone_cycle_start)
    local x_offset = sin((t() - drone_cycle_start) * drone.x_speed + drone.x_delay) * drone.x_amp
    drone.x = drone.start_x + x_offset
    
    local y_offset = cos((t() - drone_cycle_start) * drone.y_speed + drone.y_delay) * drone.y_amp
    drone.y = drone.start_y + y_offset

    if t() - drone.anim_timer_start > drone.anim_timer_duration then
        drone.anim_timer_start = t()
        drone.anim_frame = drone.anim_frame == 12 and 13 or 12
    end
end

function _drone_draw(drone)
    spr(drone.anim_frame, drone.x, drone.y)
end

function make_drone(config)
    config = config or {}
    config.x = config.x or 64
    config.x_amp = config.x_amp or 0
    config.x_speed = config.x_speed or 0
    config.x_delay = config.x_delay or 0
    config.y = config.y or 64
    config.y_amp = config.y_amp or 0
    config.y_speed = config.y_speed or 0
    config.y_delay = config.y_delay or 0

    local drone = {
        x = config.x,
        y = config.y,
        start_x = config.x,
        start_y = config.y,
        x_amp = config.x_amp,
        x_speed = config.x_speed,
        x_delay = config.x_delay,
        y_amp = config.y_amp,
        y_speed = config.y_speed,
        y_delay = config.y_delay,
        anim_timer_start = t(),
        anim_timer_duration = DRONE_BLINK_SPEED,
        anim_frame = 12,
    }

    drone.update = _drone_update
    drone.draw = _drone_draw
    drone.get_hitbox = _drone_get_hitbox

    return drone
end