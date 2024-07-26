if (tracking != noone) {
	goalx = tracking.x;
	goaly = tracking.y;
}
x = lerp(x, goalx, 0.1);
y = lerp(y, goaly, 0.1);

camera_set_view_pos(view_camera[0], x-power(2, zoom)*camWidth/2, y-power(2, zoom)*camHeight/2);
camera_set_view_size(view_camera[0], power(2, zoom)*camWidth, power(2, zoom)*camHeight);