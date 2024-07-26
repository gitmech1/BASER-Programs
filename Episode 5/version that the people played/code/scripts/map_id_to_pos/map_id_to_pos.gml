// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function map_id_to_pos(width, height, thick){
	var points = [];
	var c = 0; //counter
	var xshift = 0; //relative to thickness
	var yshift = 0;

	array_push(points, [0, 0]); //tl
	c++;
	for (var i = 0; i < width-1; i++) { //top
		xshift++;
		array_push(points, [xshift*thick, 0]);
		c++;
	}
	array_push(points, [thick*width, 0]); //tr
	c++;
	for (var i = 0; i < height-1; i++) { //right
		yshift++;
		array_push(points, [thick*width, yshift*thick]);
		c++;
	}
	array_push(points, [thick*width, thick*height]); //br
	c++;
	for (var i = 0; i < width-1; i++) { //top
		array_push(points, [xshift*thick, thick*height]);
		c++;
		xshift--;
	}
	array_push(points, [0, thick*height]); //bl
	c++;
	for (var i = 0; i < height-1; i++) { //left
		array_push(points, [0, yshift*thick]);
		c++;
		yshift--;
	}
	
	return points;
}