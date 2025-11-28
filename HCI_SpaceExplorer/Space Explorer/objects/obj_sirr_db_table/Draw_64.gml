/// Draw GUI
var icon_size = 32;

var planet_names = variable_struct_get_names(global.visited);

var row_x = 225;
var row_y = 150;
var row_h = 48;

//column x positions
var col_spr		= row_x;
var col_name    = row_x + 50;
var col_visited = row_x + 150;
var col_rings   = row_x + 250;
var col_moons   = row_x + 330;
var col_surface = row_x + 400;


draw_set_font(SIRRDBHeaderFont)

// draw headers for each column in SIRR DB
draw_text(col_spr,     row_y, "");
draw_text(col_name,    row_y, "Planet");
draw_text(col_visited, row_y, "Visited");
draw_text(col_rings,   row_y, "Rings");
draw_text(col_moons,   row_y, "Moons");
draw_text(col_surface, row_y, "Surface");

row_y += row_h;
draw_line(row_x, row_y, row_x + 700, row_y);
row_y += row_h;

draw_set_font(SIRRDBColumnFont)
// Rows
for (var i = 0; i < array_length(planet_names); i++)
{
    var pname = planet_names[i];
	
	// Get planet sprites
	var planetspr = variable_struct_get(global.planet_sprites, pname);
	
	//gets whether planets have been visited from obj_game_controller
    var visited = variable_struct_get(global.visited, pname);

    //gets static planet info for each planet that player has visited
    var info = variable_struct_get(global.planet_info, pname);


	if (planetspr != noone) {
	    var spr_w = sprite_get_width(planetspr);
	    var spr_h = sprite_get_height(planetspr);

	    // Calculate scale to fit icon_size
	    var scale_x = icon_size / spr_w;
	    var scale_y = icon_size / spr_h;
	    // make all uniform scale based on spr width or height to keep aspect ratio
	    var scale = min(scale_x, scale_y);

	    // Center the sprite in the icon column
	    var icon_x = col_spr - (spr_w * scale)/2;
	    var icon_y = row_y + row_h/2 - (spr_h * scale)/2;

	    draw_sprite_ext(planetspr, 0, icon_x, icon_y-15, scale, scale, 0, c_white, 1);
	}
	
    //draw columns
    draw_text(col_name,    row_y, pname);
    draw_text(col_visited, row_y, visited ? "Yes" : "No");
    draw_text(col_rings,   row_y, info.has_rings ? "Yes" : "No");
    draw_text(col_moons,   row_y, string(info.moons));
    draw_text(col_surface, row_y, info.surface);

    row_y += row_h;
}
