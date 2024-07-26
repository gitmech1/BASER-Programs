var new_rocks = [];
var names = ["orange", "lime", "green", "blue", "magenta"];

for (var i = 5; i > 0; i--) {
	for (var j = 0; j < 5; j++) {
		if (rocks[j].colour_name == names[5-i]) {
			array_push(new_rocks, rocks[j]);
		}
	}
}

rocks = new_rocks;

oWallBackground.find_cubes();