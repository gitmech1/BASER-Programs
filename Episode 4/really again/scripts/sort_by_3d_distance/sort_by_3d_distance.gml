// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function sort_by_3d_distance(elm1, elm2){
	var elem1 = elm1[0];
	var elem2 = elm2[0];
	
	if (elm1[4] == "higher") && (elm2[4] != "higher") {
		return 1;
	} else if (elm1[4] != "higher") && (elm2[4] == "higher") {
		return -1;
	}
	
	var elem1_avg = average_3d(elem1[0], elem1[1], elem1[2]);
	var elem2_avg = average_3d(elem2[0], elem2[1], elem2[2]);
	
	var elem1_dist_mid = pythag_3d(xpos, elem1_avg[0], ypos, elem1_avg[1], zpos/10, elem1_avg[2]/10);
	var elem2_dist_mid = pythag_3d(xpos, elem2_avg[0], ypos, elem2_avg[1], zpos/10, elem2_avg[2]/10);
	
	var elem1_dist_0 = pythag_3d(xpos, elem1[0][0], ypos, elem1[0][1], zpos, elem1[0][2]);
	var elem1_dist_1 = pythag_3d(xpos, elem1[1][0], ypos, elem1[1][1], zpos, elem1[1][2]);
	var elem1_dist_2 = pythag_3d(xpos, elem1[2][0], ypos, elem1[2][1], zpos, elem1[2][2]);
	
	var elem2_dist_0 = pythag_3d(xpos, elem2[0][0], ypos, elem2[0][1], zpos, elem2[0][2]);
	var elem2_dist_1 = pythag_3d(xpos, elem2[1][0], ypos, elem2[1][1], zpos, elem2[1][2]);
	var elem2_dist_2 = pythag_3d(xpos, elem2[2][0], ypos, elem2[2][1], zpos, elem2[2][2]);
	
	if (min(elem1_dist_mid, elem1_dist_0, elem1_dist_1, elem1_dist_2) <= min(elem2_dist_mid, elem2_dist_0, elem2_dist_1, elem2_dist_2)) {
		return 1;
	} else {
		return -1;
	}
}