yvel += oInfo.grv;

//Horizontal Collision
if (place_meeting(x+xvel, y, oWall)) || (place_meeting(x+xvel, y, oPlayer2)) {
	while (!place_meeting(x+sign(xvel), y, oWall)) && (!place_meeting(x+sign(xvel), y, oPlayer2)) {
		x += sign(xvel);
	}
	xvel = -xvel*0.95;
}

//Vertical Collision
if (place_meeting(x, y+yvel, oFloor)) || (place_meeting(x, y+yvel, oPlayer2)) {
	while (!place_meeting(x, y+sign(yvel), oFloor)) && (!place_meeting(x, y+sign(yvel), oPlayer2)) {
		y += sign(yvel);
	}
	yvel = -yvel*0.8;
	xvel = xvel*0.95;
}

x += xvel;
y += yvel;
angle -= xvel/3;

//move stuff ====================================================
sequence_cooldown--;

if (oInfo.fighting) {
	if (!sequence_cooldown) {
		oBackground.txt_left += string_char_at(oInfo.sequence1, sequence_spot+1);
		
		if (string_char_at(oInfo.sequence1, sequence_spot+1) == "1") { ////////////111111111111111111111
			sfx(sfxBlow, 800, false);
			xvel = cos(degtorad(angle+90))*75;
			yvel = -sin(degtorad(angle+90))*75;
			with instance_create_layer(x, y, "Visuals", oArrow) {
				image_angle = other.angle-90;
			}
		
		} else if (string_char_at(oInfo.sequence1, sequence_spot+1) == "2") { ///////22222222222222222222222222
			sfx(sfxZap, 800, false);
			with (oFakePlayer1) {
				shooting = 50;
				x = other.x;
				y = other.y;
			}
		
		} else if (string_char_at(oInfo.sequence1, sequence_spot+1) == "3") { //3.
			sfx(sfxShield, 800, false);
			with (oFakePlayer1) {
				protecting = 50;
			}
		}
	
		sequence_cooldown = round(120/oInfo.spd);
		sequence_spot++;
	
		if (sequence_spot == len(oInfo.sequence1)) {
			sequence_spot = 0;
		}
	}
} else {
	sequence_cooldown += 2;
}

draw_sprite_ext(sRock, 0, x, y, 1, 1, angle, merge_colour(oInfo.colour1, c_red, hurt/10), 1);

if (hurt == 10) {
	if (oInfo.health1 > 0) {
		sfx(sfxHurt, 998, false, 1, 0, 0.8);
	} else {
		sfx(sfxRock1, 10102091, false);
		sfx(sfxRock2, 10102091, false);
		sfx(sfxBoom, 789132789123, false, 1.2, 1.3);
		oInfo.fighting = false;
		oInfo.countdown = 300;
		oInfo.winner = "right";
		var force = point_distance(0, 0, xvel, yvel);
		var angl = point_distance(0, 0, xvel, -yvel);
		for (var i = 0; i < 5; i++) {
			with instance_create_layer(x, y, "Rocks", oRockShard) {
				image_index = i;
				image_angle = other.image_angle;
				image_blend = oInfo.colour1;
				xvel = lengthdir_x(force+random_range(-4, 4), angl+random_range(-10, 10));
				yvel = lengthdir_y(force+random_range(-4, 4), angl+random_range(-10, 10));
			}
		}
		instance_destroy();
	}
}

if (hurt) {
	hurt--;
}