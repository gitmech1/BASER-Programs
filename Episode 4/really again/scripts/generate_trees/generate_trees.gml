// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function generate_trees(grid_x, grid_z, mid_x, mid_y, mid_z, size, z_fade, ease, distance){
	var w = grid_x*size;
	var h = grid_z*size;
	
	var tree_points = [];
	var trials = 0;
	
	while (trials < 1000) {
		var temp_x = random_range(100, w-100);
		var temp_y = random_range(200, h-200);
		
		var failed = false;
		for (var i = 0; i < len(tree_points); i++) {
			if (pythag(temp_x, temp_y, tree_points[i][0], tree_points[i][1]) < distance) {
				failed = true;
			}
		}
		
		if !(failed) {
			array_push(tree_points, [temp_x, temp_y]);
		} else {
			trials++;
		}
	}
	
	var final_points = [];
	
    for (var i = 0; i < len(tree_points); i++) {
        var xx = tree_points[i][0] + (mid_x-w/2);
        var zz = tree_points[i][1] + (mid_z-h/2);
		var z_thingaloo = tree_points[i][1]/size/(grid_z-1);
		var yy = perlin_noise(tree_points[i][1]/size, tree_points[i][0]/size)*20   +   mid_y   +   z_fade*(1-ease(z_thingaloo));
        var scale = random_range(1.9*(2-z_thingaloo), 2.5*(2-z_thingaloo));
        var segments = irandom_range(5, 9);
        for (var j = 0; j < segments; j++) {
            var xthing = xx + (cos(pi/(segments/2)*j)) * 7 * scale;
            var zthing = zz + (sin(pi/(segments/2)*j)) * 7 * scale;
            var xthingnext = xx + (cos(pi/(segments/2)*(j+1))) * 7 * scale;
            var zthingnext = zz + (sin(pi/(segments/2)*(j+1))) * 7 * scale;
            var xthing2 = xx + (cos(pi/(segments/2)*j)) * 20 * scale;
            var zthing2 = zz + (sin(pi/(segments/2)*j)) * 20 * scale;
            var xthingnext2 = xx + (cos(pi/(segments/2)*(j+1))) * 20 * scale;
            var zthingnext2 = zz + (sin(pi/(segments/2)*(j+1))) * 20 * scale;
            array_push(final_points, [[[xthing, yy, zthing], [xthingnext, yy, zthingnext], [xthingnext, yy + 60 * scale, zthingnext]], #6b2a02, #7e3617, average_3d([xthing, yy, zthing], [xthingnext, yy, zthingnext], [xthingnext, yy + 60 * scale, zthingnext]), "higher"]);
			array_push(final_points, [[[xthing, yy, zthing], [xthingnext, yy + 60 * scale, zthingnext], [xthing, yy + 60 * scale, zthing]], #6b2a02, #7e3617, average_3d([xthing, yy, zthing], [xthingnext, yy + 60 * scale, zthingnext], [xthing, yy + 60 * scale, zthing]), "higher"]);
            array_push(final_points, [[[xthing2, yy + 60 * scale, zthing2], [xthingnext2, yy + 60 * scale, zthingnext2], [xx, yy + 140  * scale, zz]], #0f6b15, #23aa2e, average_3d([xthing2, yy + 60 * scale, zthing2], [xthingnext2, yy + 60 * scale, zthingnext2], [xx, yy + 140  * scale, zz]), "higher"]);
		}
	}
	
	return final_points;
}