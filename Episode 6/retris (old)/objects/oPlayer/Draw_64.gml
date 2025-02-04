/*
draw_set_alpha(0.5);
draw_rectangle_color_simple(980, 0, 2560, 300, c_black);
draw_set_alpha(1);
draw_text(1000, 50, "hor: "+string(hor));
//draw_text(1000, 75, "hor_pressed: "+string(hor_pressed));
//draw_text(1000, 100, "hor_released: "+string(hor_released));
draw_text(1000, 125, "distance_wait: "+string(distance_wait));
draw_text(1000, 150, "distance: "+string(distance));
draw_text(1000, 175, "height: "+string(height));
draw_text(1000, 200, "colliding: "+string(check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height)));
draw_text(1000, 225, "piece: "+string(piece));
draw_text(1000, 250, "rotation: "+string(rotation));
var shift = 275;
for (var i = 0; i < 7; i++) {
	for (var j = 0; j < len(oInfo.pieces[i][0]); j++) {
		draw_text(1000, shift, "piece "+string(i)+": "+string(oInfo.pieces[i][0][j]));
		shift += 25;
	}
}

var shift = 0;
for (var j = 0; j < len(grid); j++) {
	var str = "";
	for (var k = 0; k < len(grid[j]); k++) {
		str += string(grid[j][k]) + " ";
	}
	draw_text(2100, shift, str);
	shift += 25;
}
shift+=25;
for (var j = 0; j < len(coloured_grid); j++) {
	var str = "";
	for (var k = 0; k < len(coloured_grid[j]); k++) {
		str += string(coloured_grid[j][k]) + " ";
	}
	draw_text(2100, shift, str);
	shift += 25;
}
*/