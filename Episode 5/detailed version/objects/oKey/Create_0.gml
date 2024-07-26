animation = 0;
door = noone;
goalx = xstart;
goaly = ystart;
rot = 0;
sinscale = 1;
shake = 0;
lifespan = irandom_range(0, 9999);

colour_surface = -1;

colours_free = array_clone(oInfo.remaining);

grab = function(colour_name) {
	array_find_and_kill(colours_free, colour_name);
}