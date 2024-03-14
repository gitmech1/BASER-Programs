for (var i = 99; i >= 0; i--) {
	//white
	if (i > 10) {
		if (i == 11) {
			draw_set_alpha(0.03 * (difference-((lifespan/loop)%difference))/difference );
		} else {
			draw_set_alpha(0.03);
		}
		draw_rectangle_color(0, 0, 2560, 1440, c_white, c_white, c_white, c_white, false);
		draw_set_alpha(1);
	}
	
	//drawing of objects
	var distance = -(lifespan/loop)%difference +i*difference + difference;
	var scale = 300/distance;
	var guy = (floor(lifespan/loop/difference)+i);
	var index = random_nums[(floor(lifespan/loop/difference)+i)%100];
	draw_sprite_ext(sChunk, index, 1280, 720, scale, scale, lifespan/2+guy*10+rot_add, make_colour_hsv((guy*10)%255, 100, 255), 1);
}

/*if (crazy_mode) {
	if (crazy_mode >= 90) {
		loop = 0.3 + ease_in_out_clamp(90, 180, crazy_mode)*1.7;
	} else {
		loop = 0.3 + (1-ease_in_out_clamp(0, 90, crazy_mode))*1.7;
	}
	
	crazy_mode -= 1;
} else {
	loop = 2;
}*/

if (crazy_mode) {
	if (crazy_mode > 60) {
		rot_add += (1-ease_in_out_clamp(60, 120, crazy_mode))*20;
	} else {
		if (crazy_mode == 60) {
			shape_type = (shape_type+1)%3;
			for (var i = 0; i < array_length(random_nums); i++) {
				random_nums[i] = irandom_range(shape_type*3, shape_type*3+2);
			}
		}
		rot_add += ease_in_out_clamp(0, 60, crazy_mode)*20;
	}
	crazy_mode--;
}

lifespan += 1;