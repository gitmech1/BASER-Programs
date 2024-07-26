code = -1;

image_speed = 0;
image_index = 0;

centerx = x+image_xscale*32;
centery = y+image_yscale*32;

colour_surface = -1;

c = [
	{
		colour_name: "orange",
		fade: 0,
		dir: 0,
		collided: false,
		alive: true
	},
	{
		colour_name: "lime",
		fade: 0,
		dir: 0,
		collided: false,
		alive: true
	},
	{
		colour_name: "green",
		fade: 0,
		dir: 0,
		collided: false,
		alive: true
	},
	{
		colour_name: "blue",
		fade: 0,
		dir: 0,
		collided: false,
		alive: true
	},
	{
		colour_name: "magenta",
		fade: 0,
		dir: 0,
		collided: false,
		alive: true
	}
];

var names = ["orange", "lime", "green", "blue", "magenta"];
for (var i = 0; i < 5; i++) {
	if !(array_contains(oInfo.remaining, names[i])) {
		c[i].alive = false;
	}
}

rocks_alive = function() {
	var alive_rocks = [];
	for (var i = 0; i < len(c); i++) {
		if (c[i].alive) {
			array_push(alive_rocks, c[i].colour_name);
		}
	}
	return alive_rocks;
}