// Draw GUI Event
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Define box dimensions
var box_w = gui_w * 0.30;
var box_h = gui_h * 0.15;

// Top-right corner position
var box_x = gui_w - box_w - 60; // 100px padding from right edge
var box_y = 200; // 20px from top

// Draw box background
draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

// Draw text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(DisplayFont);
var welcome_msg = "Hi! You have made your way to my database page. All the information I am storing is shown in the table. "
			+ "Try clicking the buttons below me while exploring planets and I will keep track of where you explore!";

draw_text_ext(box_x + 20, box_y + 20, welcome_msg, -1, box_w - 15);
