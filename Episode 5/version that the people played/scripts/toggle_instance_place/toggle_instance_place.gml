// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function toggle_instance_place(xx, yy, obj){
	var collider = instance_place(xx, yy, oWall);
	if (collider != noone) {
		if (object_name(collider) == "oToggle") {
			if (collider.state != collider.col) {
				collider = noone;
			}
		}
	}
	return collider;
}