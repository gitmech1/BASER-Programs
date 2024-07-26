if (oInfo.rooms <= 2) {
	var ratiox = 1;
	var ratioy = 1;
} else {
	var ratiox = 3264/2560;
	var ratioy = 1824/1440;
}

draw_sprite_ext(sprite_index, round(lifespan/5)%5+5*sign(pressed), (x+oInfo.shakex)/ratiox, (y+oInfo.shakey)/ratioy, image_xscale/ratiox, image_yscale/ratioy, image_angle, -1, 1);