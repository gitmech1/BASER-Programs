xxx = 1280+lengthdir_x(400, lifespan/1.1);
yyy = 720+lengthdir_y(400, lifespan/1.1);

j_list = [];
i_list = [];
array_push(j_list, floor(xxx/160));
array_push(i_list, floor(yyy/160));
for (var i = 1; i < 16; i++) {
	if (floor(xxx/160)+i <= 15) {
		array_push(j_list, floor(xxx/160)+i);
	}
	if (floor(xxx/160)-i >= 0) {
		array_push(j_list, floor(xxx/160)-i);
	}
	if (floor(yyy/160)+i <= 8) {
		array_push(i_list, floor(yyy/160)+i);
	}
	if (floor(yyy/160)-i >= 0) {
		array_push(i_list, floor(yyy/160)-i);
	}
}
msg(j_list);

for (var k = 0; k < 9; k++) {
	var i = i_list[8-k];
	for (var l = 0; l < 16; l++) {
		var j = j_list[15-l];
		var distanc = sqrt(sqr(j*160+80-xxx) + sqr(i*160+80-yyy)) * (cos(degtorad(lifespan/2)));
		var angl = point_direction(j*160+80, i*160+80, xxx, yyy)+180;
		var xx = lengthdir_x(distanc, angl);
		var yy = lengthdir_y(distanc, angl);
		if (yy > -80) {
			draw_triangle_color(j*160, i*160, (j+1)*160, i*160,  j*160+80+xx, i*160+80+yy, #35126a, #35126a, #35126a, false); //top
		}
		if (xx > -80) {
			draw_triangle_color(j*160, i*160, j*160, (i+1)*160,  j*160+80+xx, i*160+80+yy, #4a1b6b, #4a1b6b, #4a1b6b, false); //left
		}
		if (yy < 80) {
			draw_triangle_color(j*160, (i+1)*160, (j+1)*160, (i+1)*160,  j*160+80+xx, i*160+80+yy, #b71d6a, #b71d6a, #b71d6a, false); //bottom
		}
		if (xx < 80) {
			draw_triangle_color((j+1)*160, (i+1)*160, (j+1)*160, i*160,  j*160+80+xx, i*160+80+yy, #ca1869, #ca1869, #ca1869, false); //right
		}
		
		
		/*draw_set_colour(make_colour_hsv(0, 255, count*1.4));
		draw_rectangle(j*160, i*160, (j+1)*160, (i+1)*160, false);
		draw_set_colour(c_white);
		draw_text(j*160+80, i*160+80, count);
		count++;*/
	}
}

lifespan++;