// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function convert_to_2d(xyz){
	var xx = xyz[0] + 0.001 - o3D.xpos;
	var yy = xyz[1] + 0.001 - o3D.ypos;
	var zz = xyz[2] + 0.001 - o3D.zpos;
	
	return [xx*o3D.d/(zz/10) + room_width/2, yy*o3D.d/(zz/10) + room_height/2];
}