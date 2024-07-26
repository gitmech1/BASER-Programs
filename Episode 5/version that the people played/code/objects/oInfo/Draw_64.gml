if (in) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_font(Font2);
	var scale = ease_out(min(50, 300-in)/50) * ease_in(min(50, in)/50);
	draw_border_text(1280, (160*rooms+30)*scale, tex, -1, 999999, 1, 1, 4, 0, #EE1C24, #9E0B0F, 1, true);
	
	in--;
}