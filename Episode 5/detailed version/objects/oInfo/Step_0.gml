if (room_delay) {
	completed = [];
	
	for (var i = 0; i < len(rocks); i++) {
		rocks[i].x = oRockStart.x;
		rocks[i].y = oRockStart.y;
		rocks[i].done = false;
		rocks[i].keys = [];
		rocks[i].switch_colour = false;
	}
	
	rooms++;
	lifespan = 0;
	shakex = 0;
	shakey = 0;
	update_objects();
	oWallBackground.find_cubes();
	
	room_delay = false;
}


if (countdown > 0) {
	countdown--;
	
	var scale = power((1-countdown/200), 2)*30;
	shakex = random_range(-scale, scale);
	shakey = random_range(-scale, scale);
	
	if (countdown == 0) {
		room_goto_next();
		room_delay = true;
	}
} else {
	shakex = 0;
	shakey = 0;
}


if (rooms <= 1) {
	if (len(completed) == len(remaining)) {
		next_room(1);
	}
} else {
	if (len(completed) == len(remaining)-1) {
		if (room == Room4) {
			next_room(300);
		} else {
			next_room(200);
		}
		
		if (room_delay) {
			new_list = []
			array_copy(new_list, 0, remaining, 0, len(remaining));
			for (var i = 0; i < len(completed); i++) {
				array_find_and_kill(new_list, completed[i]);
			}
			array_push(dead, new_list[0]);
			array_find_and_kill(remaining, new_list[0]);
		
			//find and kill correct rock
			for (var i = 0; i < len(rocks); i++) {
				if (rocks[i].colour_name == new_list[0]) {
					var guy = rocks[i]
					array_delete(rocks, i, 1);
					instance_destroy(guy);
					break;
				}	
			}
		}
	}
}


lifespan++;
total_lifespan++;