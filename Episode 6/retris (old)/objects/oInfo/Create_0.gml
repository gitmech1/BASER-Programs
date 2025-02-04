randomize();
draw_set_font(Font);


grid_w = 10;
grid_h = 28;
square_size = 40;
border_size = 10;
padding = 100;

w = grid_w*square_size;
h = grid_h*square_size;


time_before_drop = 50;
speed_up_time = false;

players = []; //ids of all of them
placements = []; //goes from first to fifth
scorings = [];
// PROPERLY SET UP IN STEP
reals = []; //the actual numbers to be dispayed when maxed
times_limit = []; //total time for each number to display
times_thus = []; //time passed thus far

time_since_end = 0;
time_since_end_end = 0;
time_for_score_max = 160; //dont act dumb you know what this is for


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
	[ #E73133, #431C1E], //red
	[ #F9806B, #7B3E33], //shrimp
	//[ #FD9B30, #774012], //orange
	[ #EFE4B9, #6B6552], //tan
	//[ #4CF664, #23792E], //lime
	//[ #277E46, #10331B], //green
	//[ #32C2F7, #186096], //blue
	[ #BB5CF8, #552B7B], //purple
	[ #F92AF0, #4B132F]  //magenta
];

explosions = [normalexplosion1, normalexplosion2, normalexplosion3];
punches = [meatypunch4, meatypunch5, meatypunch6, meatypunch7, meatypunch8, meatypunch9];
shards = [slam_red, slam_shrimp, slam_tan, slam_purple, slam_magenta];
applauses = [applause_01, applause_02, applause_03, applause_04, applause_05, applause_06, applause_07, applause_08, applause_09, applause_10, applause_11, applause_12];


function refresh() {
	pieces = [
		//LINE PIECE (light blue) =============================
		[[ //shape
			[[0, 1, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]],
			[[0, 1, 0, 0], [1, 1, 1, 1], [0, 1, 0, 0], [1, 1, 1, 1]],
			[[0, 1, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]],
			[[0, 1, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 1], [0, 4], [1, 1], [0, 4]],  [[0, 4], [1, 1], [0, 4], [1, 1]]],
	
		//SQUARE PIECE (yellow) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0]],
			[[0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0]],
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 2], [1, 2], [1, 2], [1, 2]],  [[1, 2], [1, 2], [1, 2], [1, 2]]],
	
		//J PIECE (blue) =============================
		[[ //shape
			[[0, 0, 1, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 0, 1, 0], [0, 1, 0, 0], [0, 1, 1, 0], [1, 1, 1, 0]],
			[[0, 1, 1, 0], [0, 1, 1, 1], [0, 1, 0, 0], [0, 0, 1, 0]],
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 2], [1, 3], [1, 2], [0, 3]],  [[0, 3], [1, 2], [1, 3], [1, 2]]],
	
		//L PIECE (orange) =============================
		[[ //shape
			[[0, 1, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 1, 0, 0], [0, 1, 1, 1], [0, 1, 1, 0], [0, 0, 1, 0]],
			[[0, 1, 1, 0], [0, 1, 0, 0], [0, 0, 1, 0], [1, 1, 1, 0]],
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 0]]
		//colours, piece surface
		], [[1, 2], [1, 3], [1, 2], [0, 3]],  [[0, 3], [1, 2], [1, 3], [1, 2]]],
	
		//S PIECE (lime) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 0, 1, 1], [0, 1, 0, 0], [0, 0, 1, 1], [0, 1, 0, 0]],
			[[0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0]],
			[[0, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 0], [0, 0, 1, 0]]
		//colours, piece surface
		], [[1, 3], [1, 2], [1, 3], [1, 2]],  [[1, 2], [1, 3], [1, 2], [1, 3]]],
	
		//Z PIECE (red) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[1, 1, 0, 0], [0, 0, 1, 0], [1, 1, 0, 0], [0, 0, 1, 0]],
			[[0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0], [0, 1, 1, 0]],
			[[0, 0, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0]]
		//colours, piece surface
		], [[0, 3], [1, 2], [0, 3], [1, 2]],  [[1, 2], [0, 3], [1, 2], [0, 3]]],
	
		//T PIECE (purple, pink?) =============================
		[[ //shape
			[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
			[[0, 1, 0, 0], [0, 1, 0, 0], [0, 0, 0, 0], [0, 1, 0, 0]],
			[[1, 1, 1, 0], [0, 1, 1, 0], [1, 1, 1, 0], [1, 1, 0, 0]],
			[[0, 0, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0], [0, 1, 0, 0]]
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
				pieces_since[j] *= 1.1;
			}
		}
	}
	
	return tha_pieces;
}


height_drop_map = [[0, 1, 0, 1], [1, 1, 1, 1], [0, 1, 1, 1], [0, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 2, 1]];


random_pieces = generate_random_pieces(); //list of all pieces
random_rotations = []; //list of all piece rotations when generated
for (var i = 0; i < 1000; i++) {
	array_push(random_rotations, irandom_range(0, 3));
}


//background border
//border = surface_create(oInfo.w+oInfo.border_size*2, oInfo.h+oInfo.border_size);
//generate_border(border);


player_amount = 0;


function return_position(player_count) {
	var all_of_em = [];
	for (var i = 0; i < player_count; i++) {
		if (player_count > 1) {
			var difference = (room_width-2*padding - player_count*w)/(player_count-1);
			array_push(all_of_em, padding + (w+difference)*i + w/2);
		} else {
			array_push(all_of_em, (room_width-w)/2 + w/2);
		}
	}
	return all_of_em;
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
		}
	}
}


oMusic.music(darkskies, 60, 0);




























