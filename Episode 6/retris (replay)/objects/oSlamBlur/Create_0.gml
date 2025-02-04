lifespan = 0;

height_diff = 0;
piece = 0;
rotation = 0;

local_square_size = oInfo.square_size;

surface = -1;
fade = 1;
summoner = noone;

function render_piece() {
	surface_set_target(surface);
	draw_clear_alpha(c_white,0);
	
	/*var temp_piece = piece_rotated(piece, rotation);
	for (var yy = 0; yy < 4; yy++) {
		for (var xx = 0; xx < 4; xx++) {
			if (temp_piece[yy][xx] == 1) {
				draw_sprite(sBrick, piece, xx*oInfo.square_size, yy*oInfo.square_size);
			}
		}
	}
	
	gpu_set_blendmode(bm_add);*/
	var stuff = oInfo.pieces[piece][1][rotation];
	draw_sprite_stretched(sRainboh, 0, stuff[0]*local_square_size, 0, stuff[1]*local_square_size, 4*local_square_size);
	
	/*gpu_set_blendmode(bm_subtract);
	
	var temp_piece = piece_rotated(piece, rotation);
	for (var yy = 0; yy < 4; yy++) {
		for (var xx = 0; xx < 4; xx++) {
			if (temp_piece[yy][xx] != 1) {
				draw_sprite(sBrick, piece, xx*local_square_size, yy*local_square_size);
			}
		}
	}
	
	gpu_set_blendmode(bm_normal);
	
	draw_rectangle_color_simple(0, 0, 100, 100, c_white);*/
	
	surface_reset_target();
}