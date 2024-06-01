if (oInfo.fighting) {
	if (shooting) {
		preshoot = 0;
		for (var i = 0; i < 4; i++) {
			var distance = 1;
			while !(collision_point(x+lengthdir_x(distance, image_angle+i*90), y+lengthdir_y(distance, image_angle+i*90), oFloor, false, false)) &&
			!(collision_point(x+lengthdir_x(distance,image_angle+i*90), y+lengthdir_y(distance, image_angle+i*90), oWall, false, false)) && (distance < -15*shooting*(shooting-50)) {
				distance += irandom_range(2, 8);
			}
			draw_sprite_ext(sLazerMiddle, round(oPlayer2.lifespan/2)%2, x, y, distance/256, 1,image_angle+i*90, -1, 1);
			draw_sprite_ext(sLazer, round(oPlayer2.lifespan/2)%2, x, y, distance/256, 1,image_angle+i*90, oInfo.colour2, 1);
			draw_sprite_ext(sLazerMiddleEnd, 0, x+lengthdir_x(distance, image_angle+i*90), y+lengthdir_y(distance, image_angle+i*90), 1, 1, oPlayer2.lifespan, -1, 1);
			draw_sprite_ext(sLazerEnd, 0, x+lengthdir_x(distance, image_angle+i*90), y+lengthdir_y(distance, image_angle+i*90), 1, 1, oPlayer2.lifespan, oInfo.colour2, 1);
		}
		draw_sprite_ext(sLazerMiddleEnd, 0, x, y, 1, 1, oPlayer2.lifespan, -1, 1);
		draw_sprite_ext(sLazerEnd, 0, x, y, 1, 1, oPlayer2.lifespan, oInfo.colour2, 1);
	
		if (check_in_triangle_box(oPlayer1, 60)) && !(oFakePlayer1.protecting) && (shooting > 5) {
			if !(oPlayer1.being_damaged) {
				oInfo.health1 -= oInfo.damage;
				oPlayer1.being_damaged = true;
				oPlayer1.hurt = 10;
			} else {
				oInfo.health1 -= oInfo.damage/2;
				if (oPlayer1.hurt <= 5) {
					oPlayer1.hurt = 10;
				}
			}
		} else {
			oPlayer1.being_damaged = false;
		}
	
		shooting--;
	
	} else {
		oPlayer1.being_damaged = false;
	}

	if (preshoot) {
		draw_sprite_ext(sLazerEnd, 0, x+oPlayer2.xvel, y+oPlayer2.yvel, preshoot/20, preshoot/20, 0, -1, 1);

	} else if (protecting) {
		var scale = min(1, -0.004*protecting*(protecting-50));
		draw_sprite_ext(sShield, 0, x+oPlayer2.xvel, y+oPlayer2.yvel, scale*3.5, scale*3.5, 0, -1, 1);
	
		protecting--;
	}
}