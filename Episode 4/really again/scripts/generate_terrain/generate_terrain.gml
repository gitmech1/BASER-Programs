// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generate_terrain(grid_x, grid_z, mid_x, mid_y, mid_z, size, edge_col, fill_col, z_fade, z_edge_flatten, ease){
	var final_shape = [];
	
	//generating offsets on x and z
	var offsets = [];
	for (var i = 0; i < grid_z; i++) {
		var temp_offsets = [];
		for (var j = 0; j < grid_x; j++) {
			array_push(temp_offsets, irandom_range(0, 8));
		}
		array_push(offsets, temp_offsets);
	}
	//    x
	//  1   2
	//z
	//  3   4
	
	//making the actual shape
	for (var i = 0; i < grid_z-1; i++) {
		for (var j = 0; j < grid_x-1; j++) {
			//       offset based off determined shift         larger general position move
			var x1 = (floor(offsets[i][j]/3)-1) * size/5   -   (grid_x-1)/2*size + size*j   +   mid_x;
			var y1 = perlin_noise(i, j)*20 * min(1, i+1-z_edge_flatten)  +  mid_y   +   z_fade*(1-ease(i/(grid_z-1)));
			var z1 = ((offsets[i][j] mod 3)-1) * size/5 * min(1, i+1-z_edge_flatten)   -   (grid_z-1)/2*size + size*i   +   mid_z;
			var x2 = (floor(offsets[i][j+1]/3)-1) * size/5   -   (grid_x-1)/2*size + size*(j+1)   +   mid_x;
			var y2 = perlin_noise(i, j+1)*20 * min(1, i+1-z_edge_flatten)  +  mid_y   +   z_fade*(1-ease(i/(grid_z-1)));
			var z2 = ((offsets[i][j+1] mod 3)-1) * size/5 * min(1, i+1-z_edge_flatten)   -   (grid_z-1)/2*size + size*i   +   mid_z;
			var x3 = (floor(offsets[i+1][j]/3)-1) * size/5   -   (grid_x-1)/2*size + size*j   +   mid_x;
			var y3 = perlin_noise(i+1, j)*20 * min(1, grid_z-i-1-z_edge_flatten)  +  mid_y   +   z_fade*(1-ease((i+1)/(grid_z-1)));
			var z3 = ((offsets[i+1][j] mod 3)-1) * size/5 * min(1, grid_z-i-1-z_edge_flatten)   -   (grid_z-1)/2*size + size*(i+1)   +   mid_z;
			var x4 = (floor(offsets[i+1][j+1]/3)-1) * size/5   -   (grid_x-1)/2*size + size*(j+1)   +   mid_x;
			var y4 = perlin_noise(i+1, j+1)*20 * min(1, grid_z-i-1-z_edge_flatten)  +  mid_y   +   z_fade*(1-ease((i+1)/(grid_z-1)));
			var z4 = ((offsets[i+1][j+1] mod 3)-1) * size/5 * min(1, grid_z-i-1-z_edge_flatten)   -   (grid_z-1)/2*size + size*(i+1)   +   mid_z;
			
			//random for different trongle cation
			if (irandom_range(1, 2) == 1) {
				array_push(final_shape, [[[x1, y1, z1], [x2, y2, z2], [x3, y3, z3]], edge_col, fill_col, average_3d([x1, y1, z1], [x2, y2, z2], [x3, y3, z3]), "nothing"]);
				array_push(final_shape, [[[x4, y4, z4], [x2, y2, z2], [x3, y3, z3]], edge_col, fill_col, average_3d([x4, y4, z4], [x2, y2, z2], [x3, y3, z3]), "nothing"]);
			} else {
				array_push(final_shape, [[[x1, y1, z1], [x2, y2, z2], [x4, y4, z4]], edge_col, fill_col, average_3d([x1, y1, z1], [x2, y2, z2], [x4, y4, z4]), "nothing"]);
				array_push(final_shape, [[[x4, y4, z4], [x1, y1, z1], [x3, y3, z3]], edge_col, fill_col, average_3d([x4, y4, z4], [x1, y1, z1], [x3, y3, z3]), "nothing"]);
			}
		}
	}
	
	return final_shape;
}