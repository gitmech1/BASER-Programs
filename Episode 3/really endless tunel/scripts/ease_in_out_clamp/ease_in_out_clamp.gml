// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ease_in_out_clamp(start, fin, value){
	if (value < start) {
		return 0;
	} else if (value > fin) {
		return 1;
	} else {
		return ease_in_out((value-start)/(fin-start));
	}
}