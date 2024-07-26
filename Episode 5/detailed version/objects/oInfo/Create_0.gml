automatic = true;

grv = 0.4;
lifespan = 0;
total_lifespan = 0;
player_name = "";
rooms = 0;
room_delay = false;
max_countdown = 0;
countdown = 0;

shakex = 0; //amount room shakes
shakey = 0;

// red: #E73133, #431C1E
// shrimp: #F9806B, #7B3E33
// orange: #FD9B30, #774012
// tan: #EFE4B9, #6B6552
// lime: #4CF664, #23792E
// green: #277E46, #10331B
// blue: #32C2F7, #186096
// purple: #BB5CF8, #552B7B
// magenta: #F92AF0, #4B132F
colours = {
	orange: [ #FD9B30, #774012],
	lime: [ #4CF664, #23792E],
	green: [ #277E46, #10331B],
	blue: [ #32C2F7, #186096],
	magenta: [ #F92AF0, #4B132F]
}

colour_order = [ //maps to the sColour sprite based off index
	["orange", "lime", "green", "blue", "magenta"],
	["lime", "green", "blue", "magenta"],
	["orange", "green", "blue", "magenta"],
	["orange", "lime", "blue", "magenta"],
	["orange", "lime", "green", "magenta"],
	["orange", "lime", "green", "blue"],
	["lime", "green", "blue"],
	["lime", "green", "magenta"],
	["lime", "blue", "magenta"],
	["green", "blue", "magenta"],
	["orange", "green", "blue"],
	["orange", "green", "magenta"],
	["orange", "blue", "magenta"],
	["orange", "lime", "blue"],
	["orange", "lime", "magenta"],
	["orange", "lime", "green"],
	["orange", "magenta"],
	["orange", "blue"],
	["orange", "green"],
	["orange", "lime"],
	["lime", "magenta"],
	["lime", "blue"],
	["lime", "green"],
	["green", "magenta"],
	["green", "blue"],
	["blue", "magenta"],
	["orange"],
	["lime"],
	["green"],
	["blue"],
	["magenta"]
]

rocks = [];
completed = [];
remaining = ["orange", "lime", "green", "blue", "magenta"];
dead = [];

objects = {}; //holds all the keys for number to inst of door and slimel


function update_objects() {
	//slime
	for (var i = 0; i < instance_number(oSlime); i++) {
		var guy = instance_find(oSlime, i);
		objects[guy.code] = guy.id;
	}
	
	//doors
	for (var i = 0; i < instance_number(oDoor); i++) {
		var guy = instance_find(oDoor, i);
		objects[guy.code] = guy.id;
	}
}


function next_room(countdown_time) {
	if (countdown == 0) && !(room_delay) {
		max_countdown = countdown_time;
		countdown = countdown_time;
	}
}


alarm[0] = 1;