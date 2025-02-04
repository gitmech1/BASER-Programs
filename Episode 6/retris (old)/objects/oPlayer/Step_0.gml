if !(pause) && !(dead) {
	
	var moved = false; //see if movement made during step
	
	if (controls == "keyboard") { //kleyboatf
		hor = keyboard_check(vk_right) - keyboard_check(vk_left);
		hor_pressed = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
		hor_released = keyboard_check_released(vk_right) - keyboard_check_released(vk_left);
		down = keyboard_check(vk_down);
		down_released = keyboard_check_released(vk_down);
		slam = keyboard_check_pressed(vk_space);
		r_left = 0; //keyboard_check_pressed(vk_up);
		r_right = keyboard_check_pressed(vk_up);

		//moving left and right ====================
		//pressing
		if (hor != 0) && (!distance_wait) {
			if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance+hor, height) == false) { //checking to see if new pos collides with anyhting
				distance += hor;
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
			}
			height_wait = 4;
			time_before_drop = round(oInfo.time_before_drop);
		} else {
		//releasing
			if (down_released) {
				height_wait = 0;
			}
		}	
		
		
	
	} else { //conmtroller
		hor = gamepad_axis_value(controls, gp_axislh);
		down = abs(gamepad_axis_value(controls, gp_axislv));
		slam = gamepad_button_check_pressed(controls, gp_face1) || gamepad_button_check_pressed(controls, gp_shoulderrb);
		r_left = gamepad_button_check_pressed(controls, gp_shoulderl);
		r_right = gamepad_button_check_pressed(controls, gp_shoulderr);
		
		//moving left and right ====================
		//pressing
		if (abs(hor) > 0.3) && (!distance_wait) {
			if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance+sign(hor), height) == false) { //checking to see if new pos collides with anyhting
				distance += sign(hor);
				moved = true;
			}
			if (abs(past_hor) > 0.3) { //already at pace
				distance_wait = round(3/max(0.2, abs(hor)));
			} else { //last one
				distance_wait = 16;
			}
		} else {
			if (abs(hor) <= 0.3) {
				distance_wait = 0;
			}
		}


		//going up and down ====================
		//pressing
		if (down > 0.3) and (height_wait == 0) {
			if (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height-1) == false) { //checking to see if new pos collides with anyhting
				height--;
				moved = true;
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
		var rot_result = check_piece_colliding(grid, piece_rotated(piece, new_rot), distance, height);
		if (rot_result == false) { //hots nothing (YAY)
			rotation = new_rot;
			moved = true;
		}
		else if (rot_result == "left wall") { //hits left wall
			//1 to right
			if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance+1, height) == false) {
				distance += 1;
				rotation = new_rot;
				moved = true;
			}
		}
		else if (rot_result == "right wall") { //hits right wall
			//1 to left
			if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance-1, height) == false) {
				distance -= 1;
				rotation = new_rot;
				moved = true;
			}
			//2 to left
			else if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance-2, height) == false) {
				distance -= 2;
				rotation = new_rot;
				moved = true;
			}
		}
		else if (rot_result == "floor") { //hits the floor
			//1 up
			if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance, height+1) == false) {
				height += 1;
				rotation = new_rot;
				moved = true;
			}
			//2 up
			else if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance, height+2) == false) {
				height += 2;
				rotation = new_rot;
				moved = true;
			}
		}
		else if (rot_result == "roof") { //raises the roof
			//1 down
			if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance, height-1) == false) {
				height -= 1;
				rotation = new_rot;
				moved = true;
			}
		}
		else if (rot_result == "guy") { //raises the roof
			//1 up
			if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance, height+1) == false) {
				height += 1;
				rotation = new_rot;
				moved = true;
			}
			//1 to left
			else if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance-1, height) == false) {
				distance -= 1;
				rotation = new_rot;
				moved = true;
			}
			//1 to right
			else if (check_piece_colliding(grid, piece_rotated(piece, new_rot), distance+1, height) == false) {
				distance += 1;
				rotation = new_rot;
				moved = true;
			}
		}
	}


	//slamming ======================================
	if (slam) && !(slam_break) {
		var start_height = height;
		slam_break = 12;
		while (check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height-1) == false) {
			height--;
		}
		var end_height = height;
	
		with (instance_create_layer(x+distance*oInfo.square_size, y+(oInfo.grid_h-height-(start_height-end_height))*oInfo.square_size, "Effects", oSlamBlur)) {
			height_diff = start_height-end_height;
			piece = other.piece;
			rotation = other.rotation;
			summoner = other.id;
			surface = surface_create(oInfo.square_size*4, oInfo.square_size*4);
			render_piece();
		}
		shake = round((start_height-end_height+5)*2);
		if (irandom_range(0, 1)) {
			sfx(thud4, 100, false, 1, 0.14, random_range(0.96, 1.04));
		} else {
			sfx(thud5, 100, false, 1, 0, random_range(0.96, 1.04));
		}
		place_piece();
	}


	//checking to place pieces
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
	
	
	//adding garbage
	if (len(garbage_recieving)) {
		//loop thru every garbage to add
		for (var i = 0; i < len(garbage_recieving); i++) {
			garbage_recieving[i][1]--; //timer go down
			//if timer hit 0
			if (garbage_recieving[i][1] == 0) {
				//adding garbage to bottom / moving from top
				var trash = garbage_recieving[i][0];
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
slam_break = max(0, slam_break-1);

if (len(voided_garbage)) {
	for (var i = 0; i < len(voided_garbage); i++) {
		voided_garbage[i][1] = voided_garbage[i][1]*0.9-0.001;
		if (voided_garbage[i][1] <= 0) {
			array_delete(voided_garbage, i, 1);
			i--;
		}
	}
}

if (pause) {
	pause--;
	if (pause == 0) {
		//redraw grid
		hover = true;
		redraw_grid_surface();
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
		var shards = part_system_create(oInfo.shards[colour_id]);
		part_system_position(shards, x+oInfo.w/2+shake_x-70, y+1120);
		part_system_layer(shards, "EvenMoreEffects");
	}
	
	dead++;
} else {
	time_alive++;
}


if (controls != "keyboard") {
	gamepad_set_vibration(controls, shake/60, shake/60);
}























