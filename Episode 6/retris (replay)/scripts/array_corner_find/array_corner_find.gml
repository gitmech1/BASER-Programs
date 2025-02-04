// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function array_corner_find(array, blank_value) { //excluding zeroes for example, finds top left corner that fits everything
	var top = -1;
	var left = -1;
	//top find
	var tcount = 0;
	while (top == -1) {
		for (var i = 0; i < len(array[tcount]); i++) {
			if (array[tcount][i] != blank_value) {
				top = tcount;
			}
		}
		tcount++;
	}
	//left
	var lcount = 0;
	while (left == -1) {
		for (var i = 0; i < len(array); i++) {
			if (array[i][lcount] != blank_value) {
				left = lcount;
			}
		}
		lcount++;
	}
	return [left, top];
}