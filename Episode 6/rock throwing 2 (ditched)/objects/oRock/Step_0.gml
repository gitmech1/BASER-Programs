if (landed) {
	sxvel = lerp(sxvel, 0, 0.1);
	syvel = lerp(syvel, 2, 0.15);
	
	x -= sxvel;
	y += syvel;
} else if (physics) {
	yvel += 0.4;
	
	if (place_meeting(x-xvel, y+yvel, oWater)) {
		if (xvel < 8) || (point_direction(0, 0, xvel, -yvel) > 60) {
			//the landed stuf======================
			if (place_meeting(x, y, oWater)) { //make it aweoisne
				landed = true;
				sxvel = xvel;
				syvel = yvel;
				msg(yvel);
				audio_play_sound(sDrip, 999, false, 0.012*abs(yvel), 0, 0.8);
				oMonkey.end_timer = 1;
				with (instance_create_layer(x, 2100, "ramps", oFlag)) {
					oCamera.follow = id;
					var distance = min(200, max((19319-x)/94.5, 0));
					end_distance = string_format(distance, len(string(floor(distance))), 1) + " m";
				}
			}
			//end of landed stuff==================
		} else {
			audio_play_sound(sSmallDrip, 888, false, 0.3+0.12*logn(2, abs(yvel)), 0, 0.8+0.1*logn(2, abs(yvel)));
			yvel *= -0.7;
			xvel *= 0.9;
		}
	}
	if (place_meeting(x-xvel, y+yvel, oWall)) {
		xvel *= -0.2;
	}
	if (place_meeting(x-xvel, y+yvel, oRamp)) {
		var forc = point_distance(0, 0, xvel, yvel);
		var angl = point_direction(0, 0, -xvel, yvel);
		audio_play_sound(sWood, 888, false, 0.2+0.1*logn(2, abs(forc)));
		
		
		msg(angl);
		angl += 62.5;
		var new_angl = -angl-62.5;
		msg(new_angl);
		
		
		xvel = lengthdir_x(forc, new_angl);
		yvel = lengthdir_y(forc, new_angl);
	}
	var boosty = collision_point(x-xvel, y+yvel, oZoom, false, false);
	if (boosty != noone) {
		xvel -= cos(degtorad(boosty.image_angle))*boosty.power_amount;
		yvel -= sin(degtorad(boosty.image_angle))*boosty.power_amount;
	}
	//var bird = collision_point(x-xvel, y+yvel, oBird, false, false);
	//if (bird != noone) {
	//	with (bird) {
	//		hit = true;
	//	}
	//	xvel *= -0.3;
	//	//play sound here
	//}
	
	x -= xvel;
	y += yvel;
	image_angle += xvel;
}


//music
if (landed) {
	audio_group_set_gain(audiogroup1, 0, 200);
} else if (physics) {
	var volume = abs(xvel)/30-0.4;
	audio_group_set_gain(audiogroup1, volume, 200);
}