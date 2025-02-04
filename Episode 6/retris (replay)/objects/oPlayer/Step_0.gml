var past_pause = pause;
var past_dead = dead;

// - for recording
//all for smth_pressed()
var move_horizontal = 0; //positive is right
var move_down = 0; //never negative (canat go up)
var move_rotate = 0; //positive is clockwise
var move_slam = 0; //if slam was activated
var move_trash = 0; //if trash were chosed

if !(dead) {
	update_controls(controls);
}

if !(pause) && !(dead) && !(oInfo.check_paused(id)) {
	
	var moved = false; //see if movement made during step
	
	if (controls == "keyboard") || (controls == -1) { //kleyboatf / replay
		move_rotate = r_right-r_left;
		move_slam = slam;
		move_down = down_pressed;

		//moving left and right ====================
		//pressing
		if (hor != 0) && (!distance_wait) {
			if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance+hor, height) == false) { //checking to see if new pos collides with anyhting
				distance += hor;
				move_horizontal = hor;
				moved = true;
			} 
			if (hor_pressed != 0) || (past_hor!=hor) { //pressed for the first time
				distance_wait = 16;
			} else { //pressed for the first time
				distance_wait = 3;
			}
			past_hor = hor;
		} else {
		//releasing
			if (hor_released != 0) {
				distance_wait = 0;
			}
		}


		//going up and down ====================
		//pressing
		if (down) and (height_wait == 0) {
			if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height-1) == false) { //checking to see if new pos collides with anyhting
				height--;
				moved = true;
				move_down = 1;
			}
			height_wait = 4;
			time_before_drop = round(oInfo.time_before_drop);
		} else {
		//releasing
			if (down_released) {
				height_wait = 0;
			}
		}	
		
		
	
	} else if (controls >= 0) { //conmtroller
		update_controls(controls);
		
		move_rotate = r_right-r_left;
		move_slam = slam;
		
		//moving left and right ====================
		//pressing
		if (abs(hor) > oInfo.joystick_spot) && (!distance_wait) {
			if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance+sign(hor), height) == false) { //checking to see if new pos collides with anyhting
				distance += sign(hor);
				moved = true;
				move_horizontal = sign(hor);
			}
			if (abs(past_hor) > oInfo.joystick_spot) { //already at pace
				distance_wait = round(3/max(0.2, abs(hor)));
			} else { //last one
				distance_wait = 16;
			}
		} else {
			if (abs(hor) <= oInfo.joystick_spot) {
				distance_wait = 0;
			}
		}


		//going up and down ====================
		//pressing
		if (down > oInfo.joystick_spot) and (height_wait == 0) {
			if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height-1) == false) { //checking to see if new pos collides with anyhting
				height--;
				moved = true;
				move_down = 1;
			}
			height_wait = round(3/max(0.2, down));
			time_before_drop = round(oInfo.time_before_drop);
		}
	}
	
	
	//automatic falling ====================
	time_before_drop -= 1;
	if (time_before_drop <= 0) { //time to go down
		if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height-1) == false) { //checking to see if new pos collides with anyhting
			height--;
			moved = true;
		}
		time_before_drop = round(oInfo.time_before_drop);
	}


	//rotating =========================================================
	if (r_left) || (r_right) { //left
		var dir = r_right-r_left;
		var new_rot = (rotation+dir+4)%4;
		var result = calculate_rot_spot(new_rot);
		
		if (result != false) {
			distance += result[0];
			height += result[1];
			rotation = new_rot;
			moved = true;
		}
	} //hehehehehehe, i shortened this so much (used to be 7982387923498749872398747283478298798.3 lines long


	//slamming ======================================
	if (slam) && !(slam_break) {
		move_slam = 1;
		var start_height = height;
		while (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height-1) == false) {
			height--;
		}
		var end_height = height;
		
		var spot = find_real_pos(distance*oInfo.square_size, (oInfo.grid_h-height-(start_height-end_height))*oInfo.square_size);
		
		with (instance_create_layer(spot[0], spot[1], "Effects", oSlamBlur)) {
			height_diff = start_height-end_height;
			piece = other.piece;
			rotation = other.rotation;
			summoner = other.id;
			local_square_size = oInfo.square_size*other.size;
			surface = surface_create(local_square_size*4, local_square_size*4);
			render_piece();
		}
		shake = round((start_height-end_height+5)*2);
		if (irandom_range(0, 1)) {
			sfx(thud4, 100, false, 1, 0.14, random_range(0.96, 1.04));
		} else {
			sfx(thud5, 100, false, 1, 0, random_range(0.96, 1.04));
		}
		place_piece();
	} else {
		move_slam = 0;
	}
	
	
	//trash sending =======================================
	if (trash_selection > 0) && (oInfo.player_amount > 2) {
		if (trash_selection >= len(oInfo.return_alive_players())) { //invalid pick
			trash_target_shake = 10;
		}
		else { //valid pick
			var alive_players = oInfo.return_alive_players(true);
			array_find_and_kill(alive_players, id);
			
			trash_target_id = trash_selection - 1;
			trash_target = alive_players[trash_target_id];
			trash_target_true_id = trash_target.colour_id;
			//msg("Hello. It is I, " + string(id) + " and I have most recently selected my trash targeting to be located onto my dear friend '" + string(trash_target) + "'.");
			trash_target.add_shenaniganner(colour_id);
			
			move_trash = trash_selection;
		}
		trash_target_timer = 180;
	}


	//checking to place pieces ======================================================
	if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height-1) != false) && !(moved) {
		if !(check_just_layed) {
			check_just_layed = true;
			time_to_be_layed -= 5;
		}
		if (time_layed <= 0) { //getting placed
			place_piece();
		} else {
			time_layed--;
		}
	}
	else {
		time_layed = time_to_be_layed;
		check_just_layed = false;
	}
	
	if (moved) {
		update_hover_y();
	}
	
	past_hor = hor;
	
	
	//adding garbage (what an utter mess)
	if (len(garbage_recieving)) {
		//loop thru every garbage to add
		for (var i = 0; i < len(garbage_recieving); i++) {
			garbage_recieving[i][1]--; //timer go down
			//if timer hit 0
			if (garbage_recieving[i][1] == 0) {
				//adding garbage to bottom / moving from top
				var trash = find_trash_line(len(garbage_recieving[i][0]));
				for (var j = 0; j < len(trash); j++) {
					array_push(grid, trash[j]); //add new bit to bottom
					array_push(coloured_grid, array_multiply(trash[j], 8, 1)); //add new bit to bottom
					array_push(voided_garbage, [coloured_grid[i], 1]); //move slice to voided
				}
				array_delete(grid, 0, len(trash)); //delete all slices from top
				array_delete(coloured_grid, 0, len(trash)); //delete all slices from top
				//cleaning up
				shake = 20+len(trash)*8;
				height = min(height+len(trash), oInfo.grid_h + oInfo.height_drop_map[piece, rotation]);
				redraw_grid_surface();
				update_hover_y();
				array_delete(garbage_recieving, i, 1);
				i--;
			}
		}
	}
}


distance_wait = max(0, distance_wait-1);
height_wait = max(0, height_wait-1);
shake = max(0, shake/1.5-0.2);
shake_long = max(0, shake_long/1.2-0.2);
trash_target_shake = max(0, trash_target_shake/1.2-0.2);
slam_break = max(0, slam_break-1);
trash_target_timer = max(0, trash_target_timer-1);
size = lerp(size, desired_size, 0.12);

if (len(voided_garbage)) {
	for (var i = 0; i < len(voided_garbage); i++) {
		voided_garbage[i][1] = voided_garbage[i][1]*0.9-0.001;
		if (voided_garbage[i][1] <= 0) {
			array_delete(voided_garbage, i, 1);
			i--;
		}
	}
}

if (dead) { //da afterlife
	if (between(dead, 60, 100, true)) {
		shake = 30;
	}
	
	if (dead == 225) {
		sfx(oInfo.applauses[irandom_range(10, 11)], 100, false, 0.5);
	}
	
	if (dead == 230) {
		shake = 15;
		sfx(oInfo.punches[irandom_range(4, 5)], 1000, false, 1, 0.09);
		//rocks
		var crumbs = part_system_create(slam_rocks);
		part_system_position(crumbs, x+oInfo.w/2+shake_x, y+1120);
		part_system_layer(crumbs, "MoreEffects");
		//shards
		var shards = part_system_create(oInfo.shards[oInfo.colour_conversion[colour_id]]);
		part_system_position(shards, x+oInfo.w/2+shake_x-70, y+1120);
		part_system_layer(shards, "EvenMoreEffects");
	}
	
	if (dead == 280) && (array_find(oInfo.placements, id) >= 2) {
		//move self away
		add_move(0, 2400, 140, ease_in, 5.5);
		
		//finding those whom alive
		var cool_people = [];
		for (var i = 0; i < len(oInfo.players); i++) {
			if (oInfo.players[i].dead < 280) {
				array_push(cool_people, oInfo.players[i]);
			}
		}
		
		//changing they positions
		var positionss = oInfo.return_position(len(cool_people));		
		for (var i = 0; i < len(cool_people); i++) {
			var new_x = positionss[i] - cool_people[i].future_x -oInfo.w/2;
			cool_people[i].add_move(new_x, 0, 180, ease_in_out, 3);
		}
	}
	
	if (between(dead, 280, 430)) && (array_find(oInfo.placements, id) >= 2) {
		desired_size = 1 - 0.5*ease_in_out(map_value(dead, 280, 430, 0, 1));
	}
	
	dead++;
} else {
	time_alive++;
}


for (var i = 0; i < len(shenanigan_senders); i++) {
	if (between(shenanigan_senders[i][0], 20, shenanigan_time-1)) {
		var guy_colour_id = shenanigan_senders[i][1];
		var guy = noone;
		for (var j = 0; j < len(oInfo.players); j++) {
			if (oInfo.players[j].colour_id == guy_colour_id) {
				guy = oInfo.players[j];
			}
		}
		
		if (dead) || (guy.trash_target_true_id != colour_id) {
			shenanigan_senders[i][0] = 20;
		}
	}
	
	shenanigan_senders[i][0]--;
	if (shenanigan_senders[i][0] <= 0) {
		array_delete(shenanigan_senders, i, 1);
		i--;
	}
}


if (controls != "keyboard") {
	gamepad_set_vibration(controls, (shake+shake_long)/60, (shake+shake_long)/60);
}



//powerupping
powerup_step(); //got the if inside



//recording
if (oInfo.game_mode == "record") {
	if !(past_dead) {
		if !(array_equals(powerup_move_log, [0, 0, 0, 0])) {
			move_horizontal = powerup_move_log[0];
			move_down = powerup_move_log[1];
			move_rotate = powerup_move_log[2];
			move_slam = powerup_move_log[3];
		}
		
		if (move_horizontal != 0) {
			move_horizontal_list[len(move_horizontal_list)-1] *= move_horizontal;
			array_push(move_horizontal_list, 1);
		} else {
			if (len(move_horizontal_list)) {
				move_horizontal_list[len(move_horizontal_list)-1] += 1;
			}
		}
	
		if (move_down != 0) {
			move_down_list[len(move_down_list)-1] *= move_down;
			array_push(move_down_list, 1);
		} else {
			if (len(move_down_list)) {
				move_down_list[len(move_down_list)-1] += 1;
			}
		}
	
		if (move_rotate != 0) {
			move_rotate_list[len(move_rotate_list)-1] *= move_rotate;
			array_push(move_rotate_list, 1);
		} else {
			if (len(move_rotate_list)) {
				move_rotate_list[len(move_rotate_list)-1] += 1;
			}
		}
	
		if (move_slam != 0) {
			move_slam_list[len(move_slam_list)-1] *= move_slam;
			array_push(move_slam_list, 1);
		} else {
			if (len(move_slam_list)) {
				move_slam_list[len(move_slam_list)-1] += 1;
			}
		}
		
		if (move_trash != 0) {
			move_trash_list[len(move_trash_list)-1] = [move_trash_list[len(move_trash_list)-1], move_trash];
			array_push(move_trash_list, 1);
		} else {
			if (len(move_trash_list)) {
				move_trash_list[len(move_trash_list)-1] += 1;
			}
		}
	}
	
	if (dead) && !(past_dead) { //just died
		//finalise recording arrays
		array_delete(move_horizontal_list, -1, -1); //deletes final number
		array_delete(move_down_list, -1, -1); //deletes final number
		array_delete(move_rotate_list, -1, -1); //deletes final number
		array_delete(move_slam_list, -1, -1); //deletes final number
		array_delete(move_trash_list, -1, -1); //deletes final number
	}
}


if (ready_to_clear_lines) && !(pause) {
	clear_lines(-1, true, true, true);
	ready_to_clear_lines = false;
}


if (height_lifespan) {
	height_lifespan++;
}


if (pause) { //pause stuff
	pause--;
	if (pause == 0) {
		//redraw grid
		hover = true;
		redraw_grid_surface();
	}
}


//moving around da bord
x = xstart + perm_x_offset;
y = ystart + perm_y_offset;

for (var i = 0; i < len(moves); i++) {
	var pos = moves[i][0];
	var step = 1/moves[i][2];
	moves[i][1] += step;
	var lerpe = moves[i][1];
	var ease = moves[i][3];
	var factor = moves[i][4];
	
	x += pos[0] * ease(lerpe, factor);
	y += pos[1] * ease(lerpe, factor);
	
	if (lerpe >= 1) {
		perm_x_offset += pos[0];
		perm_y_offset += pos[1];
		array_delete(moves, i, 1);
		i--;
	}
}


lifespan++;


//size = map_value(sin(degtorad(lifespan*2+player_id*30)), -1, 1, 0.5, 1.5); ////////////////////////////////////////////////////////////////////////
depth = 450-size*40;






















