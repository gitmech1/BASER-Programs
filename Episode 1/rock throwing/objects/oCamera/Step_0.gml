if (follow != noone) {
	xTo = follow.x;
	yTo = follow.y;
}

x = lerp(x, xTo, 0.1);
y = lerp(y, yTo, 0.1);

camera_set_view_pos(view_camera[0], x-(camWidth*0.5), y-(camHeight*0.5));


oSun.x = clamp(x, 1366/2, 20000-1366/2)-430;
oSun.y = clamp(y, 768/2, 2000-768/2)-250;