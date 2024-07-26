if (special) {
	goalx = 3703;
	goaly = 1665;
} else if (tracking != noone) {
	goalx = tracking.x;
	goaly = tracking.y;
}

if (special) {
	x = lerp(x, goalx, 0.03);
	y = lerp(y, goaly, 0.03);
	zoom = lerp(zoom, 1, 0.03);
} else {
	x = lerp(x, goalx, 0.1);
	y = lerp(y, goaly, 0.1);
}

camera_set_view_pos(view_camera[0], x-power(2, zoom)*camWidth/2, y-power(2, zoom)*camHeight/2);
camera_set_view_size(view_camera[0], power(2, zoom)*camWidth, power(2, zoom)*camHeight);