var xshift = random_range(-shake, shake);
var yshift = random_range(-shake, shake);

if (animation < 100) { //normal colour key
	draw_sprite_ext(sprite_index, 0,
		x+xshift, y+yshift+dsin(lifespan*2)*15*sinscale,
		image_xscale, image_yscale, rotation, -1, 1);
}
	
if (animation > 50) { //white key
	draw_sprite_ext(sprite_index, 1,
		x+xshift, y+yshift+dsin(lifespan*2)*15*sinscale,
		image_xscale, image_yscale, rotation, -1, ease_out_cubic(min(1, (animation-50)/50)));
}