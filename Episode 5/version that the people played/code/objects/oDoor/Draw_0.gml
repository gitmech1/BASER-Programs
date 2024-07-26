draw_self();
draw_sprite(sprite_index, 1, centerx-32, centery-32);

if (animation > 50) {
	draw_set_alpha(ease_in(min(1, (animation-50)/50)));
	draw_rectangle_color(x, y, x+image_xscale*64, y+image_yscale*64,
		c_white, c_white, c_white, c_white, false);
	draw_set_alpha(1);
}

if (animation >= 100) {
	draw_set_alpha(ease_out_cubic(1 - (animation-100)/30));
	draw_rectangle_color(oldx, oldy, oldx+image_xscale*64, oldy+image_yscale*64,
		c_white, c_white, c_white, c_white, false);
	draw_set_alpha(1);
}