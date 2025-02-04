if (room == Start) {
	//each player
	for (var i = 0; i < len(player_hover); i++) {
		var choice = player_hover[i]%5;
		var choice_real = round_dp(player_slow_hover[i], 4)%5;
	
		if (choice = -1) {
			draw_sprite(sIcons, 0, positions[i], 520); //just the display to join
		}
	
		else {
			var sprite1 = (floor(choice_real)+5)%5;
			var sprite2 = (ceil(choice_real)+5)%5;
			var remainer = (choice_real+1)%1;
			//pictures
			draw_sprite_specific(sIcons, sprite1+1, positions[i], centre-height*remainer, i); //top
			if (remainer != 0) {
				draw_sprite_specific(sIcons, sprite2+1, positions[i], centre-height*(remainer-1), i); //bottom
			}
		
			//text
			/*var flux1 = sin(lifespan/50+i)*0.05;
			draw_sprite_ext(sTexts, sprite1, positions[i], text_height-(height+150)*remainer, 1.05+flux1, 1.05+flux1, 0, -1, 1);
			draw_sprite_ext(sTexts, sprite2, positions[i], text_height-(height+150)*(remainer-1), 1.05+flux1, 1.05+flux1, 0, -1, 1);*/
		
			//selecting
			if (player_clicked[i] > 0) {
				//quick flash
				if (player_clicked[i]%6 < 3) {
					draw_set_alpha(0.8);
					draw_rectangle_color_simple(positions[i]-250, centre-500, positions[i]+250, centre+500, c_white);
					draw_set_alpha(1);
				}
			}
		
			//arrows
			if (player_clicked[i] == 0) {
				var subimg = lifespan%20 < 10;
				var heightness = 370 + triangle(lifespan/10)*3;
				draw_sprite_ext(sArrow, subimg, positions[i], centre-heightness, 1, 1, 0, -1, 1);
				draw_sprite_ext(sArrow, subimg, positions[i], centre+heightness, 1, 1, 180, -1, 1);
			}
		}
	}

	//over stuff
	draw_sprite(sBack, 0, 0, 0);
	draw_sprite(sTitle, 0, 0, ease_in(clamp(-lifespan/200+1.4, 0, 1), 4)*420 + (sin(degtorad(lifespan))+1)*10);

	//countdown blackness
	if (countdown <= 0) {
		draw_set_alpha(-countdown/50);
		draw_rectangle_color_simple(0, 0, room_width, room_height, c_black);
		draw_set_alpha(1);
	}
} 

else {
	//countdown unblackness
	if (countdown > -110) {
		draw_set_alpha((countdown+110)/50);
		draw_rectangle_color_simple(oC.cx1, oC.cy1, oC.cx2, oC.cy2, c_black);
		draw_set_alpha(1);
	}
}
















