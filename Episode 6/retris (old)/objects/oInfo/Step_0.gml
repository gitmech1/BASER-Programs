if !(speed_up_time) {
	time_before_drop = time_before_drop*0.9998+0.001;
	
	if (player_amount > 1) {
		if (placements[1] != -1) {
			for (var i = 0; i < len(placements); i++) {
				if !(array_contains(placements, players[i])) {
					//players[i].placement = 1;
					speed_up_time = true;
					msg("SPEEDING UP");
				}
			}
		}
	}
} else {
	time_before_drop = time_before_drop*0.99+0.02;
}


if !(array_contains(placements, -1)) {
	time_since_end++;
	
	if !(len(scorings)) {
		for (var i = 0; i< len(players); i++) {
			var guy = players[i];
			array_push(scorings, [guy.time_alive, guy.pieces_placed, guy.lines_total]);
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
		oMusic.music(noone, 80);
	}
}

if (time_since_end_end == 300) {
	sfx(characterunlock, 1000023498237823789234798872378923487932, false);
}















