//POWERUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUPS
if (powerup_triggering != -1) {
	//visual at start
	if (powerup_lifespan <= 90) { //starting bwow
		var slope = 4+powerup_lifespan/40;
		var easing = ease_out(powerup_lifespan/30, 3) * ease_out(3-powerup_lifespan/30, 3);
		var flash = floor((powerup_lifespan/5)%2);
		var scale = slope*easing*(powerup_lifespan/650+1);
		draw_sprite_ext(sGlow, 0, x+oInfo.w/2, y+oInfo.h/2, scale/3, scale/3, 0, oInfo.powerup_colours[powerup_triggering], 1);
		draw_sprite_ext(sGlow, 0, x+oInfo.w/2, y+oInfo.h/2, scale/2, scale/2, 0, oInfo.powerup_colours[powerup_triggering], 0.3);
		draw_sprite_ext(sEffect, powerup_triggering+3*(flash+1), x+oInfo.w/2, y+oInfo.h/2, scale, scale, 0, -1, 1);
		draw_sprite_ext(sEffect, powerup_triggering, x+oInfo.w/2, y+oInfo.h/2, slope*easing, slope*easing, 0, -1, 1);
	}
	
	//red, attack
	if (powerup_triggering == 0) {
		if (red_selected == 1) {
			draw_rectangle_color_simple(0, 0, room_width, room_height, c_white);
		}
		else if (between(red_selected, 2, 3)) {
			var guy = player_from_powerup_x();
			
			var xx = x;
			var yy = y+powerup_y*oInfo.square_size;
			var xx2 = xx + oInfo.w;
			var yy2 = yy + red_lines*oInfo.square_size;
			
			var xx3 = guy.x;
			var yy3 = guy.y+oInfo.h - red_lines*oInfo.square_size;
			var xx4 = xx3 + oInfo.w;
			var yy4 = guy.y+oInfo.h;
			
			draw_rectangle_color_simple(0, 0, room_width, room_height, c_black);
			//draw_set_alpha(0.2);
			glower_guy.draw_cube_blast(xx, yy, xx2, yy2, c_white, false);
			glower_guy.draw_cube_blast(xx3, yy3, xx4, yy4, c_white, false);
			//draw_set_alpha(1);
			glower_guy.draw_blast(avg([xx, xx2, xx3, xx4]), avg([yy, yy2, yy3, yy4]), c_white, 0.5);
			draw_line_edges(avg([xx, xx2]), avg([yy, yy2]), avg([xx3, xx4]), avg([yy3, yy4]), 100, c_white, c_white);
		}
	}
	
	//green, switch
	if (powerup_triggering == 1) {
		
	}
	
	//blue, boom
	if (powerup_triggering == 2) {
		if (between(powerup_lifespan, 130, 131)) {
			draw_rectangle_color_simple(0, 0, room_width, room_height, c_white);
		}
		
		else if (between(powerup_lifespan, 132, 134)) {
			var xx = x;
			var yy = y+oInfo.h-blue_lines*oInfo.square_size;
			var xx2 = xx + oInfo.w;
			var yy2 = yy + blue_lines*oInfo.square_size;
			
			if (powerup_lifespan < 134) {
				draw_rectangle_color_simple(0, 0, room_width, room_height, c_black);
			}
			
			glower_guy.draw_cube_blast(xx, yy, xx2, yy2);
		}
	}
	
}