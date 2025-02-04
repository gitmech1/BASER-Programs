for (var i = 0; i < len(to_glow); i++) {
	if (to_glow_message[i] == true) {
		for (var j = 0; j < len(to_glow[i]); j++) {
			//frame control
			if (to_glow[i][j][1]%30 < 15) {
				to_glow[i][j][2] = 1; //full brightness
			} else {
				to_glow[i][j][2] = max(to_glow[i][j][2]-0.1, 0); //wane
			}
			
			to_glow[i][j][1]++;
			
			//death
			if (to_glow[i][j][1] >= 90) && (to_glow[i][j][2] <= 0) {
				array_delete(to_glow[i], j, 1);
				to_glow_message[i] = false; //might need to separate counter into colours, not square if this doesnt work
				j--; //broooioiioiooioinoigonigoinogingggnggngbggg aajajajghgjhagaaaaaaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ... h
			}
		}
	}
}


if (edge_glow >= 0) {
	edge_lifespan += 1;
}


if (edge_glow == 2) || (blue_lifespan > 0) {
	blue_lifespan++;
}