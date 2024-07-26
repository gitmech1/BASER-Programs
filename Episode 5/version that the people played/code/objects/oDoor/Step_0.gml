if (animation) {
	animation++;
	
	if (animation == 100) {
		oldx = x;
		oldy = y;
		x -= 9999;
		y -= 9999;
		centerx -= 9999;
		centery -= 9999;
	}
	
	if (animation == 130) {
		instance_destroy();
	}
}