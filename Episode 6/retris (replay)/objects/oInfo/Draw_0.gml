if (time_since_end == 460) {
	//defining everything
	reals = array_create_ext(3, function() { return []; }); //the actual numbers to be dispayed when maxed
	times_limit = []; //total time for each number to display
	times_thus = []; //time passed thus far
	for (var i = 0; i < 3; i++) {
		var temp1 = [];
		var temp2 = [];
		for (var j = 0; j < player_amount; j++) {
			array_push(temp1, 0);
			array_push(temp2, 0);
		}
		array_push(times_limit, temp1);
		array_push(times_thus, temp2);
	}
	
	//setting all actual scores in array governed by big guy
	for (var i = 0; i < player_amount; i++) {
		array_push(reals[0], players[i].time_alive);
		array_push(reals[1], players[i].pieces_placed);
		array_push(reals[2], players[i].lines_total);
	}
	
	//setting everything
	for (var i = 0; i < len(players); i++) {
		var player_stuff = [players[i].time_alive, players[i].pieces_placed, players[i].lines_total];
		for (var j = 0; j < 3; j++) {
			var maximum = array_max(reals[j]);
			if (j == 0) {
				var minimum = floor(player_stuff[j]/30);
			} else {
				var minimum = floor(player_stuff[j]*2);
			}
			times_limit[j][i] = min(minimum, ceil(player_stuff[j] / maximum * time_for_score_max))+1; //+1 for those 0 achievers
		}
	}
}



if (time_since_end >= 460) {
	var positionss = return_position(player_amount);
	var spots = [-225+550, 97+550, 423+550];
	
	for (var i = 0; i < player_amount; i++) {
		var n = max(0, (time_since_end-460-i*5)/60);
		var ease = ease_out(clamp(n, 0, 1)) * (2-ease_out(clamp(n/1.4, 0, 1)));
		draw_sprite(sEndPopup, 0, positionss[i], -800+1350*ease);
		//add numbers here using sDigits
		for (var j = 0; j < 3; j++) {
			if (times_thus[j][i] != 0) {
				if (times_thus[j][i] > times_limit[j][i]) { //reached maximum
					var display = ceil(reals[j][i]);
				} else { //still counting up
					var display = ceil(times_thus[j][i] / times_limit[j][i] * reals[j][i]);
				}
				if (j == 0) {
					display = frames_to_time(display, 60);
				}
				draw_txt_display(positionss[i], spots[j], display);
			}
		}
	}
}










































