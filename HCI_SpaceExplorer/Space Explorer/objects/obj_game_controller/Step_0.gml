/// @description Check for mission completion

// Mission 1: Visit Mars
if (!global.missions.visited_mars) {
    var mars_visited = variable_struct_get(global.visited, "Mars");
    if (mars_visited) {
        global.mission_set_completed("visited_mars");
        var mission_text = global.mission_info.visited_mars;
        show_notification("Mission Complete! " + mission_text, global.badge_sprites.visited_mars);
    }
}

// Mission 2: Visit all planets
if (!global.missions.visited_all_planets && global.mission_is_unlocked("visited_all_planets")) {
    var all_visited = true;
    var planet_names = variable_struct_get_names(global.visited);
    for (var i = 0; i < array_length(planet_names); i++) {
        if (!variable_struct_get(global.visited, planet_names[i])) {
            all_visited = false;
            break;
        }
    }
    if (all_visited) {
        global.mission_set_completed("visited_all_planets");
        var mission_text = global.mission_info.visited_all_planets;
        show_notification("Mission Complete! " + mission_text, global.badge_sprites.visited_all_planets);
    }
}

// Mission 3: Visit both Gas Giants (Jupiter and Saturn)
if (!global.missions.visited_gas_giants && global.mission_is_unlocked("visited_gas_giants")) {
    if (global.visited.Jupiter && global.visited.Saturn) {
        global.mission_set_completed("visited_gas_giants");
        var mission_text = global.mission_info.visited_gas_giants;
        show_notification("Mission Complete! " + mission_text, global.badge_sprites.visited_gas_giants);
    }
}

// Mission 4: Visit both Ice Giants (Uranus and Neptune)
if (!global.missions.visited_ice_giants && global.mission_is_unlocked("visited_ice_giants")) {
    if (global.visited.Uranus && global.visited.Neptune) {
        global.mission_set_completed("visited_ice_giants");
        var mission_text = global.mission_info.visited_ice_giants;
        show_notification("Mission Complete! " + mission_text, global.badge_sprites.visited_ice_giants);
    }
}