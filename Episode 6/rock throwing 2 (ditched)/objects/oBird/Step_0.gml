if (hit) {
	y = ystart + 0.3*power(hit_after, 2)-8*hit_after;
	x = xstart + -7*hit_after;
	if (hit_after > 200) {
		instance_destroy();
	}
	hit_after++;
}