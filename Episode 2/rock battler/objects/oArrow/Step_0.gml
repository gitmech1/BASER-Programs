if (lifespan > 10) {
	image_alpha -= 0.05;
}

if (image_alpha <= 0) {
	instance_destroy();
}

lifespan++;