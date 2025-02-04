if (lifespan >= 60) && (lifespan <= (oInfo.h+50)/30+60) {
	
	if (lifespan == 60) { //first explosion
		var xguy = oInfo.pieces[piece][1][rotation];
		var yguy = oInfo.pieces[piece][2][rotation];
		var centre_x = x+(distance+(xguy[0]+xguy[1]/2))*oInfo.square_size;
		var centre_y = y+(oInfo.grid_h-height+(yguy[0]+yguy[1]/2))*oInfo.square_size;
	
		with (instance_create_layer(centre_x, centre_y, "MoreEffects", oExplosion)) {
			image_scale(10);
			sfx(normalexplosion1, 1, false, 1.3, 0.08);
		}
	}
	else {
		var xspot = x + (lifespan*93753)%oInfo.w;
		var yspot = y + (lifespan-60)*30;
		with (instance_create_layer(xspot, yspot, "MoreEffects", oExplosion)) {
			image_scale(random_range(3, 4));
			sfx(oInfo.explosions[irandom_range(0, 2)], 1, false, random_range(0.4, 0.8), 0.08, random_range(0.95, 1.05));
		}
	}
}

lifespan++;