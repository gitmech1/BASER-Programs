//zoom += (keyboard_check(vk_down) - keyboard_check(vk_up)) / 20;
//x += (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * 15*power(2, zoom);
//y += (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * 15*power(2, zoom);

if (between(lifespan, 6408, 18380)) {
	var cool = lifespan-6408;
	zoom_addon = -ease_in_out(ease_in(cool/11972))*0.3;
}

/*if (lifespan == 17800) {
	oInfo.screenshot_mode = true;
}*/

if (lifespan > 18080) {
	var cool = lifespan-18080;
	desired_y = 1050 - 250 * ease_in_out(map_value(cool, 20, 295, 0, 1)) * map_value(ease_in_out(map_value(cool, 550, 800, 1, 0)), 1, 0, 1, 0.4);
	desired_zoom = 0.75 - (0.7 + 0.0 * (cool >= 300)) * ease_in_out(map_value(cool, 20, 295, 0, 1)) * ease_in_out(map_value(cool, 550, 780, 1, 0));
	/*if (cool == 300) {
		zoom += zoom_addon;
		desired_zoom += zoom_addon;
		zoom_addon = 0;
	}*/
}

x = lerp(x, desired_x, 0.08);
y = lerp(y, desired_y, 0.08);
zoom = lerp(zoom, desired_zoom, 0.08);

cx1 = x-power(2, zoom+zoom_addon)*camWidth/2;
cy1 = y-power(2, zoom+zoom_addon)*camHeight/2;
cx2 = x+power(2, zoom+zoom_addon)*camWidth/2;
cy2 = y+power(2, zoom+zoom_addon)*camHeight/2;

camera_set_view_pos(view_camera[0], cx1, cy1);
camera_set_view_size(view_camera[0], cx2-cx1, cy2-cy1);

lifespan++;