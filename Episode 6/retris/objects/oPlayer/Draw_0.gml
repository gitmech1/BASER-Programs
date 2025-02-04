if (shake+shake_long > 0) {
	shake_x = random_range(-shake-shake_long, shake+shake_long);
	shake_y = random_range(-shake-shake_long, shake+shake_long);
} else {
	shake_x = 0;
	shake_y = 0;
}

if (pointer_player != noone) {
	var the_height = lerp(height, new_height, ease_in_out(map_value(pointer_player.powerup_lifespan, 80, 180, 0, 1), 3))
} else {
	var the_height = height;
}


draw_sprite(sBorder, 1+colour_id*3, x+shake_x, y+shake_y); //back of border

//drawing voided stuff
if (len(voided_garbage)) {
	gpu_set_blendmode(bm_add);
	for (var i = 0; i < len(voided_garbage); i++) {
		var transparency = voided_garbage[i][1];
		for (var j = 0; j < len(voided_garbage[i][0]); j++) {
			var guy = voided_garbage[i][0][j];
			if (guy != 0) {
				draw_sprite_ext(sBrick, guy-1, x+oInfo.square_size*j, y-(len(voided_garbage)-i)*oInfo.square_size, 1, 1, 0, -1, transparency);
			}
		}
	}
	gpu_set_blendmode(bm_normal);
}

if (len(height_map)) { //boing down
	for (var i = 0; i < oInfo.grid_w; i++) {
		var guy = height_guy;
		var el_height = height_map[i];
		var bottom_height = (guy.red_lines-el_height)*oInfo.square_size;
		var xx = i*oInfo.square_size;
		if (el_height > 0) {
			var yy = (1-ease_bounce(max((height_lifespan-i)-5, 0), 0.007/el_height, 0, 0.4, 0.005)) * el_height*oInfo.square_size;
		} else {
			var yy = 0;
		}
		draw_surface_part(grid_surface, xx, 0, oInfo.square_size, oInfo.h-guy.red_lines*oInfo.square_size, x+xx+shake_x, y+yy+shake_y);
		draw_surface_part(grid_surface, xx, oInfo.h-bottom_height, oInfo.square_size, bottom_height, x+xx+shake_x, y+oInfo.h-bottom_height+shake_y);
	}
} 
else if (dead <= 90) {
	draw_surface(grid_surface, x+shake_x, y+shake_y); //normal
} 
else { //withering away
	var shift = (dead-90) * (oInfo.h/30);
	if (shift < oInfo.h) {
		draw_surface_part(grid_surface, 0, shift, oInfo.w, oInfo.h-shift, x+shake_x, y+shake_x+shift);
	}
}

if (hover) && !(dead) && !(pause) { //hover piece
	draw_piece(piece, rotation, distance, hover_y, 1);
}


//GREEN POWERUP STUFF
if (powerup_triggering == 1) { //done as sender
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if (powerup_lifespan >= 15) {
		for (var i = 0; i < len(block_order); i++) { //[old block pos, victim sending, victim block spot, colour, lifespan]
			var g = block_order[i];
			var leave = ease_in(g[4]/40, 8)*room_height;
			if (g[3] != 0) {
				draw_sprite(sBrick, block_id_to_index(g[3]), x+shake_x+g[0][0]*oInfo.square_size, y+shake_y+g[0][1]*oInfo.square_size-leave);
			}
		}
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
else if (pointer_player != noone) { //done as victim
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if (pointer_player.powerup_lifespan >= 15) {
		for (var i = 0; i < len(pointer_spots); i++) { //[old block pos, victim sending, victim block spot, colour, lifespan]
			var g = pointer_player.block_order[pointer_spots[i]];
			var enter = (1-ease_out((g[4]-40)/40, 8))*room_height;
			if (g[3] != 0) {
				draw_sprite(sBrick, block_id_to_index(g[3]), x+shake_x+g[2][0]*oInfo.square_size, y+shake_y+g[2][1]*oInfo.square_size-enter);
			}
		}
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}


//piece coming next
if (dead <= 65) {
	draw_sprite(sPieceNext, piece_next, x+shake_x, y+shake_y);
}

//rock guy
if (dead <= 65) {
	var stuff = oInfo.pieces[piece][1][rotation];
	var xraw = distance+stuff[0]+stuff[1]/2;
	var xspot = x+xraw*oInfo.square_size + shake_x;
	var yspot = y+(oInfo.grid_h-the_height+2)*oInfo.square_size + shake_y;
	if (between(xraw, 0, 2)) {
		var yrod = y-128 + shake_y;
	} else if (between(xraw, 2, 5.5)) {
		var yrod = y-140 + shake_y;
	} else if (between(xraw, 5.5, 11)) {
		var yrod = y-147 + shake_y;
	}
	draw_line_width_color(xspot, yrod, xspot, yspot, 5, #7D7D7D, #7D7D7D);
	draw_sprite(sFishRock, colour_id, xspot, yrod);
	draw_sprite(sFishRod, colour_id, xspot, yrod);
}

//tomb
if (dead >= 220) {
	var shift = min(0, dead-230)*140;
	draw_sprite_ext(sTombs, 0, x+oInfo.w/2+shake_x, y+930+shift+shake_y, 1, 1, 0, colour, 1);
	draw_sprite(sTombs, placement, x+oInfo.w/2+shake_x, y+930+shift+shake_y);
}

//more rock (this is going to be hell to animate
if (between(dead, 110, 230, false)) {
	draw_sprite(sFishRod2, 0, x+oInfo.w/2, y+1081);
	draw_sprite(sFishRock2, colour_id, x+oInfo.w/2+random_range(-1, 1), y+1081+random_range(-1, 1));
}

//drawing temporary times
if !(dead) {
	//PIECE THAT IS BEING DROPPED
	draw_piece(piece, rotation, distance, the_height, 0); //piece dropping
	//warnings
	if (len(garbage_recieving)) {
		for (var i = 0; i < len(garbage_recieving); i++) {
			var guy = garbage_recieving[i];
			var transparency = clamp(triangle(guy[1]/25-0.25)+0.5, 0, 1);
			draw_sprite_part_ext(sWarning, 0, 0, 0, 400, 40*(len(guy[0])+1), x+shake_x, y+shake_y+oInfo.h-40*(len(guy[0])+1), 1, 1, guy[2], transparency);
		}
	}
}

if (dead <= 65) {
	draw_sprite(sBorder, 0+colour_id*3, x+shake_x, y+shake_y); //border no planks
} else {
	draw_sprite(sBorder, 2+colour_id*3, x+shake_x, y+shake_y); //border planked up
}


//sender display
draw_set_font(oInfo.youngster);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

var yspot = shenanigan_width+20;
for (var i = 0; i < len(shenanigan_senders); i++) {
	var guy = shenanigan_senders[i];
	var vary = ease_out(clamp(map_value(guy[0], 20, 0, 1, 0), 0, 1), 3) * ease_out(clamp(map_value(guy[0], shenanigan_time, shenanigan_time-20, 0, 1), 0, 1), 3);
	var spot = yspot*vary;
	
	//draw_rectangle_color_simple(x, yspot, x+oInfo.w, yspot+width, oInfo.colours[guy[1]][1]);
	//draw_border_rectangle(player.x, yspot, player.x+oInfo.w, yspot+width, 5, oInfo.colours[guy[1]][1], oInfo.colours[guy[1]][0]);
	var str = oInfo.colour_names[guy[1]] + " is targeting you.";
	draw_border_text(x+oInfo.w/2, spot, str, -1, 99999, 1, 1, 3, 0, oInfo.colours[guy[1]][0], oInfo.colours[guy[1]][1], 1, true);
	
	yspot += shenanigan_width*vary;
}

draw_set_font(Font);


if (trash_target_timer) && !(dead) {
	var xx = x+oInfo.w/2 + random_range(-trash_target_shake, trash_target_shake);
	var yy = y+oInfo.h/3 + random_range(-trash_target_shake, trash_target_shake);
	
	var alive_players = oInfo.return_alive_players(true);
	array_find_and_kill(alive_players, id);
	
	var all_players = array_clone(oInfo.players_colour);
	array_find_and_kill(all_players, id);
	
	var alpha = clamp(map_value(trash_target_timer, 30, 0, 0.5, 0), 0, 0.5) + clamp(map_value(trash_target_timer, 180, 170, 0.5, 0), 0, 0.5);
	draw_set_alpha(alpha);
	
	if (controls == "keyboard") {
		for (var i = 0; i < 4; i++) {
			draw_sprite(sButtons, 7+i, xx+ldx(60, (i+1)*90), yy+ldy(60, (i+1)*90));
		}
		var dist = 130;
	} else {
		draw_sprite(sButtons, 11, xx, yy);
		var dist = 80;
	}
	
	for (var i = 0; i < len(alive_players); i++) {
		//rock background
		if (trash_target_id != -1) {
			if (alive_players[i] == all_players[trash_target_id]) {
				var el_index = 5 + floor(lifespan/5)%2;
				draw_sprite_ext(sRocks, el_index, xx+ldx(dist, (i+1)*90), yy+ldy(dist, (-i+1)*90), 4, 4, 0, -1, alpha);
			}
		}
		//rock guy
		var index = alive_players[i].colour_id;
		draw_sprite_ext(sRocks, index, xx+ldx(dist, (i+1)*90), yy+ldy(dist, (-i+1)*90), 4, 4, 0, -1, alpha);
	}
	
	draw_set_alpha(1);
}










