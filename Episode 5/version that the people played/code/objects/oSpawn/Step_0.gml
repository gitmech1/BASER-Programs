image_angle += 2;

if (triggered) && (counter <= 1000) {
	image_xscale = 2-elastic_ease(counter/120);
	image_yscale = image_xscale;
	counter += 1;
} else {
	image_xscale = 1;
	image_yscale = 1;
}