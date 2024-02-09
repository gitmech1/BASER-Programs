// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_background_surface(cx, cy, point_list, index, no_name){
	surface_set_target(background_surface);
	draw_clear_alpha(c_white,0);
	
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	if (index == -1) {
		draw_sprite_ext(sBackground, 9, -200+lifespan%200, -200+lifespan%200, 5, 5, 0, -1, 1);
	} else {
		draw_sprite_ext(sBackground, index, -200+lifespan%200, -200+lifespan%200, 5, 5, 0, -1, 1);
		if !(no_name) {
			draw_border_text(bw/2, bh/2, colours[index][0], -1, 9999, 1, 1, 6, 0, colours[index][1], colours[index][2], 1, true);
		}
	}
	
	//draw nothign section
	gpu_set_blendmode(bm_subtract);
	for (var i = 0; i < len(point_list); i++) {
		//setting
		var x1 = point_list[i%len(point_list)][0]-cx+bw/2;
		var y1 = point_list[i%len(point_list)][1]-cy+bh/2;
		var x2 = point_list[(i+1)%len(point_list)][0]-cx+bw/2;
		var y2 = point_list[(i+1)%len(point_list)][1]-cy+bh/2;
		var nx = point_list[(i+2)%len(point_list)][0]-cx+bw/2;
		var ny = point_list[(i+2)%len(point_list)][1]-cy+bh/2;
		var angle = point_direction(x1, y1, x2, y2)+90;
		var angle2 = point_direction(x2, y2, nx, ny)+90;
		var x3 = x1+lengthdir_x(1000, angle);
		var y3 = y1+lengthdir_y(1000, angle);
		var x4 = x2+lengthdir_x(1000, angle);
		var y4 = y2+lengthdir_y(1000, angle);
		var nx2 = nx+lengthdir_x(1000, angle2);
		var ny2 = ny+lengthdir_y(1000, angle2);
		
		//drawing
		draw_triangle(x1, y1, x2, y2, x3, y3, false);
		draw_triangle(x4, y4, x2, y2, x3, y3, false);
		draw_triangle(x2, y2, x4, y4, nx2, ny2, false);
	}
	gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
	
	draw_surface(background_surface, cx-bw/2+2560/2+(x-2560), cy-bh/2+1440/2+(y-1440));
}