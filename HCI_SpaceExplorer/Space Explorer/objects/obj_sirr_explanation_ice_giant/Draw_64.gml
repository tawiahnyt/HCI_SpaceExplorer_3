// Draw GUI Event
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Define box dimensions
var box_w = gui_w * 0.20;
var box_h = gui_h * 0.12;

// Top-right corner position
var box_x = gui_w - box_w - 125; // 100px padding from right edge
var box_y = 210;

// Draw box background
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

// Draw text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(DisplayFont);
var welcome_msg = "Welcome to " + global.game.location + "! This planet is one of the ice giants."
+ " I am getting cold just being close to this planet!";

draw_text_ext(box_x + 20, box_y + 20, welcome_msg, -1, box_w - 15);
