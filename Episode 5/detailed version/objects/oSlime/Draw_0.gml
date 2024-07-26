//point generation ==============================================================
var points = [];
array_copy(points, 0, boingpos, 0, len(boingpos));
for (var i = 0; i < width+1; i++) { //top
	var j = i;
	points[j] = [points[j][0], points[j][1]-boings[j]];
}
for (var i = 0; i < height+1; i++) { //right
	var j = width+i;
	points[j] = [points[j][0]+boings[j], points[j][1]];
}
for (var i = 0; i < width+1; i++) { //bottom
	var j = width+height+i;
	points[j] = [points[j][0], points[j][1]+boings[j]];
}
for (var i = 0; i < height+1; i++) { //left
	var j = (width*2+height+i)%len(boings);
	points[j] = [points[j][0]-boings[j], points[j][1]];
}
//===================================================================================


//point drawing ===========================================================================
//inside green
/*var triangles = triangulate(array_reverse(points));
for (var i = 0; i < len(triangles); i++) {
	draw_triangle_color(x+triangles[i][0][0], y+triangles[i][0][1], x+triangles[i][1][0], y+triangles[i][1][1], x+triangles[i][2][0], y+triangles[i][2][1], 
		#415D70, #415D70, #415D70, false);
}*/
for (var i = 0; i < len(points); i++) {
	draw_triangle_color(points[i][0]+x+oInfo.shakex, points[i][1]+y+oInfo.shakey, points[(i+1)%len(points)][0]+x+oInfo.shakex, points[(i+1)%len(points)][1]+y+oInfo.shakey, x+oInfo.shakex+width*thick/2, y+oInfo.shakey+height*thick/2,
		#415D70, #415D70, #415D70, false);
}
//lines
for (var i = 0; i < len(points); i++) {
	if !((boinglocked[i] == 2) && (boinglocked[(i+1)%len(points)] == 2)) { //checking it aint against other slime individualks
		draw_line_width_color(points[i][0]+x+oInfo.shakex, points[i][1]+y+oInfo.shakey, points[(i+1)%len(points)][0]+x+oInfo.shakex, points[(i+1)%len(points)][1]+y+oInfo.shakey,
			3, #1E3D51, #1E3D51);
	}
}

/*dots
if (irandom_range(0, 1)) {
	for (var i = 0; i < len(points); i++) {
		if (boinglocked[i] == 2) {
			draw_circle_color(points[i][0]+x, points[i][1]+y, 3,
				c_blue, c_blue, false);
		} else if (boinglocked[i] == 1) {
			draw_circle_color(points[i][0]+x, points[i][1]+y, 3,
				c_red, c_red, false);
		} else {
			draw_circle_color(points[i][0]+x, points[i][1]+y, 3,
				c_white, c_white, false);
		}
	}
}*/

/*id text
draw_set_font(Font3);
draw_set_color(#39B54A);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x+image_xscale*32, y+image_yscale*32, code);*/