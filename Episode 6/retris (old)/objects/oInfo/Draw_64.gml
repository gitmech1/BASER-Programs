if (time_since_end_end > 200) {
	draw_set_alpha((time_since_end_end-200)/40);
	draw_rectangle_color_simple(0, 0, 2560, 1440, c_black);
	draw_set_alpha(1);
	
	draw_set_alpha(clamp((time_since_end_end-300)/20, 0, 1) * clamp((550-time_since_end_end)/20, 0, 1));
	draw_sprite(sMessage, 0, room_width/2, room_height/2);
	draw_set_alpha(1);
}