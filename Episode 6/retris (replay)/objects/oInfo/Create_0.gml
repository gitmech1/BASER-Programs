good_mode = false;
screenshot_mode = false;
game_mode = "replay"; //play, record, replay
replay_date = "24/12/2024 10:45:32 PM"; //only for replay ->->->-> IMPORTANT <-<-<-<-

get_save(true);

if (game_mode == "replay") {
	game_data = pull(replay_date);
	//==============================
	seed = game_data[0][0];
	player_amount = game_data[0][1];
	names = game_data[0][2];
	scorings = game_data[0][3];
} else {
	player_amount = oCharacterChoosing.players_connected;
}


if (game_mode == "replay") {
	random_set_seed(seed);
} else {
	randomize();
	seed = random_get_seed();
}


draw_set_font(Font);
youngster = font_add("Youngster.ttf", 40, false, false, 32, 127);


global_pause = false; //either false or id of play that is immune
lifespan = 0;

grid_w = 10;
grid_h = 28;
square_size = 40;
border_size = 10;
paddings = [0, 680, 400, 180, -150];

w = grid_w*square_size;
h = grid_h*square_size;

w_extra = 500;
h_extra = 500;

joystick_spot = 0.3; //point where movement is registered

time_before_drop = 60;
speed_up_time = false;

players = []; //ids of all of them
players_colour = [noone, noone, noone, noone, noone]; //ids but ordered red, shrimp, tan, purple, magenta

placements = []; //goes from first to fifth
scorings = [];
// PROPERLY SET UP IN STEP
reals = []; //the actual numbers to be dispayed when maxed
times_limit = []; //total time for each number to display
times_thus = []; //time passed thus far

time_since_end = 0;
time_since_end_end = 0;
time_for_score_max = 160; //dont act dumb you know what this is for

chosen_guy = [-1, -1]; //colour_id, controls


function check_paused(player_id) {
	if (global_pause == false) {
		return false;
	}
	if (global_pause == player_id) {
		return false;
	} else {
		return true;
	}
}


//obsolete
function generate_border(surface) {
	surface_set_target(surface);
	
	//inner grid
	for (var yy = 0; yy < grid_h+1; yy++) { //horizontal lines
		draw_line_width_color(border_size, square_size*yy, w+border_size, square_size*yy, 3, c_grey, c_grey);
	}
	for (var xx = 0; xx < grid_w+1; xx++) { //vertical lines
		draw_line_width_color(border_size+square_size*xx, 0, border_size+square_size*xx, h, 3, c_grey, c_grey);
	}
	
	//outer shell
	draw_rectangle_color_simple(0, 0, oInfo.border_size, oInfo.h+oInfo.border_size, c_white, false); //left thing
	draw_rectangle_color_simple(oInfo.w + oInfo.border_size, 0, oInfo.w + oInfo.border_size*2, oInfo.h+oInfo.border_size, c_white, false); //right thing
	draw_rectangle_color_simple(0, oInfo.h, oInfo.w+oInfo.border_size*2, oInfo.h+oInfo.border_size, c_white, false); //bottom thing
	
	surface_reset_target();
}


colours = [
	[ #BB5CF8, #552B7B], //purple
	[ #EFE4B9, #6B6552], //tan
	[ #F92AF0, #4B132F], //magenta
	[ #E73133, #431C1E], //red
	[ #F9806B, #7B3E33], //shrimp
	//[ #FD9B30, #774012], //orange
	//[ #4CF664, #23792E], //lime
	//[ #277E46, #10331B], //green
	//[ #32C2F7, #186096], //blue
	[ #F0B642, #5A2B11, #E589FE, #3513FE]  //shlurkle (orange then grape)
];
colour_names = ["red", "shrimp", "tan", "purple", "magenta"];
colour_conversion = [3, 2, 4, 0, 1]; //ids to replaced ids

powerup_colours = [ #EE2F36, #32FF32, #3539B2]; //r,g,b (never changed)
powerup_pause = false; //changed back by player
volume_pause = 1;

check_directions = [ //goes [distance, height]
	[[1, 0]], //left wall, 1 to right
	[[-1, 0], [-2, 0]], //right wall, 1, 2 to left
	[[0, 1], [0, 2]], //floor, 1, 2 up
	[[0, -1]], //roof, 1 down
	[[0, 1], [-1, 0], [1, 0]] //guy, 1 up, 1 left, 1 right
]; //all directions that a rotated piece should have lenience towards

explosions = [normalexplosion1, normalexplosion2, normalexplosion3];
punches = [meatypunch4, meatypunch5, meatypunch6, meatypunch7, meatypunch8, meatypunch9];
shards = [slam_red, slam_shrimp, slam_tan, slam_purple, slam_magenta];
applauses = [applause_01, applause_02, applause_03, applause_04, applause_05, applause_06, applause_07, applause_08, applause_09, applause_10, applause_11, applause_12];
swings = [swinger1, swinger2, swinger3, swinger4, swinger5, swinger6];

timings = [
	[[3], [1072, 1388]],
	[[3], [1844, 2142]],
	[[3], [2672, 2848]],
	[[2], [3028, 3386]],
	[[3], [4094, 4412]],
	[[0], [4583, 4700]],
	[[3], [4806, 4987]],
	[[0], [5022, 5297]],
	[[2], [5650, 5874]],
	[[1], [6408, 6650]],
	[[1], [6763, 6912]],
	[[0], [7002, 7230]],
	[[3], [7385, 7630]],
	[[3], [7831, 8183]],
	[[3], [8532, 9182]],
	[[2], [9525, 9720]],
	[[0, 2], [10585, 10873]],
	[[2], [10972, 11162]],
	[[1], [11352, 11546]],
	[[1], [13179, 13277]],
	[[0, 2], [13277, 13471]],
	[[2], [14424, 14623]],
	[[2], [15188, 15962]],
	[[4, 1], [17316, 17638]],
	[[4], [17678, 17891]],
	[[0, 1], [17891, 18058]]
	//[[1], [18192, 18375]]
];

function refresh() {
	pieces = [
		//LINE PIECE (light blue) =============================
		[[ //shape
			[[0, 1, 0, 0], [0, 0, 0, 0], [0, 4, 0, 0], [0, 0, 0, 0]],
			[[0, 2, 0, 0], [4, 3, 2, 1], [0, 3, 0, 0], [1, 2, 3, 4]],
			[[0, 3, 0, 0], [0, 0, 0, 0], [0, 2, 0, 0], [0, 0, 0, 0]],
			[[0, 4, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 1], [0, 4], [1, 1], [0, 4]],  [[0, 4], [1, 1], [0, 4], [1, 1]]],
	
		//SQUARE PIECE (yellow) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 1, 2, 0], [0, 4, 1, 0], [0, 3, 4, 0], [0, 2, 3, 0]],
			[[0, 4, 3, 0], [0, 3, 2, 0], [0, 2, 1, 0], [0, 1, 4, 0]],
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 2], [1, 2], [1, 2], [1, 2]],  [[1, 2], [1, 2], [1, 2], [1, 2]]],
	
		//J PIECE (blue) =============================
		[[ //shape
			[[0, 0, 4, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 0, 3, 0], [0, 1, 0, 0], [0, 2, 1, 0], [4, 3, 2, 0]],
			[[0, 1, 2, 0], [0, 2, 3, 4], [0, 3, 0, 0], [0, 0, 1, 0]],
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 4, 0, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 2], [1, 3], [1, 2], [0, 3]],  [[0, 3], [1, 2], [1, 3], [1, 2]]],
	
		//L PIECE (orange) =============================
		[[ //shape
			[[0, 4, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 3, 0, 0], [0, 2, 3, 4], [0, 1, 2, 0], [0, 0, 1, 0]],
			[[0, 2, 1, 0], [0, 1, 0, 0], [0, 0, 3, 0], [4, 3, 2, 0]],
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 4, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 2], [1, 3], [1, 2], [0, 3]],  [[0, 3], [1, 2], [1, 3], [1, 2]]],
	
		//S PIECE (lime) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 0, 3, 4], [0, 1, 0, 0], [0, 0, 2, 1], [0, 4, 0, 0]],
			[[0, 1, 2, 0], [0, 2, 3, 0], [0, 4, 3, 0], [0, 3, 2, 0]],
			[[0, 0, 0, 0], [0, 0, 4, 0], [0, 0, 0, 0], [0, 0, 1, 0]]
		//colours, piece surface
		], [[1, 3], [1, 2], [1, 3], [1, 2]],  [[1, 2], [1, 3], [1, 2], [1, 3]]],
	
		//Z PIECE (red) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[1, 2, 0, 0], [0, 0, 1, 0], [4, 3, 0, 0], [0, 0, 4, 0]],
			[[0, 3, 4, 0], [0, 3, 2, 0], [0, 2, 1, 0], [0, 2, 3, 0]],
			[[0, 0, 0, 0], [0, 4, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0]]
		//colours, piece surface
		], [[0, 3], [1, 2], [0, 3], [1, 2]],  [[1, 2], [0, 3], [1, 2], [0, 3]]],
	
		//T PIECE (purple, pink?) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 1, 0, 0], [0, 2, 0, 0], [0, 0, 0, 0], [0, 4, 0, 0]],
			[[2, 3, 4, 0], [0, 3, 1, 0], [4, 3, 2, 0], [1, 3, 0, 0]],
			[[0, 0, 0, 0], [0, 4, 0, 0], [0, 1, 0, 0], [0, 2, 0, 0]]
		//colours, piece surface
		], [[0, 3], [1, 2], [0, 3], [0, 2]],  [[0, 2], [0, 3], [1, 2], [0, 3]]],
	];
}
refresh();


function generate_random_pieces() {
	var tha_pieces = [];
	var pieces_since = array_create(7, 1); //count of the amount of time since piece was placed last
	
	for (var i = 0; i < 1000; i++) {
		var choice = weighted_random(pieces_since);
		array_push(tha_pieces, choice);
		//moving each up by 1 or to 0
		for (var j = 0; j < 7; j++) {
			if (j == choice) {
				pieces_since[j] = 1;
			} else {
				pieces_since[j] *= 1.3;
			}
		}
	}
	
	return tha_pieces;
}

function generate_random_rotations() {
	var the_list = [];
	for (var i = 0; i < 1000; i++) {
		array_push(the_list, irandom_range(0, 3));
	}
	return the_list;
}

function generate_random_columns() {
	var the_list = [];
	for (var i = 0; i < 1000; i++) {
		array_push(the_list, irandom_range(0, grid_w-1));
	}
	return the_list;
}

function generate_random_powerup_types() { //r, g, b
	var the_list = [];
	for (var i = 0; i < 1000; i++) {
		array_push(the_list, irandom_range(0, 2)/*irandom_range(0, 2)*/);
	}
	return the_list;
}

function generate_random_powerup_spots() { //spot on piece
	var the_list = [];
	for (var i = 0; i < 1000; i++) {
		array_push(the_list, irandom_range(1, 4));
	}
	return the_list;
}

function generate_random_powerup_timings() { //how long between pieces	
	var the_list = [];
	for (var i = 0; i < 1000; i++) {
		//array_push(the_list, irandom_range(6*60, 10*60)); //in frames
		array_push(the_list, irandom_range((13-player_amount)*60, (25-player_amount*2)*60)); ////////////////////////////////////////////////////////////////
	}
	return the_list;
}

function generate_random_powerup_players() { //player that gets the powerup
	var the_list = [];
	for (var i = 0; i < 1000; i++) {
		array_push(the_list, irandom_range(0, 59)); //60 is divisible by 1, 2, 3, 4, 5
	}
	return the_list;
}

function generate_random_green_victims() { //player that recieves each green piece
	var the_list = [];
	for (var i = 0; i < 1000; i++) {
		array_push(the_list, irandom_range(0, 11)); //12 is divisible by 1, 2, 3, 4
	}
	return the_list;
}


height_drop_map = [[0, 1, 0, 1], [1, 1, 1, 1], [0, 1, 1, 1], [0, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 2, 1]];


random_pieces = generate_random_pieces(); //list of all pieces
random_rotations = generate_random_rotations(); //list of all piece rotations when generated
random_columns = generate_random_columns(); //for each x value
column_step = 0;

random_p = generate_random_powerup_types(); //what powerups are used
random_p_spots = generate_random_powerup_spots(); //where powerup is on piece
random_p_timings = generate_random_powerup_timings(); //when the powerups are triggered
random_p_players = generate_random_powerup_players(); //who its sent to
p_count = random_p_timings[0];
p_step = 0;

random_g_victims = generate_random_green_victims();
victim_step = 0;


//background border
//border = surface_create(oInfo.w+oInfo.border_size*2, oInfo.h+oInfo.border_size);
//generate_border(border);


function return_position(player_count) {
	var padding = paddings[player_count-1];
	var all_of_em = [];
	for (var i = 0; i < player_count; i++) {
		if (player_count > 1) {
			var difference = (2560-2*padding - player_count*w)/(player_count-1);
			array_push(all_of_em, padding + (w+difference)*i + w/2 + 250);
		} else {
			array_push(all_of_em, (room_width-w)/2 + w/2);
		}
	}
	return all_of_em;
}

function return_alive_players(colour_sorted=false) {
	var alive_list = [];
	if (colour_sorted) {
		for (var i = 0; i < len(players_colour); i++) {
			if (players_colour[i].dead <= 0) {
				array_push(alive_list, players_colour[i]);
			}
		}
	} else {
		for (var i = 0; i < len(players); i++) {
			if (players[i].dead <= 0) {
				array_push(alive_list, players[i]);
			}
		}
	}
	return alive_list;
}

function make_players(player_assignment, colour_assignment) {
	//make players
	var positionss = return_position(player_amount);
	for (var i = 0; i < player_amount; i++) {
		var xx = positionss[i]-w/2;
		var yy = room_height/2 - square_size*grid_h/2 + 125;
		with instance_create_layer(xx, yy, "Boards", oPlayer) {
			controls = player_assignment[i];
			colour_id = colour_assignment[i];
			player_id = i;
			colour = oInfo.colours[colour_id][0];
			array_push(other.players, id);
			other.players_colour[colour_id] = id;
		}
	}
	for (var i = 4; i >= 0; i--) {
		if (players_colour[i] == noone) {
			array_delete(players_colour, i, 1);
		}
	}
	if (player_amount == 1) && (good_mode) {
		var guy = players[0];
		chosen_guy = [guy.colour_id, guy.controls];
	}
}

function make_players_replay(order, instruc) {
	//make players
	var positionss = return_position(len(order));
	for (var i = 0; i < len(order); i++) {
		var color_id = array_find(colour_names, order[i]);
		var xx = positionss[i]-w/2;
		var yy = room_height/2 - square_size*grid_h/2 + 125;
		with instance_create_layer(xx, yy, "Boards", oPlayer) {
			controls = -1;
			colour_id = color_id;
			player_id = i;
			colour = oInfo.colours[colour_id][0];
			move_horizontal_list = instruc[i][0]; //positive is right
			move_down_list = instruc[i][1]; //never negative (canat go up)
			move_rotate_list = instruc[i][2]; //positive is clockwise
			move_slam_list = instruc[i][3]; //if slam was activated
			move_trash_list = instruc[i][4]; //other stuff
			array_push(other.players, id);
			other.players_colour[colour_id] = id;
		}
	}
	for (var i = 4; i >= 0; i--) {
		if (players_colour[i] == noone) {
			array_delete(players_colour, i, 1);
		}
	}
}

function save_everything() {
	//game info =================================================
	//getting order and names of rocks
	var names = [];
	for (var i = 0; i < len(players); i++) {
		array_push(names, colour_names[players[i].colour_id]);
	}
	var placings = [];
	for (var i = 0; i < len(placements); i++) {
		array_push(placings, colour_names[placements[i].colour_id]);
	}
	
	var game_info = [];
	array_push(game_info, seed);
	array_push(game_info, player_amount);
	array_push(game_info, names);
	array_push(game_info, placings);
	array_push(game_info, scorings);
	
	
	//player info =================================================
	var player_info = [];
	for (var i = 0; i < len(players); i++) {
		var individual = [];
		array_push(individual, players[i].move_horizontal_list);
		array_push(individual, players[i].move_down_list);
		array_push(individual, players[i].move_rotate_list);
		array_push(individual, players[i].move_slam_list);
		array_push(individual, players[i].move_trash_list);
		array_push(player_info, individual);
	}
	
	
	//combined together =================================================
	var the_save = [game_info, player_info];
	push(get_datetime(), the_save, true);
}


if (irandom_range(0, 1)) {
	oMusic.music(darkskies, 60, 0);
} else {
	oMusic.music(archetype, 60, 0);
}





























