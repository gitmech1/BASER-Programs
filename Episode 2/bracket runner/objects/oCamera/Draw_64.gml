draw_set_alpha((cooldown-lifespan)/cooldown);
if (start) {
	draw_rectangle_color(0, 0, 2560, 1440, c_white, c_white, c_white, c_white, false);
	
	var ls = lifespan+120;
	draw_set_font(font);
	if (ls < 20) {
		var scale = 1000000*(power(0.5, ls));
		draw_text_transformed_color(1280, 400+ls*20, "LETS BEGIN", scale, scale, 0, #AAAAAA, #AAAAAA, #AAAAAA, #AAAAAA, 1);
	} else {
		draw_text_transformed_color(1280, 720, "LETS BEGIN", 1-max(0, (ls*15-1800))/1200, 1-max(0, (ls*15-1800))/1200, 0, #AAAAAA, #AAAAAA, #AAAAAA, #AAAAAA, 1-max(0, (ls*15-1800))/500);
	}
	draw_set_font(font2);
} else {
	draw_rectangle_color(0, 0, 2560, 1440, c_black, c_black, c_black, c_black, false);
}
draw_set_alpha((lifespan-time-cooldown)/cooldown);
draw_rectangle_color(0, 0, 2560, 1440, c_white, c_white, c_white, c_white, false);
draw_set_alpha(1);