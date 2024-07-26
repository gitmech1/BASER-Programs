state = false; //false == yellow, true == green
children = []; //all toggle blocks linked to this guy

lifespan = 1;
pressed = 0;


update_state = function(rock) {
	pressed = 8;
	if (rock == "all") {
		//update rocks
		for (var i = 0; i < len(oInfo.rocks); i++) {
			oInfo.rocks[i].switch_colour = !oInfo.rocks[i].switch_colour;
		}
	} else {
		rock.switch_colour = !rock.switch_colour;
	}
}