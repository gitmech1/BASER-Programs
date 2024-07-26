if (state != col) { //off
	x -= 9999;
	y -= 9999;
	draw_sprite_ext(sprite_index, col, realx, realy, image_xscale, image_yscale, image_angle,
		#333333, 1);
} else { //on
	x = realx;
	y = realy;
	draw_sprite_ext(sprite_index, col, x, y, image_xscale, image_yscale, image_angle,
		-1, 1);
}