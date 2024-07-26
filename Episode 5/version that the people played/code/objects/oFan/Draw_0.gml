if (state != col) { //off
	var subimg = col*3;
	draw_sprite_ext(sprite_index, subimg, x, y, image_xscale, image_yscale, image_angle, -1, 1);
} else {
	var subimg = col*3+1+(lifespan)%2;
	var xoffset = random_range(-1, 1);
	var yoffset = random_range(-1, 1);
	var width = 64*size;
	var a = image_angle;
	draw_sprite_ext(sprite_index, subimg, x+xoffset, y+yoffset, image_xscale, image_yscale, image_angle, -1, 1);
	draw_sprite_ext(sAir, lifespan%3, x+ldx(width, a)+ldx(width, a-90), y+ldy(width, a)+ldy(width, a-90), size, size, a-90, -1, 0.3);
}