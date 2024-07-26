/*if (animation) {
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
}*/

var death_check = true;
for (var i = 0; i < len(c); i++) { //loop thru every rock
	
	c[i].fade += c[i].dir;

	if (c[i].fade >= 100) {
		c[i].alive = false;
	
		c[i].dir = -3;
	}

	if (c[i].fade > 0) {
		death_check = false;
	}
}

if (death_check) {
	if !(len(rocks_alive())) {
		instance_destroy();
	}
}