if !(animation) {
	var xamount = (goalx - x)*0.04;
	var yamount = (goaly - y)*0.04;

	x += xamount;
	y += yamount;

	rot = xamount;
} else {
	x = lerp(x, door.centerx, 0.06);
	y = lerp(y, door.centery, 0.06);
	
	sinscale = max(0, 1 - animation/100);
	rot = lerp(rot, 0, 0.1);
	shake = 9*power(animation, 5)/power(10, 9.5);
	animation++;
	
	if (animation == 100) {
		instance_destroy();
	}
}

lifespan++;