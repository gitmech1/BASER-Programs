if (hit) {
	if (image_index == 0) {
		image_xscale = xscale + power(hit, 1.5)/10;
		image_yscale = yscale + power(hit, 1.5)/10;
	} else if !(die_time) {
		die_time = 30;
	}
	hit--;
} else {
	image_xscale = xscale;
	image_yscale = yscale;
}

if (moving) {
	x = 7.5 + sin(lifespan/70)*260;
}

if (die_time) {
	image_alpha = die_time/30;
	die_time--;
	if (die_time == 0) {
		array_find_and_kill(oInfo.obstacles, id);
		instance_destroy();
	}
} else {
	lifespan++;
}