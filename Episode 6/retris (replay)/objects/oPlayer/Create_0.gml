lifespan = 0;

colour_id = 0;
player_id = 0;
colour = oInfo.colours[colour_id];

controls = 0; //keyboard, 0, 1, 2, 3, -1 for replay

moves = []; //[[xoffset, yoffset], lerp, time, ease_function]
perm_x_offset = 0;
perm_y_offset = 0;
future_x = x;
future_y = y;

size = 1;
desired_size = 1;

//for recording
move_horizontal_list = [1]; //positive is right
move_down_list = [1]; //never negative (canat go up) (can now)
move_rotate_list = [1]; //positive is clockwise
move_slam_list = [1]; //if slam was activated
move_trash_list = [1]; //if trash target was chosen

grid = array_create_2d(oInfo.grid_h, oInfo.grid_w, 0); //grid of stuff on the board
past_grid = array_create_2d(oInfo.grid_h, oInfo.grid_w, 0); //grid before last placement, used for garbage sending
coloured_grid = array_create_2d(oInfo.grid_h, oInfo.grid_w, 0); //square colours
past_coloured_grid = array_create_2d(oInfo.grid_h, oInfo.grid_w, 0); //used for checking powerup spots

everything_surface = surface_create(oInfo.w+oInfo.w_extra*2, oInfo.h+oInfo.h_extra*2); //500 pixels of lenience on each side
grid_surface = surface_create(oInfo.w, oInfo.h); //surface of pieces

step = 0; //referring to piece that the game is on
piece = oInfo.random_pieces[0];
piece_next = oInfo.random_pieces[1];
rotation = oInfo.random_rotations[0];

powerup = 0; //0 for not existant, 1-4 for piece location
powerup_type = 0; //attack (red), swap (green), boom (blue)
powerup_using = [0, 0, 0] //holds for rgb
powerup_in_da_bank = []; //location, type

powerup_move_log = [0, 0, 0, 0]; //for recording powerups (per frame)

powerup_triggering = -1; //0, 1, 2 for when one is being used
powerup_lifespan = 0; //during usage

//green powerup stufff
pointer_player = noone; //noone when no powerup is being used
pointer_spots = []; //index of every block that refers to me
new_height = 0; //used for removing it

height = oInfo.grid_h + oInfo.height_drop_map[piece, rotation];
height_wait = 0;
distance = round(oInfo.grid_w/2-2);
distance_wait = 0;
past_hor = 0;
time_before_drop = round(oInfo.time_before_drop);
time_to_be_layed = round(oInfo.time_before_drop); //constant per piece (still decreases after many attempts
time_layed = time_to_be_layed; //ever changing (counts down during)
check_just_layed = false; //just got to laying position

trash_target = noone;
trash_target_id = -1; //in colours alive
trash_target_true_id = -1; //in colour
trash_target_timer = 0;
trash_target_shake = 0;

lines_removed = [];
garbage_sending = [];
garbage_recipient = noone;
garbage_recieving = []; //[garbage, timer]

//garbage that pops up top of grid, uses colour surface_values
voided_garbage = [];

shake = 0;
shake_long = 0;
shake_x = 0;
shake_y = 0;

hover = true;
hover_y = 0;

pause = 0;
slam_break = 0;
dead = 0;
placement = 0; //will get changed to 1-5

time_alive = 0;
pieces_placed = 0;
lines_total = 0;

glower_guy = noone;

//red
red_lines = 6;

x_movement = 0;
y_movement = 0;
select = 0;
past_raw_x_movement = 0; //for powerups
past_raw_y_movement = 0; //for powerups

red_selected = 0; //becomes a timer
red_given_up = 0; //for if nothing is selected

powerup_x = 0; //relative location of choosing cursor
real_powerup_x = 0; //real location
powerup_y = 0; //relative location of choosing cursor
real_powerup_y = 0; //real location

height_map = [];
height_lifespan = 0;
height_guy = noone;

//green
block_order = []; //for every block that flies off for green
block_amount = 20+oInfo.player_amount*10;
ready_to_clear_lines = false;

//blue
blue_lines = 8; //change if required


shenanigan_senders = []; //timer, colour (displays who is now sending to u)
shenanigan_time = 150;
shenanigan_width = 60;


with (instance_create_layer(0, 0, "Effects", oPlayerGlower)) {
	player = other.id;
	other.glower_guy = id;
}


function update_controls(control) {
	if (control == "keyboard") { //keyboarding
		hor = keyboard_check(vk_right) - keyboard_check(vk_left);
		hor_pressed = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
		hor_released = keyboard_check_released(vk_right) - keyboard_check_released(vk_left);
		down = keyboard_check(vk_down) - keyboard_check(vk_up);
		down_pressed = keyboard_check_pressed(vk_down);
		down_released = keyboard_check_released(vk_down);
		slam = keyboard_check_pressed(vk_space);
		r_left = 0; //keyboard_check_pressed(vk_up);
		r_right = keyboard_check_pressed(vk_up);
		
		trash_selection = 0;
		if (keyboard_check_pressed(ord("W"))) {
			trash_selection = 1;
		} else if (keyboard_check_pressed(ord("A"))) {
			trash_selection = 2;
		} else if (keyboard_check_pressed(ord("S"))) {
			trash_selection = 3;
		} else if (keyboard_check_pressed(ord("D"))) {
			trash_selection = 4;
		}
	}
	
	else if (control >= 0) {
		hor = gamepad_axis_value(controls, gp_axislh);
		down = gamepad_axis_value(controls, gp_axislv);
		slam = gamepad_button_check_pressed(controls, gp_face1) || gamepad_button_check_pressed(controls, gp_shoulderrb);
		r_left = gamepad_button_check_pressed(controls, gp_shoulderl);
		r_right = gamepad_button_check_pressed(controls, gp_shoulderr);
		
		trash_selection = 0;
		if (gamepad_button_check_pressed(controls, gp_padu)) {
			trash_selection = 1;
		} else if (gamepad_button_check_pressed(controls, gp_padl)) {
			trash_selection = 2;
		} else if (gamepad_button_check_pressed(controls, gp_padd)) {
			trash_selection = 3;
		} else if (gamepad_button_check_pressed(controls, gp_padr)) {
			trash_selection = 4;
		}
	}
	
	else { //play with cho mind (replay)
		hor = 0;
		hor_pressed = 0;
		hor_released = 0;
		down_pressed = 0;
		down = 0;
		down_released = 0;
		slam = 0;
		r_left = 0;
		r_right = 0;
		trash_selection = 0;
			
		//changing stuff
		if (len(move_horizontal_list)) {
			var sgin = sign(move_horizontal_list[0]);
			move_horizontal_list[0] -= sgin;
			if (move_horizontal_list[0] == 0) {
				array_delete(move_horizontal_list, 0, 1);
				hor = sgin;
				hor_pressed = sgin;
			}
		}
		if (len(move_down_list)) {
			var sgin = sign(move_down_list[0]);
			move_down_list[0] -= sgin;
			if (move_down_list[0] == 0) {
				array_delete(move_down_list, 0, 1);
				down = 1;
				down_pressed = 1;
			}
		}
		if (len(move_rotate_list)) {
			var sgin = sign(move_rotate_list[0]);
			move_rotate_list[0] -= sgin;
			if (move_rotate_list[0] == 0) {
				array_delete(move_rotate_list, 0, 1);
				if (sgin > 0) {
					r_right = 1;
				} else {
					r_left = 1;
				}
			}
		}
		if (len(move_slam_list)) {
			var sgin = sign(move_slam_list[0]);
			move_slam_list[0] -= sgin;
			if (move_slam_list[0] == 0) {
				array_delete(move_slam_list, 0, 1);
				slam = 1;
			}
		}
		if (len(move_trash_list)) {
			var sgin = sign(move_trash_list[0][0]);
			move_trash_list[0][0] -= sgin;
			if (move_trash_list[0][0] == 0) {
				trash_selection = move_trash_list[0][1];
				array_delete(move_trash_list, 0, 1);
			}
		}
			
		distance_wait = 0;
		height_wait = 0;
	}
}


function add_shenaniganner(color_id) {
	if !(dead) {
		var is_it_there = -1;
		for (var i = 0; i < len(shenanigan_senders); i++) {
			if (shenanigan_senders[i][1] == color_id) {
				is_it_there = i;
			}
		}
	
		if (is_it_there != -1) { //is there
			shenanigan_senders[is_it_there][0] = max(shenanigan_senders[is_it_there][0], shenanigan_time-20, -shenanigan_senders[is_it_there][0]+shenanigan_time);
		} else { //aint
			array_push(shenanigan_senders, [150, color_id]);
		}
	}
}


function add_move(xoffset, yoffset, lifetime, ease_function=ease_in_out, factor=2) {
	array_push(moves, [[xoffset, yoffset], 0, lifetime, ease_function, factor]);
	future_x += xoffset;
	future_y += yoffset;
}


function find_real_pos(dist_from_x, dist_from_y) {
	/*var proper_x = dist_from_x - (x+oInfo.w/2) + shake_x;
	var proper_y = dist_from_y - (y+oInfo.h/2) + shake_y;
	proper_x *= size;
	proper_y *= size;
	return [x+oInfo.w/2 - proper_x, y+oInfo.h/2 - proper_y];*/
	var middle_x = x+oInfo.w/2;
	var middle_y = y+oInfo.h/2;
	var dist_x = (dist_from_x - oInfo.w/2) * size;
	var dist_y = (dist_from_y - oInfo.h/2) * size;
	return [middle_x+dist_x, middle_y+dist_y];	
}


function draw_piece(piece, rotation, distance, height, type=0, _x=x, _y=y) {
	var temp_piece = piece_rotated(piece, rotation);
	for (var yy = 0; yy < 4; yy++) {
		for (var xx = 0; xx < 4; xx++) {
			if (temp_piece[yy][xx] != 0) {
				if (temp_piece[yy][xx] == powerup) { //da powerup
					if (type == 1) {
						var index = 15;
					} else {
						var index = 16+powerup_type;
					}
					draw_sprite(sBrick, index, _x+(distance+xx)*oInfo.square_size+shake_x, _y+(oInfo.grid_h-height+yy)*oInfo.square_size+shake_y);
				} else { //normal cube
					draw_sprite(sBrick, piece+type*8, _x+(distance+xx)*oInfo.square_size+shake_x, _y+(oInfo.grid_h-height+yy)*oInfo.square_size+shake_y);
				}
			}
		}
	}
	//draw_sprite_ext(sPiece, piece*4+rotation, x+distance*oInfo.square_size+shake_x, y+(oInfo.grid_h-height)*oInfo.square_size+shake_y, 1, 1, 0, colour, 1);
}


function draw_piece_pos(piece, rotation, xpos, ypos, type=0) {
	var temp_piece = piece_rotated(piece, rotation);
	for (var yy = 0; yy < 4; yy++) {
		for (var xx = 0; xx < 4; xx++) {
			if (temp_piece[yy][xx] != 0) {
				if (temp_piece[yy][xx] == powerup) { //da powerup
					if (type == 1) {
						var index = 15;
					} else {
						var index = 16+powerup_type;
					}
					draw_sprite(sBrick, index, xpos+xx*oInfo.square_size, ypos+yy*oInfo.square_size);
				} else { //normal cube
					draw_sprite(sBrick, piece+type*8, xpos+xx*oInfo.square_size, ypos+yy*oInfo.square_size);
				}
			}
		}
	}
}


function block_id_to_index(the_id) {
	if (the_id < 0) { //powerup
		return -the_id+15;
	} else if (the_id > 0) { //normal
		return the_id-1;
	} else { //nothing (should never happen)
		return 19;
	}
}


function redraw_grid_surface() {
	surface_set_target(grid_surface);
	surface_clear();
	
	for (var i = 0; i < len(coloured_grid); i++) {
		for (var j = 0; j < len(coloured_grid[i]); j++) {
			var id_guy = coloured_grid[i][j];
			if (id_guy != 0) {
				draw_sprite(sBrick, block_id_to_index(id_guy), j*oInfo.square_size, i*oInfo.square_size);
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


function find_trash_line(amount) { //make shape of trash to be recieved
	var line_to_check = grid[oInfo.grid_h-1];
	if (array_count(line_to_check, 0) == 1) {
		return array_create_clone(line_to_check, amount);
	} else {
		var num = irandom_range(0, oInfo.grid_w-1);
		while (line_to_check[num] != 0) {
			var num = irandom_range(0, oInfo.grid_w-1);
		}
		var new_line = array_create(oInfo.grid_w, 1);
		new_line[num] = 0;
		return array_create_clone(new_line, amount);
	}
}


function count_squares(temp_grid) {
	var count = 0;
	for (var i = 0; i < len(temp_grid); i++) {
		for (var j = 0; j < len(temp_grid[i]); j++) {
			if (temp_grid[i][j] != 0) {
				count++;
			}
		}
	}
	return count;
}


function choose_garbage_recipient() { //uses random so kinda cringe
	var player_ids = [];
	var player_weights = [];
	for (var i = 0; i < len(oInfo.players); i++) {
		var guy = oInfo.players[i];
		if (guy != id) && (guy.dead == 0) { //not yo self
			array_push(player_ids, guy);
			array_push(player_weights, oInfo.grid_h*oInfo.grid_w - guy.count_squares(grid)); //how many empty squares
		}
	}
	
	if (len(player_ids)) {
		return player_ids[weighted_random(player_weights)];
	}
	return -1;
}


function calculate_rot_spot(new_rot) { //rotation (thought rot spot sounds cooler)
	var result_types = ["left wall", "right wall", "floor", "roof", "guy"];
	
	var rot_result = check_piece_colliding(grid, piece_rotated(piece, new_rot), distance, height);
	
	if (rot_result == false) { //hots nothing (YAY)
		return [0, 0];
	}
	else {
		var instructions = oInfo.check_directions[array_find(result_types, rot_result)];
		for (var i = 0; i < len(instructions); i++) {
			var move = instructions[i];
			if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance+move[0], height+move[1]) == false) {
				return [move[0], move[1]];
			}
		}
	}
	
	return false;
}


function is_dead() {
	//check to see if shlawg has died
	for (var i = 0; i < len(grid); i++) {
		for (var j = 0; j < len(grid[i]); j++) {
			if (grid[i][j] > 1) {
				return true;
			}
		}
	}
	return false;
}

function die() {
	dead = 1;
	shake = 0;
	trash_target_timer = min(trash_target_timer, 30);
	
	depth = 450;
	
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
	//death animation
	with (instance_create_layer(x, y, "Effects", oDeadStuff)) {
		piece = other.piece;
		rotation = other.rotation;
		distance = other.distance;
		height = other.height;
		highlighted_piece = piece_rotated(other.piece, other.rotation);
		player = other.id;
	}
}



function player_from_powerup_x(the_x=-1, id_player=-1) {
	var alive_guys = oInfo.return_alive_players();
	
	if (the_x == -1) {
		the_x = powerup_x;
	}
	if (id_player == -1) {
		id_player = oInfo.players[player_id];
	}
	
	var index = the_x + (the_x >= array_find(alive_guys, id_player));
	
	return alive_guys[index];
}

function find_lowest_empty_column(temp_grid) {
	var lowest = 0; //highest spot
	for (var i = 0; i < len(temp_grid); i++) {
		if (array_equals(temp_grid[i], array_create(oInfo.grid_w, 0))) && (i > lowest) {
			lowest = i;
		}
	}
	return lowest;
}

function random_column() {
	var column = oInfo.random_columns[oInfo.column_step];
	oInfo.column_step = (oInfo.column_step+1)%1000;
	return column;
}

function random_column_exclusion(array_of_numbers_to_exclude) {
	var random_num = random_column();
	while (array_contains(array_of_numbers_to_exclude, random_num)) {
		var random_num = random_column();
	}
	return random_num;
}

function find_uncovered_block(temp_grid) { //returns coordinates [x, y]
	var found = false;
	var column = 0;
	var i = 0;
	var tried = []; //tried columns
	var cancel = false;
	while !(found) { //switches column around
		column = random_column_exclusion(tried);
		array_push(tried, column);
		i = 0;
		cancel = false;
		while (temp_grid[min(i, oInfo.grid_h-1)][column] == 0) && !(cancel) { //looks for block in column
			i++;
			if (i >= oInfo.grid_h) {
				cancel = true;
			}
		}
		if !(cancel) {
			found = true;
		}
		if (array_contains_range(tried, 0, oInfo.grid_w-1)) && (found == false) { //tried every column
			found = true;
			cancel = true;
		}
	}
	if !(cancel) { //found valid column
		return [column, i];
	}
	return -1; //nothing there
}

function find_uncovered_space(temp_grid) { //this finally actually works my god
	var column = random_column();
	var i = 0;
	for (var i = 0; i < oInfo.grid_h; i++) {
		if (temp_grid[min(i+1, oInfo.grid_h-1)][column] != 0) {
			return [column, i];
		}
	}
	return [column, oInfo.grid_h-1];
	/*var column = irandom_range(0, oInfo.grid_w-1);
	for (var i = 0; i < oInfo.grid_h; i++) {
		if (temp_grid[oInfo.grid_h-i-1][column] == 0) {
			return [column, oInfo.grid_h-i-1];
		}
	}*/
}

function find_space_heights(temp_grid) {
	var heights = [];
	for (var i = 0; i < len(temp_grid[0]); i++) {
		var temp = 0;
		var stopped = false;
		for (var j = 0; j < len(temp_grid); j++) {
			if (temp_grid[j][i] == 0) && !(stopped) {
				temp++;
			} else {
				stopped = true;
			}
		}
		array_push(heights, temp);
	}
	return heights;
}

function find_green_victim() {
	var alive_list = oInfo.return_alive_players();
	
	var my_spot = array_find(alive_list, id);
	var index = oInfo.random_g_victims[oInfo.victim_step] % (len(alive_list)-1);
	oInfo.victim_step = (oInfo.victim_step+1)%1000;
	
	if (index >= my_spot) {
		index++;
	}
	return alive_list[index];
}

function remove_block(temp_grid, temp_coloured_grid, xpos, ypos) {
	temp_grid[ypos][xpos] = 0;
	temp_coloured_grid[ypos][xpos] = 0;
}

function add_block(temp_grid, temp_coloured_grid, xpos, ypos, id_of_block) {
	temp_grid[ypos][xpos] = 1;
	temp_coloured_grid[ypos][xpos] = id_of_block;
}

function start_powerup(type) { //0, 1, 2
	powerup_triggering = type;
	powerup_lifespan = 0;
	oInfo.powerup_pause = true;
	
	trash_target_timer = min(trash_target_timer, 30);
	
	glower_guy.to_glow_message[type] = true;
	glower_guy.edge_glow = powerup_triggering;
	glower_guy.edge_lifespan = 0;
	glower_guy.refresh_blast();
	
	if (type == 0) {
		powerup_x = 0;
		powerup_y = oInfo.grid_h-red_lines;
		real_powerup_x = player_from_powerup_x().x;
		real_powerup_y = y+powerup_y*oInfo.square_size
		red_selected = 0;
	}
	
	else if (type == 1) {
		//generating pieces
		block_order = [];
		var mount_o_squares = count_squares(grid);
		
		for (var i = 0; i < min(block_amount, mount_o_squares); i++) {
			var block = find_uncovered_block(grid); //find block to take from side
			var block_type = coloured_grid[block[1]][block[0]];
			var victim = find_green_victim(); //chooses non me victim
			var victim_spot = find_uncovered_space(victim.grid); //finds spot to put new block
			
			victim.pointer_player = id;
			array_push(victim.pointer_spots, i); /////////////////////////////need to remember to clear pointer_spots from victim after triggered
			
			array_push(block_order, [block, victim, victim_spot, block_type, 0]); //[old block pos, victim sending, victim block spot, colour, lifespan]
			remove_block(grid, coloured_grid, block[0], block[1]); //remove block from my side
			victim.add_block(victim.grid, victim.coloured_grid, victim_spot[0], victim_spot[1], block_type); //add block to victim side (ISNT DRAWN YET)
			
			victim.new_height = clamp(oInfo.grid_h-find_lowest_empty_column(victim.grid)+4, victim.height, oInfo.grid_h+oInfo.height_drop_map[victim.piece, victim.rotation]);
		}
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//for (var i = 0; i < len(oInfo.players); i++) {
		//	oInfo.players[i].redraw_grid_surface();
		//}
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//redraw_grid_surface();
	}
	
	else if (type == 2) {
		past_grid = array_clone(grid);
		past_coloured_grid = array_clone(coloured_grid);
		
		glower_guy.blue_lifespan = 1;
	}
	
	powerup_using[type] = 0;
}

function end_powerup(type) { //0, 1, 2
	powerup_triggering = -1;
	powerup_lifespan = 0;
	oInfo.powerup_pause = false;
	
	array_push(glower_guy.edge_retracting, [type, glower_guy.edge_lifespan, 30]); //[colour id, lifespan, time_left]
	glower_guy.edge_glow = -1;
	glower_guy.edge_lifespan = 0;
	
	redraw_grid_surface();
	update_hover_y();
	
	if (type == 0) {
		red_selected = 0;
		red_given_up = 0;
		
		var guy = player_from_powerup_x();
		
		guy.height_map = [];
		guy.height_lifespan = 0;
		guy.height_guy = noone;
		
		guy.ready_to_clear_lines = true;
		
		guy.redraw_grid_surface();
		guy.update_hover_y()
		
		past_grid = array_clone(grid);
		guy.past_grid = array_clone(guy.grid);
		past_coloured_grid = array_clone(coloured_grid);
		guy.past_coloured_grid = array_clone(guy.coloured_grid);
	}
	
	if (type == 1) {
		//get all victims
		var victim_list = [];
		for (var i = 0; i < len(block_order); i++) { //[old block pos, victim sending, victim block spot, colour, lifespan]
			if !(array_contains(victim_list, block_order[i][1])) {
				array_push(victim_list, block_order[i][1]);
			}
		}
		
		//do final stuff with those suckers
		for (var i = 0; i < len(victim_list); i++) {
			var victim = victim_list[i];
			victim.height = victim.new_height;
			victim.redraw_grid_surface();
			victim.pointer_player = noone;
			victim.pointer_spots = [];
			victim.update_hover_y();
			victim.ready_to_clear_lines = true;
		}
		
		block_order = [];
	}
}

function powerup_step() {
	if (array_contains(powerup_using, 1)) || (powerup_triggering != -1) {
		powerup_move_log = [0, 0, 0, 0]; //for horizontal, down, up, slam
		
		if (powerup_triggering == -1) {
			if (count_squares(grid) == 0) { //nothing left
				powerup_using = [0, 0, 0];
				glower_guy.to_glow = [[], [], []];
				glower_guy.blue_lifespan = 0;
			} else {
				start_powerup(array_find(powerup_using, 1));
				sfx(area_king, 1000, false);
				powerup_x = 0;
			}
		} else {
			powerup_lifespan++;
		}
	
		//red, attack -----------------------------------------------------------------
		if (powerup_triggering = 0) {
			if (red_selected > 0) {
				red_selected++;
				
				if (red_selected >= 120)  {
					end_powerup(powerup_triggering);
					powerup_step();
				}
			}
			 else if (red_given_up > 0) {
				red_given_up++;
				
				if (red_given_up >= 120)  {
					end_powerup(powerup_triggering);
					powerup_step();
				}
			}
			
			//comtrols stuff
			if !(red_selected) && !(red_given_up) {
				if (controls == "keyboard") { //keyboard
					var temp_movement = 0;
					
					//tech movementing
					if (down != 0) && (!distance_wait) {
						temp_movement = down;
						
						if ((down_pressed - r_right) != 0) { //pressed for the first time
							distance_wait = 20;
						} else { //pressed for the first time
							distance_wait = 5;
						}
					} else {
					//releasing
						if (down_released != 0) {
							distance_wait = 0;
						}
					}
					
					x_movement = hor_pressed; //left and right
					y_movement = sign((down_pressed - r_right) + temp_movement); //up and down
					select = slam; //choosing person
					
					powerup_move_log[0] = hor_pressed;
					powerup_move_log[1] = sign(down_pressed + (temp_movement==1));
					powerup_move_log[2] = sign(r_right + (temp_movement==-1));
					powerup_move_log[3] = slam;
				}
				else if (controls >= 0) { //controler
					var temp_movement = 0;
					
					//allowing for tech movement
					if (abs(down) > oInfo.joystick_spot) && (!distance_wait) {
						temp_movement = sign(down);
							
						if (abs(past_raw_y_movement) > oInfo.joystick_spot) { //already at pace
							distance_wait = round(5/max(0.2, abs(down)));
						} else { //last one
							distance_wait = 20;
						}
					} else {
						if (abs(down) <= oInfo.joystick_spot) {
							distance_wait = 0;
						}
					}
					
					raw_x_movement = hor;
					raw_y_movement = down;
					select = slam; //choosing person
					
					//turning raw x into usable
					x_movement = 0;
					if (abs(raw_x_movement) > oInfo.joystick_spot) {
						if !(abs(past_raw_x_movement) > oInfo.joystick_spot) {
							x_movement = sign(raw_x_movement);
						}
					}
					past_raw_x_movement = raw_x_movement;
				
					//turning raw y into usable
					y_movement = temp_movement;
					if (abs(raw_y_movement) > oInfo.joystick_spot) {
						if !(abs(past_raw_y_movement) > oInfo.joystick_spot) {
							y_movement = sign(raw_y_movement);
						}
					}
					past_raw_y_movement = raw_y_movement;
					
					powerup_move_log[0] = x_movement;
					powerup_move_log[1] = (y_movement == 1);
					powerup_move_log[2] = (y_movement == -1);
					powerup_move_log[3] = slam;
				}
				else { //replaying
					x_movement = hor_pressed; //left and right
					y_movement = down_pressed - r_right; //up and down
					select = slam; //choosing person
				}
			}
			
			else { //turn off controls after move
				x_movement = 0;
				y_movement = 0;
				select = 0;
			}
			
			if (select) && (powerup_lifespan > 100) && !(red_given_up) {
				red_selected = 1; //starts the timer
				
				sfx(purchase, 1000, false, 1, 0.1);
				sfx(die_flash);
				sfx(levelup, 999, false, 1, 0.1);
				sfx(only_loop_back);
				oDarkify.add(120, ease_out, 3, 0.7);
				
				var guy = player_from_powerup_x();
				guy.shake_long = 80;
				shake_long = 50;
				
				insert_lines(id, guy, array_range(powerup_y, powerup_y+red_lines));
				
				select = 0;
			}
			
			else if (powerup_lifespan == 60*16-1) && !(red_selected) {
				red_given_up = 1;
				sfx(deep, 1000000, false, 1, 1.15);
				sfx(only_loop_back);
			}
			
			else {
				if (abs(x_movement)) && (oInfo.player_amount >= 3) {
					powerup_x = clamp(powerup_x+x_movement, 0, len(oInfo.return_alive_players())-2);
					real_powerup_x += x_movement*60;
					sfx(toggle_b, 1234, false, 1, 0.1);
				}
			
				if (abs(y_movement)) {
					powerup_y = clamp(powerup_y+y_movement, 0, oInfo.grid_h-red_lines);
					real_powerup_y += y_movement*30;
					sfx(toggle_b, 1234, false, 1, 0.1);
				}
			
				//update real powerup x
				real_powerup_x = lerp(real_powerup_x, player_from_powerup_x().x, 0.35);
				real_powerup_y = lerp(real_powerup_y, y+powerup_y*oInfo.square_size, 0.35);
			}
			
			if (powerup_lifespan%60 == 0) && (60*16-powerup_lifespan <= 5*60) && !(red_given_up) && !(red_selected) {
				sfx(bomb_timer, 100, false);
			}
		}
	
		//green, switch -----------------------------------------------------------------
		if (powerup_triggering == 1) {
			if (powerup_lifespan == 15) {
				redraw_grid_surface();
			}
			
			//lifespan control of all blocks
			for (var i = 0; i < len(block_order); i++) {
				if (powerup_lifespan-80-i*4 > 0) {
					block_order[i][4]++; //block lifespan
				}
				
				if (powerup_lifespan-80-i*4 == 33) {
					sfx(oInfo.swings[irandom_range(0, 5)], 10, false, random_range(0.2, 0.4), 0.1, random_range(0.5, 1.5));
				}
			}
		
			if (powerup_lifespan >= 160+len(block_order)*4) {
				end_powerup(powerup_triggering);
				powerup_step();
			} else if (powerup_lifespan == 40+len(block_order)*4) {
				sfx(only_loop_back, 1000, false);
			}
		}
	
		//blue, boom -----------------------------------------------------------------
		if (powerup_triggering == 2) {
			if (powerup_lifespan == 30) {
				sfx(charge_and_shoot, 1000, false);
			}
			
			if (powerup_lifespan < 130) {
				shake = powerup_lifespan/20+1;
			} else if (powerup_lifespan < 150) {
				shake_long = 120;
			
				if (powerup_lifespan == 130) {
					clear_lines(array_range(oInfo.grid_h-blue_lines, oInfo.grid_h), false, false);
					redraw_grid_surface();
					
					oDarkify.add(120, ease_out, 3, 0.7);
				}
			} else if (powerup_lifespan == 150) {
				end_powerup(powerup_triggering);
				powerup_step();
			}
		}
	}
}


function find_complete_lines(temp_grid, temp_coloured_grid) {
	var lines = []; //index, is_garbage
	
	for (var i = 0; i < len(temp_grid); i++) {
		if (array_equals(array_make(1, oInfo.grid_w), temp_grid[i])) { //all 1s
			if !(array_contains(temp_coloured_grid[i], 8)) { //isnt garbage
				array_push(lines, [i, false]);
			} else { //is garbage
				array_push(lines, [i, true]);
			}
		}
	}
	
	return lines;
}


function remove_lines(temp_grid, temp_coloured_grid, lines_to_clear) {
	for (var i = 0; i < len(temp_grid); i++) {
		if (array_contains(lines_to_clear, i)) {
			lines_total++;
			//normal grid
			array_delete(temp_grid, i, 1);
			array_insert(temp_grid, 0, array_create(oInfo.grid_w, 0));
			//coloured grid
			array_delete(temp_coloured_grid, i, 1);
			array_insert(temp_coloured_grid, 0, array_create(oInfo.grid_w, 0));
		}
	}
}


function find_powerups(coloured_row) {
	var powerups = [];
	
	for (var i = 0; i < len(coloured_row); i++) {
		if (coloured_row[i] < 0) {
			array_push(powerups, [i, coloured_row[i]]);
		}
	}
	
	return powerups;
}


function clear_lines(already_gotten_lines=-1, do_garbage=false, animation=true, do_powerups=true) {
	//find all lines that are complete, and de stroy them
	if (already_gotten_lines == -1) {
		lines_removed = find_complete_lines(grid, coloured_grid);
	} else {
		var temp_lines_removed = already_gotten_lines;
		lines_removed = [];
		for (var i = 0; i < len(temp_lines_removed); i++) {
			array_push(lines_removed, [temp_lines_removed[i], false]);
		}
	}
	var only_indexes = [];
	for (var i = 0; i < len(lines_removed); i++) {
		array_push(only_indexes, lines_removed[i][0]);
	}
	remove_lines(grid, coloured_grid, only_indexes);
	
	var true_lines_removed = [];
	for (var i = 0; i < len(lines_removed); i++) {
		if (lines_removed[i][1] == false) {
			array_push(true_lines_removed, lines_removed[i][0]);
		}
	}
	
	if (do_garbage) {
		garbage_sending = [];
	}
	
	if (len(lines_removed)) { //means lines are getting cleared
		if (animation) {
			pause = 15;
			glower_guy.time_left = 15;
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
		}
		
		if (do_garbage) {
			//garbages (stuff here is technically redundant as way of generatinbg trash was replaced but who cares)
			if (len(true_lines_removed) == 2) {
				garbage_sending = [past_grid[true_lines_removed[1]]]; //only 1 line of garbage
			} else if (len(true_lines_removed) == 3) {
				garbage_sending = [past_grid[true_lines_removed[1]], past_grid[true_lines_removed[2]]]; //2 lines of garbage
			} else if (len(true_lines_removed) == 4) {
				garbage_sending = [past_grid[true_lines_removed[0]], past_grid[true_lines_removed[1]], past_grid[true_lines_removed[2]], past_grid[true_lines_removed[3]]]; //4 full lines of garbage
			}
		}
			
		//checking for powerups
		if (do_powerups) {
			//                   r   g   b
			var powerup_spots = [[], [], []];
			for (var i = 0; i < len(lines_removed); i++) {
				/*for (var j = 0; j < oInfo.grid_w; j++) {
					var guy = past_coloured_grid[lines_removed[i][0]][j];
					if (guy < 0) {
						//           part of list            coordinates [x, y]
						array_push(powerup_spots[-guy-1], [j, lines_removed[i][0]]);
					}
				}*/
				var powerups = find_powerups(past_coloured_grid[lines_removed[i][0]]);
				if (len(powerups)) {
					sfx(gemhitground, 500, false, 1, 0.1);
				}
				for (var j = 0; j < len(powerups); j++) {
					var guy = powerups[j];
					array_push(powerup_spots[-guy[1]-1], [guy[0], lines_removed[i][0]]);
				}
			}
			//checking if powerups were cleared
			for (var i = 0; i < len(powerup_spots); i++) {
				for (var j = 0; j < len(powerup_spots[i]); j++) {
					array_push(glower_guy.to_glow[i], [powerup_spots[i][j], 0, 1]);
					powerup_using[i] = 1;
				}
			}
		}
	}
	
	if (do_garbage) {
		//dealing with garbage
		if (len(garbage_sending)) && (array_count(oInfo.placements, -1) >= 2) {
			//sending garbage
			if (trash_target == noone) {
				garbage_recipient = find_green_victim();
			} else {
				garbage_recipient = trash_target;
			}
			
			if (garbage_recipient != -1) {
				with (garbage_recipient) {
					array_push(garbage_recieving, [other.garbage_sending, 100, other.colour]);
				}
			}
		}
	}
	
	update_hover_y();
}


function insert_lines(sender, victim, lines) { //lines is list of indexes
	//insertion
	var insertion_lines = [];
	for (var i = 0; i < len(lines); i++) {
		array_push(insertion_lines, sender.grid[lines[i]]);
		//grid
		array_delete(victim.grid, 0, 1);
		array_insert(victim.grid, oInfo.grid_h-1, sender.grid[lines[i]]);
		//coloured grid
		array_delete(victim.coloured_grid, 0, 1);
		array_insert(victim.coloured_grid, oInfo.grid_h-1, sender.coloured_grid[lines[i]]);
	}
	
	victim.height = min(victim.height+6, oInfo.grid_h+oInfo.height_drop_map[victim.piece, victim.rotation]);
	
	sender.clear_lines(array_range(powerup_y, powerup_y+red_lines), false, false, false);
	
	sender.redraw_grid_surface();
	victim.redraw_grid_surface();
	sender.update_hover_y();
	
	var heights = find_space_heights(insertion_lines); //it works!!!
	
	for (var i = 0; i < len(heights); i++) {
		for (var j = oInfo.grid_h-1-(6-heights[i]); j >= 0; j--) {
			if (j-heights[i] < 0) {
				victim.grid[j][i] = 0;
				victim.coloured_grid[j][i] = 0;
			} else {
				victim.grid[j][i] = victim.grid[j-heights[i]][i];
				victim.coloured_grid[j][i] = victim.coloured_grid[j-heights[i]][i];
			}
		}
	}
	
	victim.height_map = heights;
	victim.height_lifespan = 1;
	victim.height_guy = sender;
}


function place_piece() {
	//placing piece on grid
	var guy = piece_rotated(piece, rotation);
	var spot_shift = array_corner_find(guy, 0);
	past_grid = array_clone(grid);
	grid = array_combine_2d([grid, array_sign(array_trim(guy, 0), 2)], [[0, 0], [distance+spot_shift[0], oInfo.grid_h-height+spot_shift[1]]]);
	oInfo.refresh(); //this is so annoying
	coloured_grid = array_combine_2d([coloured_grid, array_multiply(array_sign(array_trim(guy, 0), 2), (piece+1), 2)], [[0, 0], [distance+spot_shift[0], oInfo.grid_h-height+spot_shift[1]]]);
	oInfo.refresh(); //this is so annoying
	pieces_placed++;
	past_coloured_grid = array_clone(coloured_grid);
	
	//add powerup to coloured grid
	if (powerup) {
		//finding spot to put guy
		var pos = [];
		for (var yy = 0; yy < 4; yy++) {
			for (var xx = 0; xx < 4; xx++) {
				if (piece_rotated(piece, rotation)[yy][xx] == powerup) {
					pos = [xx, yy];
				}
			}
		}
		coloured_grid[oInfo.grid_h-height+pos[1]][distance+pos[0]] = -(powerup_type+1);
	}
	
	//draw to grid surface
	surface_set_target(grid_surface);
	draw_piece_pos(piece, rotation, (distance)*oInfo.square_size, (oInfo.grid_h-height)*oInfo.square_size);
	surface_reset_target();
	
	if (is_dead()) {
		die();
	}
	
	else { //still alive -=-==-=-=-=--=-=-=-==-=-=-=-=--=-==-=-=-=--=-=-==-=--=-=-=-=-=-=-=-=-=-=-=-=-==-=-=--=-=:
		clear_lines(-1, true);
		
		//variable stuff (cringe!?!)
		step = (step+1)%1000;
		piece = oInfo.random_pieces[step];
		piece_next = oInfo.random_pieces[(step+1)%1000];
		rotation = oInfo.random_rotations[step];
		
		if (oInfo.player_amount > 1) {
			if (len(powerup_in_da_bank)) {
				powerup = powerup_in_da_bank[0][0];
				powerup_type = powerup_in_da_bank[0][1];
				array_delete(powerup_in_da_bank, 0, 1);
			} else {
				powerup = 0;
			}
		}
	
		height = oInfo.grid_h + oInfo.height_drop_map[piece, rotation];
		height_wait = 0;
		slam_break = 4;
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


function remove_powerups() {
	for (var i = 0; i < len(coloured_grid); i++) {
		for (var j = -1; j >= -3; j--) { //each powerup
			coloured_grid[i] = array_replace(coloured_grid[i], j, 8); //replace with grey blocks
		}
	}
	redraw_grid_surface();
}


update_hover_y();



















