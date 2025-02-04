if !(speed_up_time) {
	
	if (player_amount >= 2) {
		time_before_drop = time_before_drop*0.99976+0.0011;
		//time_before_drop = max(time_before_drop-0.0025, 2);
	} else {
		time_before_drop = time_before_drop*0.9998+0.001;
	}
	
	if (player_amount > 1) {
		if (placements[1] != -1) {
			for (var i = 0; i < len(placements); i++) {
				if !(array_contains(placements, players[i])) {
					//players[i].placement = 1;
					speed_up_time = true;
					if (good_mode) {
						chosen_guy = [players[i].colour_id, players[i].controls];
					}
					//stopping powerups
					for (var i = 0; i < len(players); i++) {
						players[i].powerup_in_da_bank = [];
						players[i].powerup = 0;
						players[i].remove_powerups();
					}
				}
			}
		}
	}
} else {
	time_before_drop = time_before_drop*0.99+0.02;
}


//powerup distrubution
if (player_amount > 1) && (array_count(placements, -1) > 1) {
	p_count--;
	//if (p_count%20 == 0) {
		//msg(p_count);
	//}
	if (p_count <= 0) {
		//send to correct player
		var players_left = []; //list of all alive players
		for (var i = 0; i < len(players); i++) {
			if (players[i].dead == false) {
				array_push(players_left, players[i]);
			}
		}
		var lucky_player = players_left[random_p_players[p_step]%len(players_left)]; //the id
		array_push(lucky_player.powerup_in_da_bank, [random_p_spots[p_step], random_p[p_step]]);
		//msg("==============================================================================");
		//msg("SENT TO " + string(colour_names[lucky_player.colour_id]));
		//msg("==============================================================================");
		//update info
		p_step = (p_step+1)%1000;
		p_count = random_p_timings[p_step];
	}
}


//pausing for people with powerups
if (powerup_pause) {
	for (var i = 0; i < len(players); i++) {
		players[i].pause = 2;
	}
	volume_pause = volume_pause*0.98+0.002;
	oMusic.volume2 = volume_pause;
} else {
	volume_pause = lerp(volume_pause, 1, 0.1);
	oMusic.volume2 = volume_pause;
}


//everyone finished
if !(array_contains(placements, -1)) {
	time_since_end++;
	
	if !(len(scorings)) { //add to global display to 
		for (var i = 0; i< len(players); i++) {
			var guy = players[i];
			array_push(scorings, [guy.time_alive, guy.pieces_placed, guy.lines_total]);
		}
		
		//record everything
		if (game_mode == "record") {
			save_everything();
			get_save(true);
		}
	}
	
	if (time_since_end == 280) {
		//bring back everyone to original position
		var desired_y = room_height/2 - square_size*grid_h/2 + 125;
		
		for (var i = 0; i < len(players); i++) {
			var guy = players[i];
			with (guy) { //in the mind of a simple player
				//finish all current moves
				for (var j = len(moves)-1; j >= 0; j--) {
					perm_x_offset += moves[i][0][0];
					perm_y_offset += moves[i][0][1];
					array_delete(moves, i, 1);
				}
				
				//set u back
				if (array_find(oInfo.placements, id) >= 2) {
					x = xstart;
					perm_x_offset = 0;
					future_x = xstart
				}
				var desired_x = xstart;
				
				desired_size = 1;
				add_move(desired_x-x, desired_y-y, 180, ease_in_out, 5);
			}
		}
	}
}

if (time_since_end == 460) {
	oMusic.music(racearoundtheworld, 0, 0);
}


if (time_since_end >= 560) && !(time_since_end_end) {
	var noises_played = 1;
	var all_done = true;
	for (var i = 0; i < player_amount; i++) {
		var done = false;
		for (var j = 0; j < 3; j++) {
			if !(done) && (times_thus[j][i] < times_limit[j][i]+10) {
				times_thus[j][i] += 1;
				done = true;
				if (times_thus[j][i] < times_limit[j][i]) && (time_since_end%2) {
					sfx(scoretally, 2, false, 1/noises_played, 0.1);
					noises_played++;
				}
			}
		}
		
		if (times_thus[2][i] < times_limit[2][i]) {
			all_done = false;
		}
	}
	
	if (all_done) {
		time_since_end_end = 1;
	}
}

if (time_since_end_end) {
	time_since_end_end++;
	
	if (time_since_end_end == 200) {
		if (good_mode) && (game_mode != "replay") && !(array_equals(chosen_guy, [-1, -1])) {
			oMusic.music(flock, 180, 400);
		} else {
			oMusic.music(noone, 160);
		}
	}
	
	if (time_since_end_end == 300) && (good_mode) && (game_mode != "replay") && !(array_equals(chosen_guy, [-1, -1])) {
		instance_create_layer(0, 0, "Omnipotent", oEndManager);
		room_goto(ShlurkZone);
	}
}


lifespan++;


/*var choice = -1;
if (keyboard_check(ord("1"))) {
	var choice = 0;
} else if (keyboard_check(ord("2"))) {
	var choice = 1;
} else if (keyboard_check(ord("3"))) {
	var choice = 2;
} else if (keyboard_check(ord("4"))) {
	var choice = 3;
} else if (keyboard_check(ord("5"))) {
	var choice = 4;
}

if (choice != -1) {
	for (var i = 0; i < len(players); i++) {
		if (players[i].dead <= 0) {
			var mount = (i-choice+5)%5 + 400;
			players[i].depth = mount;
		}
	}
}*/

for (var i = 0; i < len(timings); i++) {
	if (lifespan == timings[i][1][0]) {
		for (var j = 0; j < len(players); j++) {
			if (players[j].dead <= 0) {
				if (array_contains(timings[i][0], players[j].player_id)) {
					players[j].desired_size = 1;
				} else {
					players[j].desired_size = 0.9;
				}
			}
		}
		oC.desired_x = room_width/2 + (avg(timings[i][0])-2)*250;
		oC.desired_zoom = 0.3;
	}
	if (lifespan == timings[i][1][1]) {
		for (var j = 0; j < len(players); j++) {
			if (players[j].dead <= 0) {
				players[j].desired_size = 1;
				oC.desired_x = room_width/2;
				oC.desired_zoom = 0.45;
			}
		}
	}
}














