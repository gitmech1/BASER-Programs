y = ystart;

if (height_diff) {
	var amount = 2; //per square
	for (var i = 0; i <= height_diff*2; i++) {
		draw_surface_ext(surface, x+summoner.shake_x, y+summoner.shake_y, 1, 1, 0, -1, i/height_diff/2*fade);
		y += oInfo.square_size/amount;
	}
}

if (lifespan%2) {
	if (fade <= 0) {
		surface_free(surface);
		instance_destroy();
	} else {
		fade -= 0.4;
	}
}

lifespan++;