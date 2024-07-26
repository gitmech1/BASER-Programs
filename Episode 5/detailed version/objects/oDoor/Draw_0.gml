if (oInfo.rooms <= 2) {
	var ratiox = 1;
	var ratioy = 1;
} else {
	var ratiox = 3264/2560;
	var ratioy = 1824/1440;
}

if !(surface_exists(colour_surface)) {
	colour_surface = surface_create(sprite_width, sprite_height);
}

surface_set_target(colour_surface);


//actual door stuff
if (len(rocks_alive())) {
	draw_sprite_ext(sDoor, 0, 0, 0, image_xscale, image_yscale, 0, -1, 1);
	draw_sprite(sprite_index, 1, (image_xscale-1)*32, (image_yscale-1)*32);
}


//blend in blandin
gpu_set_colorwriteenable(1, 1, 1, 0);
gpu_set_blendmode(bm_max);

//finding which colours are alive
var alive_rocks = rocks_alive();

var index = array_find(oInfo.colour_order, alive_rocks);
if (index != -1) {
	draw_sprite_stretched(sColours, index, 0, 0, sprite_width, sprite_height);
}

//fading
if !(len(rocks_alive())) {
	gpu_set_colorwriteenable(1, 1, 1, 1);
}
gpu_set_blendmode(bm_dest_color);

var fade = max(c[0].fade, c[1].fade, c[2].fade, c[3].fade, c[4].fade);
var col = c_white; //make_color_hsv(0, 0, fade*255);
draw_set_alpha(ease_in(ease_in((clamp(fade, 0, 100)/100)))); //what succinct code
draw_rectangle_color(0, 0, image_xscale*64, image_yscale*64,
	col, col, col, col, false);
draw_set_alpha(1);

gpu_set_colorwriteenable(1, 1, 1, 1);
gpu_set_blendmode(bm_normal);

surface_reset_target();

draw_surface_ext(colour_surface, (x+oInfo.shakex)/ratiox, (y+oInfo.shakey)/ratioy, 1/ratiox, 1/ratioy, 0, -1, 1);