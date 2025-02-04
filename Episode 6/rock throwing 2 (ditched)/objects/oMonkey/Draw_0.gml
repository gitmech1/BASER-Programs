if (start_timer == 0) {
	
	if (aiming >= 150) {
		if (aiming == 150) {
			image_index = 2;
		}
		
		draw_self();
		
		if (image_index >= 2) & (image_index < 3) {
			draw_sprite_ext(sRock, 0, x-16*1.5, y+33*1.5, 1, 1, 80, oInfo.rock_colour, 1);
		} else if (image_index >= 3) & (image_index < 4) {
			draw_sprite_ext(sRock, 0, x-45*1.5, y+25*1.5, 1, 1, 106, oInfo.rock_colour, 1);
		} else if (image_index >= 4) & (image_index < 5) {
			oRock.x = x-103*1.5;
			oRock.y = y+21*1.5;
			oRock.physics = true;
			oRock.xvel = cos(degtorad(oInfo.angle))*oInfo.force;
			oRock.yvel = -sin(degtorad(oInfo.angle))*oInfo.force;
			oRock.image_alpha = 1;
		}
		
		if (image_index >= 13) {
			image_speed = 0;
		} else {
			image_speed = 1;
		}
		
		aiming++;
		
	} else {
		image_index = 1;
		
		draw_sprite_ext(sRock, 0, x-32*1.5, y+66*1.5, 1, 1, 35, oInfo.rock_colour, 1);
		
		//arm
		var v = clamp(aiming, 0, 120)/120;
		var rotation = -(3*power(v,2)-2*power(v,3))*(oInfo.angle+60);
		draw_sprite_ext(sMonkeyArmBack, 0, x-77*1.5, y+33*1.5, -1.5, 1.5, rotation, -1, 1);
		draw_self();
		draw_sprite_ext(sMonkeyArmFront, 0, x-77*1.5, y+33*1.5, -1.5, 1.5, rotation, -1, 1);
		//lines
		for (var i = 0; i < round((-rotation-60)/4); i++;) {
			var distance = 240;
			var x1 = lengthdir_x(distance, 180-i*4) + x-77*1.5;
			var y1 = lengthdir_y(distance, 180-i*4) + y+33*1.5;
			var x2 = lengthdir_x(distance, 178-i*4) + x-77*1.5;
			var y2 = lengthdir_y(distance, 178-i*4) + y+33*1.5;
			draw_line_width_color(x1, y1, x2, y2, 4, #690000, #690000);
			draw_line_width_color(x1, y1, x2, y2, 3, #FF0808, #FF0808);
		}
		//arown
		draw_sprite_ext(sArrow, 0, x-77*1.5, y+33*1.5, min(20, aiming)/20, min(20, aiming)/20, rotation+60, -1, min(20, aiming)/20);
		//angle
		if (aiming >= 120) && (oInfo.precision != -1) {
			var text = string_format(oInfo.angle, len(string(floor(oInfo.angle))), oInfo.precision);
			if (oInfo.dots) {
				text += "...";
			}
		} else if (aiming >= 120) || ((frac(oInfo.angle) > 0) && (-rotation-60 >= floor(oInfo.angle))) {
			var text = string(-rotation-60);
		} else {
			var text = string(floor(-rotation-60));
		}
		var alpha = clamp(aiming-10, 0, 20)/20;
		draw_set_halign(fa_left);
		draw_border_text(x-55, y+25, text + "°", -1, 9999, 0.3, 0.3, 2, 0, #FF0808, #690000, alpha, true);
		
		aiming++;
	}
	
} else {
	start_timer--;
	draw_sprite_ext(sRock, 0, x-32*1.5, y+66*1.5, 1, 1, 35, oInfo.rock_colour, 1);
	draw_self();
}

if (end_timer) {
	end_timer++;
}