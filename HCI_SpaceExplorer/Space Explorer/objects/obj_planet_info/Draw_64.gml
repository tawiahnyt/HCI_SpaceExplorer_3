
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

//Background Box dimensions that text sits in
var box_w = gui_w * 0.30;
var box_h = gui_h * 0.12;

// Bottom-center positioning for the text box
var box_x = (gui_w - box_w) * 0.5;
var box_y = gui_h - box_h - 50; // 40px padding from bottom

// Get the current planet name and corresponding description
var curr_planet = string(global.game.location);
var msg = variable_struct_get(global.planet_descriptions, curr_planet);

// Draw box background
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

// Draw planet name text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(DisplayFont);


draw_text_ext(box_x + 20, box_y + 20, msg, -1, box_w - 30);