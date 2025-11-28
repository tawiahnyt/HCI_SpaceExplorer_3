///@description Interact - Add current room to SIRR's Database
var location = global.game.location;
global.visited[$ location] = true;


if(global.visited[$ location] == true){
sprite_index = spr_save_button_sirr_clicked;
// Draw the text centered on top
draw_set_font(DisplayFont);
button_text = location + " saved!"
var text_w = string_width(button_text);
var text_h = string_height(button_text);

//var text_x = x + ((sprite_get_width(sprite_index)*0.2652124 - text_w) / 2);
//var text_y = (y + (sprite_get_height(sprite_index)*0.2652124 - text_h) / 2);

var text_x = (x+10) + (sprite_get_width(sprite_index)*0.1652124 - text_w) / 2;
var text_y = y + (sprite_get_height(sprite_index)*0.155814 - text_h) / 2;
draw_text(text_x, text_y, button_text);

}