/// @description Draw Missions and Badges on Profile Page

// Set initial drawing position and styles
var start_x = 200;
var start_y = 150;
var row_h = 60;
var badge_size = 96;


draw_set_font(SIRRDBHeaderFont);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw the title for the mission section
draw_text(start_x, start_y - 50, "Space Missions");

// Set up for the badge collection
var badge_area_x = 800; // Increased this to move the whole section right
var badge_area_y = 150;

draw_set_font(SIRRDBHeaderFont);
draw_set_halign(fa_center); // Center the title text
draw_text(badge_area_x, start_y - 50, "Mission Badges");
draw_set_halign(fa_left); // Set it back to left for mission text
// Get all the mission names from your global struct
var mission_names = variable_struct_get_names(global.missions);

// Loop through each mission to draw it
for (var i = 0; i < array_length(mission_names); i++) {
    var mission_id = mission_names[i];
    
    // Safely get data from the global structs using the mission_id string
    var mission_completed = variable_struct_get(global.missions, mission_id);
    var mission_desc = variable_struct_get(global.mission_info, mission_id);
    // Be defensive: if the helper isn't loaded yet, treat mission as unlocked to avoid crashes.
    var mission_unlocked = variable_global_exists("mission_is_unlocked") ? global.mission_is_unlocked(mission_id) : true;
    var badge_sprite = variable_struct_get(global.badge_sprites, mission_id);
    
    var current_y = start_y + (i * row_h);
    
    // --- Draw Badge ---
    if (badge_sprite != noone && sprite_exists(badge_sprite)) {
        var scale = badge_size / sprite_get_width(badge_sprite);
        var badge_color = mission_completed ? c_white : c_black;
        var badge_alpha = mission_completed ? 1.0 : 0.8;
        draw_sprite_ext(badge_sprite, 0, start_x, current_y, scale, scale, 0, badge_color, badge_alpha);
    }
    
    // --- Draw Mission Text ---
    draw_set_font(SIRRDBHeaderFont);
    var text_color = mission_completed ? c_white : c_gray;
    var text_x_pos = start_x;
    // If locked, draw a clear locked hint. If unlocked, draw normally.
    if (!mission_unlocked) {
        draw_set_color(c_gray);
        draw_text(text_x_pos, current_y + 10, mission_desc + " (Locked)"); // was + 50
    } else {
        draw_set_color(text_color);
        // Draw the mission description
        draw_text(text_x_pos, current_y + 10, mission_desc);
    }
	
	// --- Draw Badge Indicator on the right if mission is completed ---
	if (mission_completed) {
		// Align the medal with the mission text and make it 20% smaller
		var medal_y = current_y + 10;
		var medal_scale = (badge_size / sprite_get_width(spr_mission_complete_medal)) * 0.8;
		// Draw the sprite using draw_sprite_ext to control its size
		// We also need to change the vertical alignment to draw from the top
		draw_sprite_ext(spr_mission_complete_medal, 0, badge_area_x, medal_y, medal_scale, medal_scale, 0, c_white, 1);
	}
	
    draw_set_color(c_white);
}

// Reset drawing settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(1);