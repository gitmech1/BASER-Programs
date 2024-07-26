draw_keys();

draw_sprite_ext(sprite_index, image_index, x+oInfo.shakex, y+oInfo.shakey, image_xscale, image_yscale, rot+rot_shift, colour, 1);

/*if !(switch_colour) {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, rot+rot_shift, c_yellow, 1);
} else {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, rot+rot_shift, c_lime, 1);
}*/