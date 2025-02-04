//white lines
if (time_left) {
	if (between(time_left, 13, 20)) || (between(time_left, 1, 6)) {
		rows = player.lines_removed;
		visibility = 1;
	}
	time_left--;
	
	if (time_left <= 0) && (oInfo.powerup_pause) {
		player.redraw_grid_surface();
	}
}

if (visibility > 0) {
	for (var i = 0; i < len(player.lines_removed); i++) {
		var spot = rows[i][0];
		draw_set_alpha(visibility);
		var spot1 = player.find_real_pos(player.shake_x, oInfo.square_size*(spot+1)+player.shake_y);
		var spot2 = player.find_real_pos(+oInfo.w+player.shake_x, oInfo.square_size*(spot)-1+player.shake_y);
		draw_rectangle_color_simple(spot1[0], spot1[1], spot2[0], spot2[1], c_white); 
		draw_set_alpha(1);
	}
}

visibility = max(0, visibility/1.2-0.01);


//powerup glow edges
if (edge_glow >= 0) {
	draw_edge_thingy(edge_lifespan, edge_glow);
}

for (var i = 0; i < len(edge_retracting); i++) {
	var col_id = edge_retracting[i][0];
	var el_lifespan = edge_retracting[i][1];
	var time_lefto = edge_retracting[i][2];
	draw_edge_thingy(el_lifespan, col_id, 30-time_lefto);
	
	edge_retracting[i][1]++;
	edge_retracting[i][2]--;
	if (edge_retracting[i][2] <= 0) {
		array_delete(edge_retracting, i, 1);
		i--;
	}
}


/*//powerup spots
for (var i = 0; i < len(to_glow); i++) {
	if (to_glow_message[i] == true) {
		for (var j = 0; j < len(to_glow[i]); j++) {
			var spotx = player.x+player.shake_x + (to_glow[i][j][0][0]+0.5)*oInfo.square_size;
			var spoty = player.y+player.shake_y + (to_glow[i][j][0][1]+0.5)*oInfo.square_size;
			var size = oInfo.square_size;
			var alpha = to_glow[i][j][2];
			draw_set_alpha(alpha);
			draw_center_rectangle_color_simple(spotx, spoty, size, size, oInfo.powerup_colours[i]);
			draw_set_alpha(1);
		}
	}
}*/


//red stuff
if (player.powerup_triggering == 0) {
	var raw_time = (60*16-1)-player.powerup_lifespan;
	var time = floor(max(raw_time/60, 0));
	var guy = player.player_from_powerup_x();
	var cool_x = player.real_powerup_x;
	var cool_y = player.real_powerup_y;
	var cool_y2 = cool_y+player.red_lines*oInfo.square_size;
	
	if (player.red_selected) {
		var blend1 = c_white;
		var blend2 = c_white;
	} else {
		if (raw_time > 0) {
			var blend1 = c_white;
		} else {
			var blend1 = make_color_hsv(255, max(0, 255+raw_time*2), 255);
		}
		if (raw_time < 5*60) {
			var blend2 = make_color_hsv(255, max(0, 255+((raw_time+60)%60-60)*2), 255)
		} else {
			var blend2 = c_white;
		}
	}
	
	//targeting stuff
	//mess
	var wane = sin(degtorad(player.powerup_lifespan*3))*5+15 + room_width*(1-ease_out(player.powerup_lifespan/60, 6)) + room_width*ease_in((player.red_selected + player.red_given_up)/60, 6);
	var wane2 = sin(degtorad(player.powerup_lifespan*5))*3+5 + room_width*(1-ease_out(player.powerup_lifespan/60, 6)) + room_width*ease_in((player.red_selected + player.red_given_up)/60, 6);
	
	//own area choosing
	draw_sprite_ext(sCorner, 0, player.x-wane2, cool_y-wane2, 0.7, 0.7, 0, blend1, 1);
	draw_sprite_ext(sCorner, 0, player.x+oInfo.w+wane2, cool_y-wane2, -0.7, 0.7, 0, blend1, 1);
	draw_sprite_ext(sCorner, 0, player.x+oInfo.w+wane2, cool_y2+wane2, -0.7, -0.7, 0, blend1, 1);
	draw_sprite_ext(sCorner, 0, player.x-wane2, cool_y2+wane2, 0.7, -0.7, 0, blend1, 1);
	
	if (player.controls == "keyboard") {
		draw_sprite_ext(sButtons, 2, player.x+oInfo.w-30+wane2, cool_y-55-wane2, 1, 1, 0, blend1, 1);
		draw_sprite_ext(sButtons, 3, player.x+30-wane2, cool_y-55-wane2, 1, 1, 0, blend1, 1);
	} else {
		if (player.powerup_lifespan%50 < 25) {
			var index = 4;
		} else {
			if (player.powerup_lifespan%100 < 50) {
				var index = 5;
			} else {
				var index = 6;
			}
		}
		draw_sprite_ext(sButtons, index, player.x+oInfo.w-30+wane2, cool_y-55-wane2, 1, 1, 0, blend1, 1);
	}
	
	//player target
	draw_sprite_ext(sCorner, 0, cool_x-wane, guy.y-wane, 1, 1, 0, blend1, 1);
	draw_sprite_ext(sCorner, 0, cool_x+oInfo.w+wane, guy.y-wane, -1, 1, 0, blend1, 1);
	draw_sprite_ext(sCorner, 0, cool_x+oInfo.w+wane, guy.y+oInfo.h+wane, -1, -1, 0, blend1, 1);
	draw_sprite_ext(sCorner, 0, cool_x-wane, guy.y+oInfo.h+wane, 1, -1, 0, blend1, 1);
	
	draw_txt_display_ext(cool_x+40-wane, guy.y-55-wane, string(abs(time)), 1, 1, 0, blend2, 1);
	draw_sprite_ext(sButtons, (player.controls == "keyboard"), cool_x+oInfo.w-40+wane, guy.y-55-wane, 1, 1, 0, blend1, 1);
	
	
	//flash stuff
	if (player.red_selected > 0) {
		var guy = player.player_from_powerup_x();
		
		var spot1 = player.find_real_pos(0, player.powerup_y*oInfo.square_size);
		var spot2 = player.find_real_pos(oInfo.w, (player.powerup_y + player.red_lines)*oInfo.square_size);
		var spot3 = guy.find_real_pos(0, oInfo.h-player.red_lines*oInfo.square_size);
		var spot4 = guy.find_real_pos(oInfo.w, oInfo.h);
		
		var xx = spot1[0];
		var yy = spot1[1];
		var xx2 = spot2[0];
		var yy2 = spot2[1];
		
		var xx3 = spot3[0];
		var yy3 = spot3[1];
		var xx4 = spot4[0];
		var yy4 = spot4[1];
		
		var alpha = ease_in((60-player.red_selected)/40, 3);
		var alpha2 = ease_in((20-player.red_selected)/5, 3);
		var angle = point_direction(xx, yy, xx2, yy2);
		
		var m = 4;
		var pw = [];
		for (var i = 0; i < 10; i++) {
			array_push(pw, [random_range(-m, m), random_range(-m, m)]);
		}
		
		if (player.red_selected > 2) {
			draw_set_alpha(alpha);
			//first
			draw_triangle_color_simple(xx+pw[0][0], yy+pw[0][1], xx2+pw[1][0], yy+pw[1][1], xx2+pw[2][0], yy2+pw[2][1], c_white);
			draw_triangle_color_simple(xx+pw[0][0], yy+pw[0][1], xx+pw[3][0], yy2+pw[3][1], xx2+pw[2][0], yy2+pw[2][1], c_white);
			//second
			draw_triangle_color_simple(xx3+pw[4][0], yy3+pw[4][1], xx4+pw[5][0], yy3+pw[5][1], xx4+pw[6][0], yy4+pw[6][1], c_white);
			draw_triangle_color_simple(xx3+pw[4][0], yy3+pw[4][1], xx3+pw[7][0], yy4+pw[7][1], xx4+pw[6][0], yy4+pw[6][1], c_white);
		
			draw_set_alpha(alpha2);
			//line
			draw_line_width_color(avg([xx, xx2])+pw[8][0], avg([yy, yy2])+pw[8][1], avg([xx3, xx4])+pw[9][0], avg([yy3, yy4])+pw[9][1], 15, c_white, c_white);
			var shift = 15 + irandom_range(3, 8);
			for (var i = 0; i < 3; i++) {
				var amoun = irandom_range(3-i, 8-i*3);
				shift += amoun + irandom_range(3, 8);
				var s = shift/cos(degtorad(angle));
				draw_line_width_color(avg([xx, xx2])+pw[8][0], avg([yy, yy2])+pw[8][1]-s, avg([xx3, xx4])+pw[9][0], avg([yy3, yy4])+pw[9][1]-s, 50, c_white, c_white);
				draw_line_width_color(avg([xx, xx2])+pw[8][0], avg([yy, yy2])+pw[8][1]+s, avg([xx3, xx4])+pw[9][0], avg([yy3, yy4])+pw[9][1]+s, 50, c_white, c_white);
				shift += amoun;
			}
		
			draw_set_alpha(1);
		}
	}
}


//blue stuff
if (blue_lifespan > 30) {
	var l = blue_lifespan-30;
	var amount = player.blue_lines;
	var spot = player.find_real_pos(0, 0);
	var w = power(l, 1.5)/50;
	// p1  p2
	//       
	// p4  p3
	var p1 = player.find_real_pos(0, oInfo.h-amount*oInfo.square_size);
	var p2 = player.find_real_pos(oInfo.w, oInfo.h-amount*oInfo.square_size);
	var p3 = player.find_real_pos(oInfo.w, oInfo.h);
	var p4 = player.find_real_pos(0, oInfo.h);
	var all_p = [p1, p2, p3, p4];
	
	if (l < 100) { //charge up
		//triangl;es
		var cool_l = floor(l/(6-l/25));
		var t1 = all_p[(cool_l)%4];
		var t2 = all_p[(cool_l+1)%4];
		var temp1 = all_p[(cool_l+1)%4];
		var temp2 = all_p[(cool_l+2)%4];
		var t3 = array_lerp(temp1, temp2, w/max(abs(temp1[0]-temp2[0]), abs(temp1[1]-temp2[1])));
		// t1                    t2
		//
		//                       t3
		draw_triangle_color_simple(t1[0], t1[1], t2[0], t2[1], t3[0], t3[1], c_white);
		
		//rectangle
		draw_set_alpha(l/160 * map_value(sin(l*1.5), -1, 1, 0, 1));
		draw_rectangle_color_simple(p1[0], p1[1], p3[0], p3[1], c_white);
		draw_set_alpha(1);
	} else { //kerblooey
		draw_set_alpha(ease_in((165-l)/40, 3));
		draw_rectangle_color_simple(p1[0], p1[1], p3[0], p3[1], c_white);
		draw_set_alpha(1);
	}
}
