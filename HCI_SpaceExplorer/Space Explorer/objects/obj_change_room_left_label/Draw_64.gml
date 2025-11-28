// Fixed position
var text_x = 15;
var text_y = 400;

// Get values
var prev_room = global.game.prev_location;
var prev_planet_text = variable_struct_get(global.room_mappings, prev_room);


// Draw text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(DisplayFont);

var msg = "Travel to " + prev_planet_text

draw_text(text_x, text_y, msg);