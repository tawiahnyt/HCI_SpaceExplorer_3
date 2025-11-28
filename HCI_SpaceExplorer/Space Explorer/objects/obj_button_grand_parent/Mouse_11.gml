//@description Unhover

image_xscale = image_xscale/1.2
image_yscale = image_yscale/1.2



if (variable_instance_exists(id, "label")) {
    
	var text_w = string_width(obj_button_grand_parent.label);
	var text_h = string_height(obj_button_grand_parent.label);

	var text_x = x + ((sprite_get_width(sprite_index)*0.2652124 - text_w) / 2);
	var text_y = (y + (sprite_get_height(sprite_index)*0.2652124 - text_h) / 2);

	draw_text(text_x, text_y, label);
}