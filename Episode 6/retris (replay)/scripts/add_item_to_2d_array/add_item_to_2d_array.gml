// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function add_item_to_2d_array(grid, item, xpos, ypos, trim=0) {
	var gridd = array_clone(grid);
	for (var i = 0; i < len(item); i++) {
		for (var j = 0; j < len(item[i]); j++) {
			if (item[i][j] != trim) {
				msg(i);
				msg(j);
				msg(ypos+i);
				msg(xpos+j);
				gridd[ypos+i][xpos+j] = item[i][j];
			}
		}
	}
	return gridd;
}