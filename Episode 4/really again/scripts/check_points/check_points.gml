// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function check_points(points){
	for (var i = 0; i < len(points); i++) {
		for (var j = 0; j < 3; j++) {
			if (points[i][j][0] >= 0 && points[i][j][0] <= 2560) && (points[i][j][1] >= 0 && points[i][j][1] <= 1440) {
				return true;
			}
		}
	}
	return false;
}