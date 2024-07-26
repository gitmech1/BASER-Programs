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
	
} else {
	
	var subimg = 1+(lifespan)%2;
	var xoffset = random_range(-1, 1);
	var yoffset = random_range(-1, 1);
	var width = 64*size;
	var a = image_angle;
	var rotation = -image_angle;
	
	
	if !(surface_exists(colour_surface)) {
		colour_surface = surface_create(sprite_width, sprite_height);
	}
	
	surface_set_target(colour_surface);
	
	clear_surface();
	
	draw_sprite_ext(sprite_index, subimg, 0, 0, image_xscale, image_yscale, 0, -1, 1);
	
	gpu_set_colorwriteenable(1, 1, 1, 0);
	gpu_set_blendmode(bm_max);
	
	var index = array_find(oInfo.colour_order, el_rocino);
	if ((rotation+360*100)%360 == 0) {
		draw_sprite_ext(sColours, index, 0, 0, image_xscale, 2*image_yscale, rotation, -1, 1);
	} else if ((rotation+360*100)%360 == 90) {
		draw_sprite_ext(sColours, index, 0, 128*image_yscale, 2*image_xscale, image_yscale, rotation, -1, 1);
	} else if ((rotation+360*100)%360 == 180) {
		draw_sprite_ext(sColours, index, 64*image_xscale, 128*image_yscale, image_xscale, 2*image_yscale, rotation, -1, 1);
	} else if ((rotation+360*100)%360 == 270) {
		draw_sprite_ext(sColours, index, 64*image_xscale, 0, 2*image_xscale, image_yscale, rotation, -1, 1);
	}
	
	gpu_set_colorwriteenable(1, 1, 1, 1);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	
	draw_surface_ext(colour_surface, (x+xoffset+oInfo.shakex)/ratiox, (y+yoffset+oInfo.shakey)/ratioy, 1/ratiox, 1/ratioy, image_angle, -1, 1);
	
	//air
	draw_sprite_ext(sAir, lifespan%3, (x+oInfo.shakex+ldx(width, a)+ldx(width, a-90))/ratioy, (y+oInfo.shakey+ldy(width, a)+ldy(width, a-90))/ratioy, size/ratiox, size/ratioy, a-90, -1, 0.3);
}