/// @description Update visited status when entering a new room

// Get the name of the current room from the room_mappings struct
var current_planet_name = variable_struct_get(global.room_mappings, room);

// If the current room is a valid planet in our tracking list...
if (current_planet_name != undefined && variable_struct_exists(global.visited, current_planet_name)) {
    
    // ...set its visited status to true.
    variable_struct_set(global.visited, current_planet_name, true);
    show_debug_message("Just Visited: " + current_planet_name);

	// Check for mission completions
	// Mission: Visit Mars
	if (global.visited.Mars && !global.missions.visited_mars && global.mission_is_unlocked("visited_mars")) {
		global.mission_set_completed("visited_mars");
		show_notification("Mission Complete: Red Planet Rover!", obj_notification);
	}

	// Mission: Visit Gas Giants (Jupiter and Saturn)
	if (global.visited.Jupiter && global.visited.Saturn && !global.missions.visited_gas_giants && global.mission_is_unlocked("visited_gas_giants")) {
		global.mission_set_completed("visited_gas_giants");
		show_notification("Mission Complete: Gas Giant Explorer!", obj_notification);
	}
	
	// Mission: Visit Ice Giants (Uranus and Neptune)
	if (global.visited.Uranus && global.visited.Neptune && !global.missions.visited_ice_giants && global.mission_is_unlocked("visited_ice_giants")) {
		global.mission_set_completed("visited_ice_giants");
		show_notification("Mission Complete: Ice Giant Explorer!", obj_notification);
	}

	// Mission: Visit all planets
	if (global.visited.Sun && global.visited.Mercury && global.visited.Venus && global.visited.Mars && global.visited.Jupiter && global.visited.Saturn && global.visited.Uranus && global.visited.Neptune && !global.missions.visited_all_planets && global.mission_is_unlocked("visited_all_planets")) {
		global.mission_set_completed("visited_all_planets");
		show_notification("Mission Complete: Solar System Voyager!", obj_notification);
	}
	
	// Mission: Visit all planets with rings (Jupiter, Saturn, Uranus, Neptune)
	if (global.visited.Jupiter && global.visited.Saturn && global.visited.Uranus && global.visited.Neptune && !global.missions.visited_ringed_planets && global.mission_is_unlocked("visited_ringed_planets")) {
		global.mission_set_completed("visited_ringed_planets");
		show_notification("Mission Complete: Ring Collector!", obj_notification);
	}
	
	// Mission: Inner Circle Tour (Mercury, Venus, Mars)
	if (global.visited.Mercury && global.visited.Venus && global.visited.Mars && !global.missions.visited_inner_planets && global.mission_is_unlocked("visited_inner_planets")) {
		global.mission_set_completed("visited_inner_planets");
		show_notification("Mission Complete: Inner Circle Tour!", obj_notification);
	}
	
	// Mission: Moon Enthusiast (Visit a planet with > 50 moons)
	if ((global.visited.Jupiter || global.visited.Saturn) && !global.missions.visited_many_moons && global.mission_is_unlocked("visited_many_moons")) {
		global.mission_set_completed("visited_many_moons");
		show_notification("Mission Complete: Moon Enthusiast!", obj_notification);
	}
	
	// Mission: First Steps (Mercury and Venus)
	if (global.visited.Mercury && global.visited.Venus && !global.missions.visited_first_steps && global.mission_is_unlocked("visited_first_steps")) {
		global.mission_set_completed("visited_first_steps");
		show_notification("Mission Complete: First Steps!", obj_notification);
	}
	
	// Mission: Solar Flare (Visit the Sun)
	if (global.visited.Sun && !global.missions.visited_sun && global.mission_is_unlocked("visited_sun")) {
		global.mission_set_completed("visited_sun");
		show_notification("Mission Complete: Solar Flare!", obj_notification);
	}
	
	// Mission: Rocky Road (Mercury and Mars)
	if (global.visited.Mercury && global.visited.Mars && !global.missions.visited_rocky_worlds && global.mission_is_unlocked("visited_rocky_worlds")) {
		global.mission_set_completed("visited_rocky_worlds");
		show_notification("Mission Complete: Rocky Road!", obj_notification);
	}
}