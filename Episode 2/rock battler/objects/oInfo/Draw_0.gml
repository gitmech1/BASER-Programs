draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(font);

if (lifespan < 20) {
	var scale = 1000000*(power(0.5, lifespan));
	draw_text_transformed_color(1280, 624+lifespan*20, roundtext, scale, scale, 0, c_white, c_white, c_white, c_white, 1);
} else {
	draw_text_transformed_color(1280, 1024+max(0, (lifespan*15-1350)), roundtext, 1, 1, 0, c_white, c_white, c_white, c_white, 1-max(0, (lifespan*15-1350))/500);
}

if (lifespan == 20) {
	sfx(sfxBoom, 2000, false, 1.5, 1.1);
	sfx(sfxBoom2, 2000, false, 1.2, 0.5);
}