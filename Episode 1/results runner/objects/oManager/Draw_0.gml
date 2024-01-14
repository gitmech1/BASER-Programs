/*draw_set_font(archivobig);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_border_text(time_elapsed*-5, 10, "-=- Leaderboard -=- Leaderboard -=- Leaderboard ", -1, 9999, 1, 1, 3, 0, c_white, #D1D1D1, 1, true);*/

var m = clamp(time_elapsed-200, 0, 200)/200;
var bars = 1-power(1-m, 2);

var n = clamp(time_elapsed-450, 0, 250)/250;
var fade = 3*power(n, 2) - 2*power(n, 3);

draw_set_font(archivo);

//backround
draw_triangle_color(0, 0, 2560, 0, 2560/2, 2560/2, #353535, #353535, #353535, false); //top
draw_triangle_color(0, 0, 0, 1440, 1440/2, 1440/2, #2B2B2B, #2B2B2B, #2B2B2B, false); //left
draw_triangle_color(2560, 0, 2560, 1440, 2560-1440/2, 1440/2, #1C1C1C, #1C1C1C, #1C1C1C, false); //right
draw_triangle_color(0, 1440, 2560, 1440, 2560/2, 1440-2560/2, #161616, #161616, #161616, false); //bottom
draw_rectangle_color(padding-10, padding-10, 2560+10-padding, 1440+10-padding, #232323, #232323, #232323, #232323, false);

for (var i = amount-1; i >= 0; i--) {
	var j = colours[i][5] - (colours[i][5]-colours[i][6])*fade;
	var s = colours[i][3]; //start
	var e = colours[i][4]; //end
	var barpos = (s - (s-e)*bars) * ((2100-2*padding)/max_value) + padding+400;
	
	//bars
	draw_rectangle_color(padding+200, padding+size*(j+0.1), barpos-20, padding+size*(j+0.9), colours[i][1], colours[i][1], colours[i][1], colours[i][1], false);
	draw_rectangle_color(padding+200, padding+size*(j+0.1)+20, barpos, padding+size*(j+0.9)-20, colours[i][1], colours[i][1], colours[i][1], colours[i][1], false);
	draw_circle_color(barpos-20, padding+size*(j+0.1)+20, 20, colours[i][1], colours[i][1], false);
	draw_circle_color(barpos-20, padding+size*(j+0.9)-20, 20, colours[i][1], colours[i][1], false);
	
	//box
	draw_rectangle_color(padding, padding+size*j, padding+400, padding+size*(j+1), 
	colours[i][1], colours[i][1], colours[i][1], colours[i][1], false);
	draw_rectangle_color(padding+10, padding+size*j+10, padding+400-10, padding+size*(j+1)-10, 
	colours[i][2], colours[i][2], colours[i][2], colours[i][2], false);
	
	//bar text
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_text_transformed_color(barpos-15, padding+size*(j+0.5), round(s + (e-s)*bars), 1, 1, 0, 
	colours[i][2], colours[i][2], colours[i][2], colours[i][2], 1);
	
	//text
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed_color(padding+200, padding+size*(j+0.5), colours[i][0],
	1, 1, 0, colours[i][1], colours[i][1], colours[i][1], colours[i][1], 1);
	
	//eliminated?
	draw_set_font(archivobig);
	if (colours[i][7] == 2) || ((colours[i][7] == 1) && (time_elapsed >= 750)) {
		var h = string_height("ELIMINATED");
		var w = string_width("ELIMINATED");
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		if (w*size/h+barpos > 2540-padding) {
			draw_border_text(2540-padding-w*size/h, padding+size*j, "ELIMINATED", -1, 9999, size/h, size/h, 4, 0, c_red, #7F0000, 1, true);
		} else {
			draw_border_text(barpos+20, padding+size*j, "ELIMINATED", -1, 9999, size/h, size/h, 4, 0, c_red, #7F0000, 1, true);
		}
	}
	draw_set_font(archivo);
}

if (time_elapsed == 750) {
	audio_play_sound(sBoom, 99999, false, 2, 1.15);
}

time_elapsed++;