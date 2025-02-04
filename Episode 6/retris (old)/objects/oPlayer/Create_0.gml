colour_id = 0;
player_id = 0;
colour = oInfo.colours[colour_id];

controls = 0; //keyboard, 0, 1, 2, 3

grid = array_create(oInfo.grid_h, array_create(oInfo.grid_w, 0)); //grid of stuff on the board
past_grid = array_create(oInfo.grid_h, array_create(oInfo.grid_w, 0)); //grid before last placement, used for garbage sending
coloured_grid = array_create(oInfo.grid_h, array_create(oInfo.grid_w, 0)); //square colours

slam_break = 0;

grid_surface = surface_create(oInfo.w, oInfo.h); //surface of pieces

step = 0; //referring to piece that the game is on
piece = oInfo.random_pieces[0];
rotation = oInfo.random_rotations[0];

height = oInfo.grid_h + oInfo.height_drop_map[piece, rotation];
height_wait = 0;
distance = round(oInfo.grid_w/2-2);
distance_wait = 0;
past_hor = 0;
time_before_drop = round(oInfo.time_before_drop);
time_to_be_layed = round(oInfo.time_before_drop); //constant per piece (still decreases after many attempts
time_layed = time_to_be_layed; //ever changing (counts down during)
check_just_layed = false; //just got to laying position

lines_removed = [];
garbage_sending = [];
garbage_recipient = noone;
garbage_recieving = []; //[garbage, timer]

//garbage that pops up top of grid, uses colour surface_values
voided_garbage = [];

shake = 0;
shake_x = 0;
shake_y = 0;

hover = true;
hover_y = 0;

pause = 0;
dead = 0;
placement = 0; //will get changed to 1-5

time_alive = 0;
pieces_placed = 0;
lines_total = 0;


with (instance_create_layer(0, 0, "Effects", oPlayerGlower)) {
	player = other.id;
}


function draw_piece(piece, rotation, distance, height, type=0) {
	var temp_piece = piece_rotated(piece, rotation);
	for (var yy = 0; yy < 4; yy++) {
		for (var xx = 0; xx < 4; xx++) {
			if (temp_piece[yy][xx] == 1) {
				draw_sprite(sBrick, piece+type*8, x+(distance+xx)*oInfo.square_size+shake_x, y+(oInfo.grid_h-height+yy)*oInfo.square_size+shake_y);
			}
		}
	}
	//draw_sprite_ext(sPiece, piece*4+rotation, x+distance*oInfo.square_size+shake_x, y+(oInfo.grid_h-height)*oInfo.square_size+shake_y, 1, 1, 0, colour, 1);
}


function redraw_grid_surface() {
	surface_set_target(grid_surface);
	draw_clear_alpha(c_white,0);
	
	for (var i = 0; i < len(coloured_grid); i++) {
		for (var j = 0; j < len(coloured_grid[i]); j++) {
			if (coloured_grid[i][j] != 0) { //there a square there
				draw_sprite(sBrick, coloured_grid[i][j]-1, j*oInfo.square_size, i*oInfo.square_size);
			}
		}
	}
	
	surface_reset_target();
}


function update_hover_y() {
	hover_y = height;
	while (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, hover_y-1) == false) {
		hover_y--;
	}
}


function count_squares() {
	var count = 0;
	for (var i = 0; i < len(grid); i++) {
		for (var j = 0; j < len(grid[i]); j++) {
			if (grid[i][j] != 0) {
				count++;
			}
		}
	}
	return count;
}


function choose_garbage_recipient() {
	var player_ids = [];
	var player_weights = [];
	for (var i = 0; i < len(oInfo.players); i++) {
		var guy = oInfo.players[i];
		if (guy != id) && (guy.dead == 0) { //not yo self
			array_push(player_ids, guy);
			array_push(player_weights, oInfo.grid_h*oInfo.grid_w - guy.count_squares()); //how many empty squares
		}
	}
	
	if (len(player_ids)) {
		return player_ids[weighted_random(player_weights)];
	}
	return -1;
}


function place_piece() {
	//placing piece on grid
	var guy = piece_rotated(piece, rotation);
	var spot_shift = array_corner_find(guy, 0);
	past_grid = array_clone(grid);
	grid = array_combine_2d([grid, array_trim(guy, 0)], [[0, 0], [distance+spot_shift[0], oInfo.grid_h-height+spot_shift[1]]]);
	oInfo.refresh(); //this is so annoying
	coloured_grid = array_combine_2d([coloured_grid, array_multiply(array_trim(guy, 0), (piece+1), 2)], [[0, 0], [distance+spot_shift[0], oInfo.grid_h-height+spot_shift[1]]]);
	oInfo.refresh(); //this is so annoying
	pieces_placed++;
	
	//add to grid surface
	surface_set_target(grid_surface);
	for (var yy = 0; yy < 4; yy++) {
		for (var xx = 0; xx < 4; xx++) {
			if (piece_rotated(piece, rotation)[yy][xx] == 1) {
				draw_sprite(sBrick, piece, (distance+xx)*oInfo.square_size, (oInfo.grid_h-height+yy)*oInfo.square_size);
			}
		}
	}
	surface_reset_target();
	
	//check to see if shlawg has died
	var check = false;
	for (var i = 0; i < len(grid); i++) {
		for (var j = 0; j < len(grid[i]); j++) {
			if (grid[i][j] > 1) {
				check = true;
			}
		}
	}
	
	if (check) { //death ===-=--=-=-=-=-=---=-=-=-=-=-=-=-=-=-=-=--=-=-==-=--=-=--==-=-=--=-==-=:
		dead = 1;
		shake = 0;
		//find placement
		for (var i = oInfo.player_amount-1; i >= 0; i--) {
			if (oInfo.placements[i] == -1) {
				placement = i+1;
				oInfo.placements[i] = id;
				break;
			}
		}
		if (placement == 1) { //came first
			oMusic.music(noone, 250, 0);
		}
		with (instance_create_layer(x, y, "Effects", oDeadStuff)) {
			piece = other.piece;
			rotation = other.rotation;
			distance = other.distance;
			height = other.height;
			highlighted_piece = piece_rotated(other.piece, other.rotation);
		}
	}
	else { //still alive -=-==-=-=-=--=-=-=-==-=-=-=-=--=-==-=-=-=--=-=-==-=--=-=-=-=-=-=-=-=-=-=-=-=-==-=-=--=-=:
		//clear any possible pieces
		lines_removed = [];
		var true_lines_removed = [];
		garbage_sending = [];
		var true_i = len(grid)-1;
		for (var i = len(grid)-1; i >= 0; i--) {
			if (array_equals(array_make(1, oInfo.grid_w), grid[i])) { //all 1s
				array_delete(grid, i, 1);
				array_insert(grid, 0, array_make(0, oInfo.grid_w));
				if !(array_contains(coloured_grid[i], 8)) { //checking whether or not garbage
					array_push(true_lines_removed, true_i);
				}
				array_delete(coloured_grid, i, 1);
				array_insert(coloured_grid, 0, array_make(0, oInfo.grid_w));
				array_push(lines_removed, true_i);
				lines_total++;
				i++;
			}
			true_i--;
		}
	
		if (len(lines_removed)) {
			pause = 15;
			hover = false;
			sfx(chime3, 400, false, 1, 0, random_range(0.9, 1.1));
			//applauses
			if (len(lines_removed) == 2) {
				sfx(oInfo.applauses[irandom_range(0, 1)], 100, false, 0.3);
			} else if (len(lines_removed) == 3) {
				sfx(oInfo.applauses[irandom_range(2, 5)], 100, false, 0.4);
			} else if (len(lines_removed) == 4) {
				sfx(oInfo.applauses[irandom_range(6, 9)], 100, false, 0.5);
			}
			//garbages
			if (len(true_lines_removed) == 2) {
				garbage_sending = [past_grid[true_lines_removed[1]]]; //only 1 line of garbage
			} else if (len(true_lines_removed) == 3) {
				garbage_sending = [past_grid[true_lines_removed[1]], past_grid[true_lines_removed[2]]]; //2 lines of garbage
			} else if (len(true_lines_removed) == 4) {
				garbage_sending = [past_grid[true_lines_removed[0]], past_grid[true_lines_removed[1]], past_grid[true_lines_removed[2]], past_grid[true_lines_removed[3]]]; //4 full lines of garbage
			}
		}
		
		//dealing with garbage
		if (len(garbage_sending)) && (array_count(oInfo.placements, -1) >= 2) {
			garbage_recipient = choose_garbage_recipient();
			if (garbage_recipient != -1) {
				with (garbage_recipient) {
					array_push(garbage_recieving, [other.garbage_sending, 100, other.colour]);
				}
			}
		}
	
		step = (step+1)%1000;
		piece = oInfo.random_pieces[step];
		rotation = oInfo.random_rotations[step];
	
		height = oInfo.grid_h + oInfo.height_drop_map[piece, rotation];
		height_wait = 0;
		distance = round(oInfo.grid_w/2-2);
		distance_wait = 0;
		past_hor = 0;
		time_before_drop = round(oInfo.time_before_drop);
		time_to_be_layed = round(oInfo.time_before_drop)+10; //constant per piece (still decreases after many attempts
		time_layed = time_to_be_layed; //ever changing (counts down during)
		check_just_layed = false; //just got to laying position
	
		update_hover_y();
	}
}


update_hover_y();



















