// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//piece like this:
//[0, 0, 0, 0]
//[0, 1, 0, 0]
//[1, 1, 0, 0]
//[1, 0, 0, 0] or equivalent
function check_piece_colliding(grid, piece, piece_x, piece_y) {
	for (var yy = 0; yy < 4; yy++) {
		for (var xx = 0; xx < 4; xx++) {
			if (piece[yy][xx] != 0) {
				var rx = piece_x + xx; //real x
				var ry = piece_y - yy; //real y
				//checking to see out of bounds
				if (rx < 0) {
					return "left wall";
				} else if (rx >= oInfo.grid_w) {
					return "right wall";
				} else if (ry <= 0) {
					return "floor"
				} else if (ry > oInfo.grid_h) {
					return "roof"
				}
				//check to see if colliding with another guy in grid
				if (ry < oInfo.grid_h) { //maing sure the spot is in grid (above grid is allowed)
					if (grid[oInfo.grid_h-ry][rx] != 0) {
						return "guy";
					}
				}
			}
		}
	}
	return false;
}