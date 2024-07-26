// scrip
function draw_border_text(_x, _y, _string, _sep, _w, _xscale, _yscale, _width, _angle, _insidecol, _bordercol, _alpha, extra=false){
	//corners
	draw_text_ext_transformed_color(_x+_width, _y+_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	draw_text_ext_transformed_color(_x+_width, _y-_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	draw_text_ext_transformed_color(_x-_width, _y+_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	draw_text_ext_transformed_color(_x-_width, _y-_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	if (extra) {
		//sides if cheeky
		draw_text_ext_transformed_color(_x+_width, _y, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
		draw_text_ext_transformed_color(_x, _y-_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
		draw_text_ext_transformed_color(_x, _y+_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
		draw_text_ext_transformed_color(_x-_width, _y, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	}
	//normal one
	draw_text_ext_transformed_color(_x, _y, _string, _sep, _w, _xscale, _yscale, _angle, _insidecol, _insidecol, _insidecol, _insidecol, _alpha);
}