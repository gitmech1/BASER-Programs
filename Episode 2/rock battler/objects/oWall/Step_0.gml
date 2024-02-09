x = 1280 - image_xscale*1290 - sin(degtorad(lifespan*2*image_xscale))*10;
y += (1440/(loopspan/(oInfo.spd*2-1))) * -(cos(pi*clamp(lifespan-30, 0, 180)/180)-1)/2;

if (image_xscale == 1) { //oon da left side
	if (y > 0) {
		y -= 1440;
	}
} else { //ooooooon da right side
	if (y > 2880) {
		y -= 1440;
	}
}

lifespan++;
if !(oInfo.fighting) {
	counter++;
}