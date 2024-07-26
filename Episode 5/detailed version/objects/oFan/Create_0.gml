col = bool(round(image_index%6/3)); //false == yellow, true == green
lifespan = 0;

colour_surface = -1;

size = image_xscale;

alarm[0] = 1;

check_rocks = function() {
	var colos = [];
	
	for (var i = 0; i < len(oInfo.rocks); i++) {
		if (oInfo.rocks[i].switch_colour == col) {
			array_push(colos, oInfo.rocks[i].colour_name);
		}
	}
	
	return colos;
}