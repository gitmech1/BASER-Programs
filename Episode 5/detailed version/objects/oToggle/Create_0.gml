col = bool(image_index%2); //false == yellow, true == green

colour_surface = -1;

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