image_angle = 135 + 100*(1 - power(1 - clamp((lifespan-50)/90, 0, 1), 3)) * (1 - power(1 - clamp((-lifespan+270)/50, 0, 1), 3));

if (lifespan == 169) {
	extra_layer = true;
} else if (lifespan == 170) {
	with instance_create_layer(x+lengthdir_x(335, image_angle), y+lengthdir_y(335, image_angle), "Rocks", oPlayer2) {
		xvel = cos(degtorad(other.image_angle))*50;
		yvel = -sin(degtorad(other.image_angle))*50;
	}
} else if (lifespan == 180) {
	extra_layer = false;
}

lifespan++;