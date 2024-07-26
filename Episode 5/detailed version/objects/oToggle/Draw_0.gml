var el_rocino = check_rocks();

if (oInfo.rooms <= 2) {
	var ratiox = 1;
	var ratioy = 1;
} else {
	var ratiox = 3264/2560;
	var ratioy = 1824/1440;
}

if !(len(el_rocino)) { //off
	draw_sprite_ext(sprite_index, 0, (x+oInfo.shakex)/ratiox, (y+oInfo.shakey)/ratioy, image_xscale/ratiox, image_yscale/ratioy, image_angle, -1, 1);
		
} else { //on
	
	if !(surface_exists(colour_surface)) {
		colour_surface = surface_create(sprite_width, sprite_height);
	}
	
	surface_set_target(colour_surface);
	
	clear_surface();
	
	draw_sprite_ext(sprite_index, 1, 0, 0, image_xscale, image_yscale, image_angle, -1, 1);
	
	gpu_set_colorwriteenable(1, 1, 1, 0);
	gpu_set_blendmode(bm_max);
	
	var index = array_find(oInfo.colour_order, el_rocino);
	draw_sprite_stretched(sColours, index, 0, 0, image_xscale*64, image_yscale*64);
	
	gpu_set_colorwriteenable(1, 1, 1, 1);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	draw_surface_ext(colour_surface, (x+oInfo.shakex)/ratiox, (y+oInfo.shakey)/ratioy, 1/ratiox, 1/ratioy, 0, -1, 1);
}