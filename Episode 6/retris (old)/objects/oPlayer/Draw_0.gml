if (shake > 0) {
	shake_x = random_range(-shake, shake);
	shake_y = random_range(-shake, shake);
} else {
	shake_x = 0;
	shake_y = 0;
}


draw_sprite(sBorder, 1+player_id*3, x+shake_x, y+shake_y); //back of border

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

if (dead <= 90) {
	draw_surface(grid_surface, x+shake_x, y+shake_y); //normal
} else {
	var shift = (dead-90) * (oInfo.h/30);
	if (shift < oInfo.h) {
		draw_surface_part(grid_surface, 0, shift, oInfo.w, oInfo.h-shift, x+shake_x, y+shake_x+shift);
	}
}

if (hover) && !(dead) {
	draw_piece(piece, rotation, distance, hover_y, 1);
}

//rock guy
if (dead <= 65) {
	var stuff = oInfo.pieces[piece][1][rotation];
	var xraw = distance+stuff[0]+stuff[1]/2;
	var xspot = x+xraw*oInfo.square_size + shake_x;
	var yspot = y+(oInfo.grid_h-height+2)*oInfo.square_size + shake_y;
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
	draw_piece(piece, rotation, distance, height, 0); //piece dropping
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
	draw_sprite(sBorder, 0+player_id*3, x+shake_x, y+shake_y); //border
} else {
	draw_sprite(sBorder, 2+player_id*3, x+shake_x, y+shake_y); //border
}















