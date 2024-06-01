// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function update_2d(shape) {
	//depth sort
	array_sort(shape, sort_by_3d_distance);
	
	//pushing
	var new_points = [];
	
	//other points
	for (var i = 0; i < len(shape); i++) {
		if (shape[i][4] == "ground") {
			//ground behind
			var area = convert_to_2d([0, -600, -2400]);
			array_push(new_points, [[[0, 720], [2560, 720], [2560, area[1]]], shape[i][1], shape[i][1]]);
			array_push(new_points, [[[0, 720], [0, area[1]], [2560, area[1]]], shape[i][1], shape[i][1]]);
		} else if (shape[i][4] == "water") {
			//water behind
			var area = convert_to_2d([0, -600, -1500]);
			array_push(new_points, [[[0, 720], [2560, 720], [2560, area[1]]], shape[i][1], shape[i][1]]);
			array_push(new_points, [[[0, 720], [0, area[1]], [2560, area[1]]], shape[i][1], shape[i][1]]);
		} else {
			array_push(new_points, [[convert_to_2d(shape[i][0][0]), convert_to_2d(shape[i][0][1]), convert_to_2d(shape[i][0][2])], shape[i][1], shape[i][2]]);
		}
	}
	
	return new_points;
}