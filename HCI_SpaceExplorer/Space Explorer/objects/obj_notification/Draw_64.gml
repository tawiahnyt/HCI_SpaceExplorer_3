// --- Draw GUI Event for obj_notification ---

// --- Handle Fade In/Out ---
var time_left = alarm[0];
var total_time = room_speed * 4; // Must match the duration set in the Create event

if (time_left > total_time - fade_in_time) {
    // Fading in
    alpha = min(1, alpha + 1 / fade_in_time);
} else if (time_left < fade_out_time) {
    // Fading out
    alpha = max(0, alpha - 1 / fade_out_time);
} else {
    alpha = 1; // Fully visible
}

// --- Drawing ---
var gui_w = display_get_gui_width();
var box_w = 500;
var box_h = 80;
var box_x = (gui_w / 2) - (box_w / 2); // Center the box
var box_y = 50;

// Draw the background box
draw_set_color(c_black);
draw_set_alpha(0.7 * alpha);
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

// Draw the notification text
draw_set_font(SIRRDBHeaderFont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(1 * alpha);
draw_text(box_x + box_w / 2, box_y + box_h / 2, message);

// Reset drawing settings
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
