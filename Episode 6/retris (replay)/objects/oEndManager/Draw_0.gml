if (lifespan < start) { //bars
	for (var i = 9; i >= 0; i--) {
		var dist = 180-lifespan+i*(20+i*2.66667);
		if (between(dist, 1, 100)) {
			var col = make_colour_hsv(0, 40, min(ease_in(map_value_clamp(dist, 50, 10, 0, 1), 3)*15, 10) * map_value_clamp(lifespan, 80, 300, 0.2, 1));
			var xpos = map_value(i%2, 0, 1, -100, 100);
			var edge = map_value(i%2, 0, 1, 0, room_width);
			var real_pos = xpos/dist * 100 + room_width/2;
			draw_rectangle_color_simple(real_pos, 0, edge, room_height, col);
		}
	}
}

var rand_x = perlin_noise(lifespan/4, 99.221);
var rand_y = perlin_noise(lifespan/8, 11.482);

if (lifespan >= start) && (selected <= talk_points[6][0] + talk_points[6][1]) { //shlurke himself
	if (selected) {
		var dist = ease_in(map_value_clamp(selected, 400, 400+180, 0, 1), 4)*150+40;
		var alpha = ease_in_out(map_value_clamp(selected, 400, 400+180, 1, 0), 4);
		var scale = 1/dist * 15;
	} else {
		var dist = ease_in(map_value_clamp(lifespan, start, start+180, 1, 0), 4)*150+40;
		var alpha = ease_in_out(map_value_clamp(lifespan, start, start+180, 0, 1), 4);
		var scale = 1/dist * 15;
	}
	
	//the shlurkinator
	draw_sprite_ext(sShlurkle, floor(lifespan/2)%40, room_width/2, room_height/2, scale, scale, 0, -1, alpha);
	
	//words
	for (var i = 0; i < 5; i++) {
		var a = talk_points[i][0];
		var b = talk_points[i][1];
		
		if (between(lifespan, start+a, start+a+b)) {
			var timer = lifespan-(start+a); //to 250
		
			var in = ease_out(map_value_clamp(timer, 0, 60, 0, 1)) * ease_out(map_value_clamp(timer, b-70, b, 1, 0));
			var yy = 950 + (1-in)*60;
			var col_id = chosen_guy[0];
			
			if (i == 0) {
				var str = "Hello, " + string_capitalise(colour_names[col_id]) + ".";
			} else if (i == 1) {
				var str = "Congratulations on your victory.";
			} else if (i == 2) {
				var str = "However, to return to the competition...";
			} else if (i == 3) {
				var str = "You must replace someone.";
			} else if (i == 4) {
				var str = "The choice is yours.";
			}
		
			draw_border_text(room_width/2+rand_x, yy+rand_y, str, -1, 999999, 1, 1, 6, 0, colours[5][2], colours[5][3], in, true);
		}
	}
	
	
	//final words
	if (selected) {
		var a = talk_points[6][0];
		var b = talk_points[6][1];
		
		if (between(selected, a, a+b)) {
			var timer = selected-a; //to 250
		
			var in = ease_out(map_value_clamp(timer, 0, 60, 0, 1)) * ease_out(map_value_clamp(timer, b-70, b, 1, 0));
			var yy = 950 + (1-in)*60;
			var col_id = chosen_guy[0];
			
			var str = "Well chosen."
		
			draw_border_text(room_width/2+rand_x, yy+rand_y, str, -1, 999999, 1, 1, 6, 0, colours[5][2], colours[5][3], in, true);
		}
	}
	
	//choice
	if (lifespan >= talk_points[5]+start) {
		for (var i = 0; i < 4; i++) {
			var timer = lifespan-talk_points[5]-start;
			var in = ease_out(map_value_clamp(timer-i*30, 0, 100, 0, 1), 3);
			var out = ease_in(map_value_clamp(selected-i*30, 100, 200, 0, 1), 3);
			var yy = (1-in+out)*500;
			
			var w = da_width; //width
			var h = da_height;
			var s = 50; //spacing
			var xx = room_width/2 + (w+s)*(-1.5 + i);
			
			var distance_yoself = power(abs(i-cursor_x), 0.3)*sign(i-cursor_x) * ease_out(map_value_clamp(selected, 0, 30, 0, 1), 8) * 150;
			
			var expand = ease_out(clamp(1 - abs(i-real_cursor_x), 0, 1));
		
			var x1 = xx-w/2 - expand*expansion + distance_yoself;
			var y1 = 1150-h/2+yy - expand*expansion;
			var x2 = xx+w/2 + expand*expansion + distance_yoself;
			var y2 = 1150+h/2+yy + expand*expansion;
			var w2 = 10;
			
			if !(selected) || (cursor_x != i) { //unharmed
				var xref = lifespan*1.6 % 400;
				var yref = lifespan*1.1 % 400;
			
				if (cursor_x == i) {
					var index = 4;
					var col1 = colours[6][0];
					var col2 = colours[6][1];
				} else {
					var index = i;
					var col1 = alive_colours[i][0];
					var col2 = alive_colours[i][1];
				}
		
				draw_rectangle_color_simple(x1+rand_x, y1+rand_y, x2+rand_x, y2+rand_y, col2);
				draw_sprite_general(sTiles, index, xref, yref, (x2-x1-w2*2)*2, (y2-y1-w2*2)*2, x1+w2+rand_x, y1+w2+rand_y, 0.5, 0.5, 0, c_white, c_white, c_white, c_white, 1);
				draw_border_text(avg([x1, x2])+rand_x, avg([y1, y2])+rand_y, string_capitalise(alive_colour_names[i]), -1, 999999, 0.7+expand*0.05, 0.7+expand*0.05, 6, 0, col1, col2, 1, true);
			}
			
			else { //esploded
				var split = 50;
				var cool_shake = shake+1;
				
				var x1 = xx-w/2 - expansion;
				var y1 = 1150-h/2 - expansion;
				
				var out = ease_in(map_value_clamp(selected-cursor_x*30, 100, 200, 0, 1), 3);
				var yy = out * 500;
				
				draw_surface(split_surface1, x1+random_range(-cool_shake, cool_shake)-split + rand_x, y1+random_range(-cool_shake, cool_shake)+yy + rand_y);
				draw_surface(split_surface2, x1+random_range(-cool_shake, cool_shake)+split + rand_x, y1+random_range(-cool_shake, cool_shake)+yy + rand_y);
			}
		}
	}
	
	
	draw_sprite_ext(sFade, 0, room_width/2+random_range(-30, 30), room_height/2+random_range(-30, 30), 1, 1, 0, -1, 1);
	
	
	if (between(selected, 1, 4)) {
		var w = da_width; //width
		var h = da_height;
		var s = 50; //spacing
		var xx = room_width/2 + (w+s)*(-1.5 + cursor_x);
		
		var split = 50;
		
		var x1 = xx-w/2 - expansion;
		var y1 = 1150-h/2 - expansion;
		var x2 = xx+w/2 + expansion;
		var y2 = 1150+h/2 + expansion;
		
		if (selected <= 2) {
			draw_rectangle_color_simple(0, 0, room_width, room_height, c_black);
		}
		
		draw_shape_blast(x1-split, y1, avg([x1, x2])+30-split, y1, avg([x1, x2])-30-split, y2, x1-split, y2, c_white, false, 1, 2);
		draw_shape_blast(avg([x1, x2])+30+split, y1, x2+split, y1, x2+split, y2, avg([x1, x2])-30+split, y2, c_white, false, 1, 2);
		draw_blast(avg([x1, x2]), avg([y1, y2]));
	}
}

if (between(selected, 750, 1000)) {
	draw_set_alpha(clamp((selected-750)/20, 0, 1) * clamp((1000-selected)/20, 0, 1));
	draw_sprite(sMessage, 0, room_width/2, room_height/2);
	draw_set_alpha(1);
}











