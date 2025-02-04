// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_txt_display_ext(xpos, ypos, txt, xscale, yscale, rot, col, alpha) { //only 0 - 9 and :
	var total_width = len(txt)*33 - string_count(":", txt)*15;
	var width_thus = 0;
	var text = string(txt);
	for (var i = 0; i < len(text); i++) {
		if (string_char_at(text, i+1) == ":") {
			var subimg = 10;
			var width = 15*xscale;
		} else {
			var subimg = int64(string_char_at(text, i+1));
			var width = 33*xscale;
		}
		var real_x = xpos - total_width/2 + width_thus + width/2;
		draw_sprite_ext(sDigit, subimg, real_x, ypos, xscale, yscale, rot, col, alpha);
		width_thus += width;
	}
}