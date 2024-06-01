//chat log
draw_set_font(font2);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

for (var i = 0; i < len(chat_log); i++) {
	var in = ease_out(clamp(chat_log[i][3], 0, 20)/20) * (1-ease_out(clamp(chat_log[i][3]-220, 0, 20)/20));
	var xx = 2140 + (string_width(chat_log[i][0])+60)*(1-in);
	var yy = 1440 - 80*(i+1) + (max(0, len(chat_log)-chat_log_height))*80;
	draw_border_text(xx, yy, chat_log[i][0], -1, 99999, 1, 1, 3, 0, chat_log[i][1], chat_log[i][2], 1, true);
}


//left
draw_set_font(font1);
draw_border_rectangle(0, 0, 400, 1440, 5, #222222, #333333);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

draw_text_ext_transformed_color(200, 300, "RANKINGS", -1, 999999, 0.7, 1.5, 0, #444444, #444444, #444444, #444444, 1);
for (var i = 0; i < len(colours); i++) {
	//rock drawing
	var rotation = 5*sin((lifespan+i*60)* pi/180);
	draw_sprite_ext(sRock, 0, 200, 330+188*colours[i][4], 5, 5, rotation, colours[i][1], 1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(font2);
	draw_text_transformed_color(200, 335+188*colours[i][4], colours[i][9], 1, 1, rotation, colours[i][2], colours[i][2], colours[i][2], colours[i][2], 1);
	//icon drawing
	if (colours[i][7] >= 0) {
		var scale = elastic_ease(colours[i][7]/20);
		draw_sprite_ext(sIcon, 0, 200, 330+188*colours[i][4], 6*scale, 6*scale, 0, -1, 1);
	}
}

//right
draw_border_rectangle(2560, 0, 2160, 1440, 5, #222222, #333333);
draw_rectangle_color(2205, 45, 2515, 1395, #222222, #222222, #222222, #222222, false);
draw_sprite(sGradient, 0, 2210, 50);
for (var i = 0; i < len(colours); i++) {
	var ypoint = colours[i][6].y;
	var faction = 0;
	if (ypoint < point_list[0]) {
		faction = 0;
	} else if (ypoint > point_list[5]) {
		faction = 5;
	} else {
		for (var j = 0; j < len(point_list)-1; j++) {
			if (ypoint > point_list[j]) && (ypoint < point_list[j+1]) {
				faction = j + reverse_lerp(point_list[j], point_list[j+1], ypoint);
			}
		}
	}
	arrow_point = 1390 - faction*268
	draw_triangle_color(2210, arrow_point, 2180, arrow_point+20, 2180, arrow_point-20,  colours[i][1], colours[i][1], colours[i][1], false);
}


//win text
if (win_in) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(font3);
	
	var scale = 5000/(250-min(249.99, win_in)) - 20;
	var movin = scale/20;
	
	draw_border_text(random_range(-movin, movin)+1280, random_range(-movin, movin)+720, win_text, -1, 999999, scale/100, scale/100, scale/25, 0, win_col, win_col2, 1, true);
}