if (lifespan%20 < 10) && (lifespan < 60) {
	for (var i = 0; i < len(highlighted_piece); i++) {
		for (var j = 0; j < len(highlighted_piece[i]); j++) {
			if (highlighted_piece[i][j] == 1) {
				var xx = x+(distance+j)*oInfo.square_size;
				var yy = y+(oInfo.grid_h-height+i)*oInfo.square_size;
				draw_rectangle_color_simple(xx, yy, xx+oInfo.square_size, yy+oInfo.square_size, c_white);
			}
		}
	}
}

if (lifespan%20 == 0) & (lifespan < 60) {
	sfx(btn155, 100, false, 0.3);
}