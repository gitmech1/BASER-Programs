function draw_trongle(trongle, colp, colf){ //draws triangle with border
	draw_triangle_color(trongle[0][0][0], trongle[0][0][1], trongle[0][1][0], trongle[0][1][1], trongle[0][2][0], trongle[0][2][1], colf, colf, colf, false);
	draw_line_width_color(trongle[0][0][0], trongle[0][0][1], trongle[0][1][0], trongle[0][1][1], width, colp, colp); //line 1
	draw_line_width_color(trongle[0][1][0], trongle[0][1][1], trongle[0][2][0], trongle[0][2][1], width, colp, colp); //line 2
	draw_line_width_color(trongle[0][2][0], trongle[0][2][1], trongle[0][0][0], trongle[0][0][1], width, colp, colp); //line 3
}