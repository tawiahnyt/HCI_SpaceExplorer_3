// Fixed position
var text_x = 1235;
var text_y = 400;

// Get values
var next_room = global.game.next_location;
var next_planet_text = variable_struct_get(global.room_mappings, next_room);


// Draw text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(DisplayFont);

var msg = "Travel to " + next_planet_text

draw_text(text_x, text_y, msg);