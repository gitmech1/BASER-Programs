// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_trim(le_array, to_trim){ //trims all sides that have no info in em (assuming rectangular)
	var array = array_clone(le_array);
	var new_array = array;
	//vertical
	for (var xxx = len(array[0])-1; xxx >= 0; xxx--) {
		var check = true;
		for (var i = 0; i < len(array); i++) {
			if (array[i][xxx] != to_trim) {
				check = false;
			}
		}
		if (check == true) {
			for (var i = 0; i < len(new_array); i++) {
				array_delete(new_array[i], xxx, 1);
			}
		}
	}
	//horizontal
	for (var yyy = len(new_array)-1; yyy >= 0; yyy--) {
		var check = true;
		for (var i = 0; i < len(new_array[yyy]); i++) {
			if (new_array[yyy][i] != to_trim) {
				check = false;
			}
		}
		if (check == true) {
			array_delete(new_array, yyy, 1);
		}
	}
	return new_array;
}