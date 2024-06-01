gr = (1+sqrt(5))/2; //golden ratio

font1 = font_add("Heading.ttf", 80, false, false, 32, 127);
font2 = font_add("ArchivoBlack.ttf", 40, false, false, 32, 127);
font3 = font_add("Bronz.ttf", 100, false, false, 32, 127);

random_set_seed(148);

positions = ["1st", "2nd", "3rd", "4th", "5th", "6th"];
colours = [
	//name, main col, sec col, wanted_pos, pos, reached checkpoint, death counter, camera on
	["orange", #FD9B30, #774012, 0, 0, false, -1, 0, 0],
	["lime", #4CF664, #23792E, 1, 1, false, -1, 2, 0],
	["green", #277E46, #10331B, 2, 2, false, -1, 2, 0],
	["blue", #32C2F7, #186096, 3, 3, false, -1, 0, 0],
	["purple", #BB5CF8, #552B7B, 4, 4, false, -1, 1, 0],
	["magenta", #F92AF0, #4B132F, 5, 5, false, -1, 1, 0]
];
point_list = [
	-13625, //0
	-6810, //1
	0, //2
	40625, //3
	63125, //4
	84700, //5
	99999 //non existant one
];
collisions = [
	//bottom
	[-285, -13625, 285, -13700], //bottom part
	[-360, 40625, -285, -13625],
	[285, 40625, 360, -13625],
	//cloud left
	[-1360, 64750, -285, 63125], //bottom left
	[-3050, 64825, -285, 64750], //bottom of left chamber
	[-3125, 64825, -1050, 67670], //left of left chamber
	[-3050, 67745, 340, 67670], //top of left chamber
	[-1340, 67670, 415, 68500], //right of that side
	[-1345, 68500, 340, 68425],
	//cloud right
	[3360, 65600, 285, 63125],
	[-530, 65675, 3285, 65600],
	[-530, 65675, 3455, 66650], //stu
	[-455, 66650, 3090, 66575], //ff
	[1015, 66650, 3090, 69350],
	[360, 69350, 3090, 69425],
	//top
	[-345, 84700, -270, 68500], //top channel
	[360, 84700, 285, 69350]
	//very top barrier
	//[-2000, 84775, 2000, 84700]
];
boosters = [];
obstacles = [];
chat_log = []; //constatly clearing log of messages
chat_log_height = 0; //constantly lerping to length of chat box

grv = 0.37; //global gravity
lifespan = 0;
checkpoint_reached = 0;
camera_on = -1;
sucking = 0;

win_text = ""
win_in = 0;
win_col = c_black;
win_col2 = c_black;

//creating rocks
for (var i = 0; i < len(colours); i++) {
	with (instance_create_layer(0, 100, "rocks", oRock)) {
		x = -250+i*100;
		y = -13500;
		xvel = random_range(-5, 5);
		yvel = 25 + other.colours[i][7]*10;
		arrow_size_max = other.colours[i][7]+1;
		rock_colour = other.colours[i][1];
		rock_reference = i;
		array_insert(other.colours[i], 6, id);
	}
}

//curating boosters
//first tunnel
for (var i = 0; i < 107; i++) {
	with (instance_create_layer(random_range(-220, 220), -13000 + 500*i, "boosters", oBoosta)) {
		lifespan = random_range(0, 9999);
		moving = bool(random_range(0, 1));
		normal = bool(random_range(0, 10));
		if (moving) {
			moving_radius = 220;
		}
		if (normal) {
			r = random_range(75, 105);
		} else {
			r = random_range(-75, -105);
		}
		array_push(other.boosters, [id, 3]);
	}
}
//shmove left chloud area
with (instance_create_layer(0, 65200, "boosters", oBoosta)) {
	lifespan = random_range(0, 9999);
	moving = 0;
	normal = 1;
	r = 180;
	image_xscale = 2.5;
	image_yscale = 4;
	array_push(other.boosters, [id, 0.5]);
}
//left cloud area
with (instance_create_layer(-790, 65800, "boosters", oBoosta)) {
	lifespan = random_range(0, 9999);
	moving = 0;
	normal = 1;
	r = 90;
	image_xscale = 10;
	image_yscale = 4;
	array_push(other.boosters, [id, 1]);
}
//shmove right chloud area
with (instance_create_layer(-790, 67000, "boosters", oBoosta)) {
	lifespan = random_range(0, 9999);
	moving = 0;
	normal = 1;
	r = 0;
	image_xscale = 2.5;
	image_yscale = 4;
	array_push(other.boosters, [id, 0.5]);
}
//right cloud area
with (instance_create_layer(735, 67600, "boosters", oBoosta)) {
	lifespan = random_range(0, 9999);
	moving = 0;
	normal = 1;
	r = 90;
	image_xscale = 10;
	image_yscale = 4;
	array_push(other.boosters, [id, 1]);
}
//shmove left again chloud area
with (instance_create_layer(735, 68800, "boosters", oBoosta)) {
	lifespan = random_range(0, 9999);
	moving = 0;
	normal = 1;
	r = 180;
	image_xscale = 2.5;
	image_yscale = 4;
	array_push(other.boosters, [id, 0.5]);
}
//TOP cloud area
with (instance_create_layer(0, 69000, "boosters", oBoosta)) {
	lifespan = random_range(0, 9999);
	moving = 0;
	normal = 1;
	r = 90;
	image_xscale = 5;
	image_yscale = 4;
	array_push(other.boosters, [id, 1]);
}



//creating cloud obstacles
for (var i = 0; i < 60; i++) {
	var xx = -10000 + 20000*((i*gr)%1);
	var yy = 41000 + i*400;
	with (instance_create_layer(xx, yy, "obstacles", oObstacle)) {
		image_index = 0;
		xscale = random_range(0.4, 0.6);
		yscale = random_range(0.6, 0.8);
		image_xscale = xscale;
		image_yscale = yscale;
		array_push(other.obstacles, id);
	}
}

//creating metal obstacles
for (var i = 0; i < 21; i++) {
	var yy = 71700 + 200*i + power(i, 3);
	with (instance_create_layer(0, yy, "obstacles", oObstacle)) {
		image_index = 1;
		moving = true;
		lifespan = round(yy/10);
		xscale = 0.4;
		yscale = 0.4;
		image_xscale = xscale;
		image_yscale = yscale;
		array_push(other.obstacles, id);
	}
}




//make new checkpoint tunnel
checkpoint_booster = function(checkpoint) {
	for (var i = 0; i < 19; i++) {
		with (instance_create_layer(-480 + i*60, point_list[checkpoint]-410, "boosters", oBoosta)) {
			lifespan = random_range(0, 9999);
			moving = false;
			normal = true;
			r = 90;
			image_xscale = 5;
			image_alpha = 0;
			array_push(other.boosters, [id, 30]);
		}
	}
}

checkpoint_booster(0);