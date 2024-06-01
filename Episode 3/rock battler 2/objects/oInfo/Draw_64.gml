if (countdown < 60) {
	fx_set_parameter(fx, "g_CellSize", 0.0005*power(60-countdown, 3)+1);
	draw_set_alpha((35-countdown)/60);
	draw_rectangle_color(0, 0, 2560, 1440, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}

if (lifespan > 5 && lifespan < 8) || (lifespan > 12 && lifespan < 14) || (lifespan > 14) {
	//nothing on purpose.......
} else {
	draw_set_alpha(0.5);
	draw_sprite(sExtraDarkness, 0, 0, 0);
	draw_set_alpha(1);
}