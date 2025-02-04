if (len(to_do)) {
	for (var i = 0; i < len(to_do); i++) {
		var g = to_do[i];
		draw_set_alpha((1 - g[2](g[0]/g[1], g[3]))*g[4]);
		draw_rectangle_color_simple(oC.cx1, oC.cy1, oC.cx2, oC.cy2, c_black);
		draw_set_alpha(1);
	}
}