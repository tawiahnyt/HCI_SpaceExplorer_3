//Game controller keeps all global variables and game state for progress tracking
persistent = true;

global.game = {
    score: 0,
    location: "Earth",
	prev_location : room_previous(room),
	next_location : room_next(room),
    has_key: false,
    inventory: []
};

global.room_mappings = {};
variable_struct_set(global.room_mappings, rm_sun, "Sun");
variable_struct_set(global.room_mappings, rm_mercury, "Mercury");
variable_struct_set(global.room_mappings, rm_venus, "Venus");
variable_struct_set(global.room_mappings, rm_earth_home, "Earth");
variable_struct_set(global.room_mappings, rm_mars, "Mars");
variable_struct_set(global.room_mappings, rm_jupiter, "Jupiter");
variable_struct_set(global.room_mappings, rm_saturn, "Saturn");
variable_struct_set(global.room_mappings, rm_uranus, "Uranus");
variable_struct_set(global.room_mappings, rm_neptune, "Neptune");


//Used for tracking of SIRRs database
global.visited = {
	Sun: false,
	Mercury: false,
	Venus: false,
	Earth: true, 
	Mars: false,
	Jupiter: false,
	Saturn: false,
	Uranus: false,
	Neptune: false
}

global.planet_info = {
    Sun: {
        has_rings: false,
        moons: 0,
        surface: "Plasma"
    },
    Mercury: {
        has_rings: false,
        moons: 0,
        surface: "Rocky, cratered"
    },
    Venus: {
        has_rings: false,
        moons: 0,
        surface: "Acidic, volcanic"
    },
    Earth: {
        has_rings: false,
        moons: 1,
        surface: "Oceans, land"
    },
    Mars: {
        has_rings: false,
        moons: 2,
        surface: "Dusty, desert"
    },
    Jupiter: {
        has_rings: true,
        moons: 95,
        surface: "Gas giant"
    },
    Saturn: {
        has_rings: true,
        moons: 83,
        surface: "Gas giant with icy rings"
    },
    Uranus: {
        has_rings: true,
        moons: 27,
        surface: "Ice giant"
    },
    Neptune: {
        has_rings: true,
        moons: 14,
        surface: "Ice giant"
    }
};

global.planet_sprites = {
    Sun: spr_sun,
    Mercury: spr_mercury,
    Venus: spr_venus,
    Earth: spr_earth2,
    Mars: spr_mars,
    Jupiter: spr_jupiter,
    Saturn: spr_saturn,
    Uranus: spr_uranus,
    Neptune: spr_neptune
};

global.missions = {
    visited_mars: false,
    visited_gas_giants: false,
	visited_ice_giants: false,
	visited_inner_planets: false,
	visited_many_moons: false,
	visited_first_steps: false,
	visited_sun: false,
	visited_rocky_worlds: false,
    visited_all_planets: false,
};

// Define explicit mission order so we can enforce sequential unlocking.
global.mission_order = [
    "visited_mars",
    "visited_gas_giants",
    "visited_ice_giants",

    "visited_inner_planets",
    "visited_many_moons",
    "visited_first_steps",
    "visited_sun",
    "visited_rocky_worlds",
    // Make the 'visit all planets' mission the last one so completing it doesn't
    // immediately cause earlier missions to be awarded in the same tick.
    "visited_all_planets"
];

// Helper: returns true if the given mission is unlocked (i.e. all prior missions in
// global.mission_order are completed). First mission is always unlocked.
global.mission_is_unlocked = function(mission_id) {
    var order = global.mission_order;
    var idx = -1;
    for (var i = 0; i < array_length(order); i++) {
        if (order[i] == mission_id) {
            idx = i;
            break;
        }
    }
    // If mission not found, default to unlocked (avoid blocking unknown entries)
    if (idx == -1) return true;
    // If it's the first mission, it's unlocked by default
    if (idx == 0) return true;
    // Ensure all earlier missions are completed
    for (var j = 0; j < idx; j++) {
        var prior = order[j];
        if (!variable_struct_get(global.missions, prior)) return false;
    }
    return true;
};

// Save missions to an INI file so progress persists across sessions.
global.save_missions = function() {
    var fname = "missions.ini";
    ini_open(fname);
    var keys = variable_struct_get_names(global.missions);
    for (var i = 0; i < array_length(keys); i++) {
        var k = keys[i];
        var val = variable_struct_get(global.missions, k) ? 1 : 0;
        ini_write_real("missions", k, val);
    }
    ini_close();
};

// Load missions from the INI file if present. Keeps defaults otherwise.
global.load_missions = function() {
    var fname = "missions.ini";
    if (file_exists(fname)) {
        ini_open(fname);
        var keys = variable_struct_get_names(global.missions);
        for (var i = 0; i < array_length(keys); i++) {
            var k = keys[i];
            var def = variable_struct_get(global.missions, k) ? 1 : 0;
            var v = ini_read_real("missions", k, def);
            variable_struct_set(global.missions, k, (v == 1));
        }
        ini_close();
    }
};

// Mark a mission completed and persist immediately. Use this instead of direct assigns.
global.mission_set_completed = function(mission_id) {
    if (!variable_struct_get(global.missions, mission_id)) {
        variable_struct_set(global.missions, mission_id, true);
        // Persist change
        global.save_missions();
    }
};

// Load any saved mission progress now that global.missions exists
global.load_missions();

global.mission_info = {
	visited_mars: "Red Planet Rover: Visit Mars.",
	visited_gas_giants: "Gas Giant Explorer: Visit Jupiter and Saturn.",
	visited_ice_giants: "Ice Giant Explorer: Visit Uranus and Neptune.",
	visited_inner_planets: "Inner Circle Tour: Visit Mercury, Venus, and Mars.",
	visited_many_moons: "Moon Enthusiast: Visit a planet with over 50 moons.",
	visited_first_steps: "First Steps: Visit the two planets closest to the Sun.",
	visited_sun: "Solar Flare: Bravely visit the Sun.",
	visited_rocky_worlds: "Rocky Road: Visit the two rocky desert planets.",
    visited_all_planets: "Solar System Voyager: Visit every planet.",
};


// These will be the sprites for the badges you create
// Example: spr_badge_mars, spr_badge_voyager, etc.
// Make sure to import your badge images as sprites first.
global.badge_sprites = {
    // Safely get the sprite asset by name. If it doesn't exist, assign 'noone'.
    visited_mars: asset_get_index("spr_badge_mars") != -1 ? asset_get_index("spr_badge_mars") : noone, 
    visited_gas_giants: asset_get_index("spr_badge_gas_giants") != -1 ? asset_get_index("spr_badge_gas_giants") : noone,
	visited_ice_giants: asset_get_index("spr_badge_ice_giants") != -1 ? asset_get_index("spr_badge_ice_giants") : noone,
	visited_inner_planets: asset_get_index("spr_badge_inner_circle") != -1 ? asset_get_index("spr_badge_inner_circle") : noone,
	visited_many_moons: asset_get_index("spr_badge_moons") != -1 ? asset_get_index("spr_badge_moons") : noone,
	visited_first_steps: asset_get_index("spr_badge_first_steps") != -1 ? asset_get_index("spr_badge_first_steps") : noone,
	visited_sun: asset_get_index("spr_badge_sun") != -1 ? asset_get_index("spr_badge_sun") : noone,
	visited_rocky_worlds: asset_get_index("spr_badge_rocky") != -1 ? asset_get_index("spr_badge_rocky") : noone,
    visited_all_planets: asset_get_index("spr_badge_voyager") != -1 ? asset_get_index("spr_badge_voyager") : noone,

};


global.planet_descriptions = {
	Sun: "The Sun is the star in the middle of our solar system. "
	 + " Its gravity holds all the planets in one place as they orbit around the plasma ball of energy.",
    Mercury: "Mercury is a small rocky planet that is the closest to the sun of all the planets. This is the fastest planet in our solar system. It rotates around the Sun every 88 Earth days.",
    Venus: "Venus is the second planet from the Sun. It is the hottest planet in our solar system and is predominantly made of clouds. The surface is much too hot for humans to visit.",
    Earth: "Earth is our home planet. Despite all of humanity living on land, the Earth is primarily water! This is why scientists call Earth the pale blue dot." 
	+ " Out of all the planets in our solar system, Earth is the only planet with organic life such as plants and animals.",
    Mars: "Mars is the most similar to Earth. Although it has a dusty, desert-like surface, scientists have sent rovers to Mars to explore the rusty looking planet."
	 + " These rovers found water on Mars which makes it another planet capable of sustaining organic life.",
    Jupiter: "Jupiter is the largest planet. If Jupiter was a hollow shell, 1,000 Earths could fit inside of it."
	+  " Despite the planet Saturn being known for having rings, Jupiter also has faint pale rings and many moons compared to our one moon on Earth.",
    Saturn: "Saturn is a very large planet known for its pronounced rings. The rings of Saturn are made of small chunks of ice and rock coated with other materials like space dust. "
	+ "Interestingly, Saturn does not have a hard surface like Earth. Saturn is a gas giant.",
    Uranus: "Uranus is the seventh planet from the Sun and the third largest planet in our solar system. This planet is very cold and windy. Like Jupiter, it has faint rings. "
	+ "Uranus is the first of two ice giants in the outer part of the solar system.",
    Neptune: "Neptune is the eight and most distant planet from the Sun. Similar to Uranus, it is another ice giant which would be too cold for humans to comfortably visit. "
	+ "Interestingly, this planet does have water like Earth and Mars, but we know very little about the planet because it is so far from Earth."
};