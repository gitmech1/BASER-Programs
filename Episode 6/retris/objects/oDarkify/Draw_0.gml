if (len(to_do)) {
	for (var i = 0; i < len(to_do); i++) {
		var g = to_do[i];
		draw_set_alpha((1 - g[2](g[0]/g[1], g[3]))*g[4]);
		draw_rectangle_color_simple(0, 0, room_width, room_height, c_black);
		draw_set_alpha(1);
	}
}