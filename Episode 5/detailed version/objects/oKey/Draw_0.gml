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

draw_sprite_ext(sKey, 0, 32, 28, 1, 1, 0, -1, 1);

gpu_set_colorwriteenable(1, 1, 1, 0);
gpu_set_blendmode(bm_max);

var index = array_find(oInfo.colour_order, colours_free);
if (index == -1) {
	instance_destroy();
}
draw_sprite_stretched(sColours, index, 8, 10, 44, 44);

gpu_set_colorwriteenable(1, 1, 1, 1);
gpu_set_blendmode(bm_normal);
surface_reset_target();


draw_surface_ext(colour_surface, (x-32+oInfo.shakex)/ratiox, (y-32+oInfo.shakey+dsin(lifespan*2)*15*sinscale)/ratioy, 1/ratiox, 1/ratioy, 0, -1, 1);


/*var xshift = random_range(-shake, shake);
var yshift = random_range(-shake, shake);

if (animation < 100) { //normal colour key
	draw_sprite_ext(sprite_index, 0,
		x+xshift, y+yshift+dsin(lifespan*2)*15*sinscale,
		image_xscale, image_yscale, rot, -1, 1);
}
	
if (animation > 50) { //white key
	draw_sprite_ext(sprite_index, 1,
		x+xshift, y+yshift+dsin(lifespan*2)*15*sinscale,
		image_xscale, image_yscale, rot, -1, ease_out_cubic(min(1, (animation-50)/50)));
}*/