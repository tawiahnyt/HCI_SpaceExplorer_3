label = "Space Missions";        // The text you want to display
var font_color = c_white;  // Text color


// Draw the text centered on top
draw_set_font(NavigationFont);
draw_set_color(font_color);

var text_w = string_width(label);
var text_h = string_height(label);

var text_x = x + ((sprite_get_width(sprite_index)*0.2652124 - text_w) / 2);
var text_y = (y + (sprite_get_height(sprite_index)*0.2652124 - text_h) / 2);

draw_text(text_x, text_y, label);