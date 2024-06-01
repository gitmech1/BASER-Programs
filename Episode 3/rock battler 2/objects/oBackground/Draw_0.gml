//background col
draw_rectangle_color(0, 0, 2560, 1440, #202122, #202122, #202122, #202122, false);

if (lifespan > 5 && lifespan < 8) || (lifespan > 12 && lifespan < 14) || (lifespan > 14) {

	//health bar 1
	if (oInfo.health1 > 0) {
		draw_rectangle_color(883 - (oInfo.health1)*(883-273), 590, 883, 637, #DD1822, #8E0E16, #8E0E16, #DD1822, false);
		draw_line_width_color(883 - (oInfo.health1)*(883-273), 590, 883 - (oInfo.health1)*(883-273), 637, 5, #8E0E16, #8E0E16);
	}
	//health bar 2
	if (oInfo.health2 > 0) {
		draw_rectangle_color(2297 - (1-oInfo.health2)*(2297-1684), 587, 1684, 636, #8E0E16, #DD1822, #DD1822, #8E0E16, false);
		draw_line_width_color(2297 - (1-oInfo.health2)*(2297-1684), 587, 2297 - (1-oInfo.health2)*(2297-1684), 636, 5, #8E0E16, #8E0E16);
	}


	//name stuff ==================================================================================================================
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	draw_set_font(font);
	var divisions = 20;

	//oooon da left side
	if (oInfo.winner == "") {
		var name = oInfo.name1;
		var colour = oInfo.colour1;
		var comp = oInfo.comp1;
	} else if (oInfo.winner == "left") {
		var name = "WINNER!";
		var colour = #F3CE4A;
		var comp = #D08E2E;
	} else if (oInfo.winner == "right") {
		var name = "loser.";
		var colour = #777777;
		var comp = #545454;
	}

	draw_rectangle_color(524, 466, 888, 550, comp, merge_colour(comp, colour, 0.15), merge_colour(comp, colour, 0.15), comp, false);

	var yy = (466+550)/2-3;
	for (var i = 0; i < divisions; i++) {
		var point1 = 524+(888-524)*i/divisions;
		var point2 = 524+(888-524)*(i+1)/divisions;
	
		var i1 = sin(degtorad(lifespan*7-i*400/divisions))*20+yy;
		var i2 = sin(degtorad(lifespan*7-(i+1)*400/divisions))*20+yy;
		draw_line_width_color(point1, i1, point2, i2, 14, colour, colour);
		draw_line_width_color(point1, i1, point2, i2, 8, comp, comp);
	}
	var scale = 1.05+sin(degtorad(lifespan*2))*0.05;
	draw_border_text(707, 505, name, -1, 999999, scale, scale, 4, 0, colour, comp, 1, true);


	//ooooooooon da right side
	if (oInfo.winner == "") {
		var name = oInfo.name2;
		var colour = oInfo.colour2;
		var comp = oInfo.comp2;
	} else if (oInfo.winner == "right") {
		var name = "WINNER!";
		var colour = #F3CE4A;
		var comp = #D08E2E;
	} else if (oInfo.winner == "left") {
		var name = "loser.";
		var colour = #777777;
		var comp = #545454;
	}

	draw_rectangle_color(1678, 462, 2030, 549, merge_colour(comp, colour, 0.15), comp, comp, merge_colour(comp, colour, 0.15), false);
	var yy = (462+549)/2;
	for (var i = 0; i < divisions; i++) {
		var point1 = 1678+(2030-1678)*i/divisions;
		var point2 = 1678+(2030-1678)*(i+1)/divisions;
	
		var i1 = sin(degtorad(lifespan*7+i*400/divisions))*20+yy;
		var i2 = sin(degtorad(lifespan*7+(i+1)*400/divisions))*20+yy;
		draw_line_width_color(point1, i1, point2, i2, 14, colour, colour);
		draw_line_width_color(point1, i1, point2, i2, 8, comp, comp);
	}
	var scale = 1.05+sin(degtorad(lifespan*2+180))*0.05;
	draw_border_text(1859, 505, name, -1, 999999, scale, scale, 4, 0, colour, comp, 1, true);

	//title stuff ===========================================================================
	draw_rectangle_color(612, 167, 1927, 438, #7D7D7D, #7D7D7D, #7D7D7D, #7D7D7D, false);
	var variation = 10;
	for (var i = 0; i < 280/variation; i++) {
		draw_line_width_color(612, 160+(lifespan/4)%variation+i*variation, 1927, 160+(lifespan/4)%variation+i*variation, 2, #959595, #959595);
	}
	draw_set_font(font2);
	//text top
	draw_text_transformed_color(1500-(lifespan*1.5)%(string_width(oInfo.toptext)*0.7), 217, oInfo.toptext+oInfo.toptext+oInfo.toptext, 0.6, 0.6, 0, #C1C1C1, #C1C1C1, #C1C1C1, #C1C1C1, 1);
	//text left
	draw_set_halign(fa_right);
	draw_text_transformed_color(876+(len(txt_left)-txt_pos)*string_width("2"), 397, txt_left, 0.7, 0.7, 0, #C1C1C1, #C1C1C1, #C1C1C1, #C1C1C1, 1);
	//text right
	draw_set_halign(fa_left);
	draw_text_transformed_color(1682-(len(txt_left)-txt_pos)*string_width("2"), 397, txt_right, 0.7, 0.7, 0, #C1C1C1, #C1C1C1, #C1C1C1, #C1C1C1, 1);

	if !(oInfo.fighting) {
		if (oInfo.winner = "left") {
			draw_sprite_ext(sSiren, 1, 440, 507, 3, 3, 0, -1, 1);
			oSiren.x = 440;
			oSiren.y = 507;
		} else {
			draw_sprite_ext(sSiren, 1, 2109, 504, 3, 3, 0, -1, 1);
			oSiren.x = 2109;
			oSiren.y = 504;
		}
	}
}

draw_self();