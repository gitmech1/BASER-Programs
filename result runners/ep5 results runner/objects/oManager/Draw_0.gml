/*draw_set_font(archivobig);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_border_text(time_elapsed*-5, 10, "-=- Leaderboard -=- Leaderboard -=- Leaderboard ", -1, 9999, 1, 1, 3, 0, c_white, #D1D1D1, 1, true);*/

var tween = ease_in(clamp(time_elapsed-1000, 0, 1200)/200, 2.5);
var xmove = -tween * 3000;
var ymove = tween * 800;
var smove = tween*3 + 1;

if !(surface_exists(colour_surface)) {
	colour_surface = surface_create(max_xvalue-padding, size+1);
}

var m = clamp(time_elapsed-200, 0, 200)/200;
var bars = ease_out(m); //amount erxtended from 0 to 1

var n = clamp(time_elapsed-450, 0, 250)/250;
var fade = ease_in_out(n); //moving from old position to new position

draw_set_font(archivo);


var col1 = #555555;
var col2 = #B7B7B7;

for (var i = amount-1; i >= 0; i--) {
	
	surface_set_target(colour_surface);
	
	clear_surface();
	
	var j = lerp(colours[i][5], colours[i][6], fade); //amoutn down screen in terms of bar amount
	var s = colours[i][3]; //start score
	var e = colours[i][4]; //end score
	var barpos = lerp(s, e, bars) * ((2100-2*padding)/max_value) + 400; //setting frame by frame edge of each bar
	
	//bar OUTSIDE
	draw_rectangle_color(200, size*0.1, barpos-20, size*0.9, col2, col2, col2, col2, false);
	draw_rectangle_color(200, size*0.1+20, barpos, size*0.9-20, col2, col2, col2, col2, false);
	draw_circle_color(barpos-20, size*0.1+20, 20, col2, col2, false);
	draw_circle_color(barpos-20, size*0.9-20, 20, col2, col2, false);
	
	//bar INSIDE
	draw_rectangle_color(200, size*0.1+10, barpos-20, size*0.9-10, col1, col1, col1, col1, false);
	draw_rectangle_color(200, size*0.1+20, barpos-10, size*0.9-20, col1, col1, col1, col1, false);
	draw_circle_color(barpos-20, size*0.1+20, 10, col1, col1, false);
	draw_circle_color(barpos-20, size*0.9-20, 10, col1, col1, false);
	
	//box
	draw_rectangle_color(0, 0, 400, size, 
		col2, col2, col2, col2, false);
	draw_rectangle_color(10, 10, 400-10, size-10, 
		col1, col1, col1, col1, false);
	
	//bar text
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	var num = floor(lerp(s, e, bars));
	draw_text_transformed_color(barpos-15, size/2, num, 1, 1, 0, 
		col2, col2, col2, col2, 1);
	if (e-num != 0) && (time_elapsed > 100) {
		var col3 = make_color_hsv(0, 0, (100-clamp(0, 28, time_elapsed-100))*2.55);
		draw_text_transformed_color(barpos-15-string_width(string(num)), size/2, string(e-num) + " + ", 1, 1, 0, 
			col3, col3, col3, col3, 1);
	}
	
	//text
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed_color(200, size/2, colours[i][0],
		1, 1, 0, col2, col2, col2, col2, 1);
	
	
	gpu_set_colorwriteenable(1, 1, 1, 0);
	gpu_set_blendmode(bm_max);

	draw_rectangle_color(0, 0, max_xvalue-padding, size+1, colours[i][1], colours[i][1], colours[i][1], colours[i][1], false);

	gpu_set_colorwriteenable(1, 1, 1, 1);
	gpu_set_blendmode(bm_normal);
	
	
	surface_reset_target();
	
	
	draw_surface_ext(colour_surface, (padding+xmove)*smove, (padding+size*j+ymove)*smove, smove, smove, 0, -1, 1);
	
	
	//eliminated?
	draw_set_font(archivobig);
	if (colours[i][7] == 2) || ((colours[i][7] == 1) && (time_elapsed >= 750)) {
		var h = string_height("ELIMINATED");
		var w = string_width("ELIMINATED");
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		if (w*size/h+barpos > 2540-padding) {
			draw_border_text((2540-padding-w*size/h+xmove)*smove, (padding+size*j+ymove)*smove, "ELIMINATED", -1, 9999, size/h*smove, size/h*smove, 4, 0, c_red, #7F0000, 1, true);
		} else {
			draw_border_text((barpos+padding+20+xmove)*smove, (padding+size*j+ymove)*smove, "ELIMINATED", -1, 9999, size/h*smove, size/h*smove, 4, 0, c_red, #7F0000, 1, true);
		}
	}
	draw_set_font(archivo);
}

if (time_elapsed == 750) {
	audio_play_sound(sBoom, 99999, false, 2, 1.15);
}

time_elapsed++;





























