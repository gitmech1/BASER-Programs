//transition
if (countdown != 0) || (room_delay) {
	draw_set_alpha(ease_in_out(1 - min(max_countdown, countdown)/max_countdown, 2));
	draw_rectangle_color(0, 0, 2560, 1440, #05121C, #05121C, #05121C, #05121C, false);
	draw_set_alpha(1);
}

/*debug
draw_text(30, 30, remaining);
draw_text(30, 60, completed);
draw_text(30, 90, dead);
draw_text(30, 120, string(lifespan) + "  =  " + frames_to_time(lifespan));
draw_text(30, 150, countdown);
draw_text(30, 180, fps);*/