cubes = [];
sides = [];
dep = 0.25;

function find_cubes() {
	cubes = [];
	for (var i = 0; i < instance_number(oCube); i++) {
		array_push(cubes, instance_find(oCube, i));
	}
}


function sort_sides() {	
	var distance_sorter = function(elm1, elm2) {
		if (instance_exists(oCamera)) {
			var xview = oCamera.x;
			var yview = oCamera.y;
		} else {
			var xview = room_width/2;
			var yview = room_height/2;
		}
	
		return -sign(pythag(elm1[0][0], elm1[0][1], xview, yview) - pythag(elm2[0][0], elm2[0][1], xview, yview))
	}
	
	array_sort(sides, distance_sorter);
}


function generate_sides() {
	sides = [];
	
	
	for (var i = 0; i < instance_number(oCube); i++) {
		with (instance_find(oCube, i)) {
	
			//background 3d
			if (instance_exists(oCamera)) {
				var xview = oCamera.x;
				var yview = oCamera.y;
			} else {
				var xview = room_width/2;
				var yview = room_height/2;
			}

			//1
			// 2
			//      to background
			//3
			// 4

			var x1 = x+oInfo.shakex;
			var y1 = y+oInfo.shakey;
			var x2 = x1+sprite_width;
			var y2 = y1+sprite_height;

			var x3 = lerp(x1, xview, other.dep);
			var y3 = lerp(y1, yview, other.dep);
			var x4 = lerp(x2, xview, other.dep);
			var y4 = lerp(y2, yview, other.dep);

			var wall = #070612;
			var roof = #051823;

			//y
			if (yview < y+oInfo.shakey) {
				//up
				array_push(other.sides, [[avg([x1, x2]), y1], [x1, y1, x2, y1, x3, y3, roof]]);
				array_push(other.sides, [[avg([x1, x2]), y1], [x2, y1, x3, y3, x4, y3, roof]]);
			} else if (yview > y+oInfo.shakey+sprite_height) {
				//down
				array_push(other.sides, [[avg([x1, x2]), y2], [x1, y2, x2, y2, x3, y4, roof]]);
				array_push(other.sides, [[avg([x1, x2]), y2], [x2, y2, x3, y4, x4, y4, roof]]);
			}
			//x
			if (xview < x+oInfo.shakex) {
				//left
				array_push(other.sides, [[x1, avg([y1, y2])], [x1, y1, x1, y2, x3, y3, wall]]);
				array_push(other.sides, [[x1, avg([y1, y2])], [x3, y3, x1, y2, x3, y4, wall]]);
			} else if (xview > x+oInfo.shakex+sprite_width) {
				//right
				array_push(other.sides, [[x2, avg([y1, y2])], [x2, y1, x2, y2, x4, y3, wall]]);
				array_push(other.sides, [[x2, avg([y1, y2])], [x4, y3, x2, y2, x4, y4, wall]]);
			}
		}
	}
}


function draw_sides() {
	for (var i = 0; i < len(sides); i++) {
		draw_triangle_color(sides[i][1][0], sides[i][1][1], sides[i][1][2], sides[i][1][3], sides[i][1][4], sides[i][1][5], sides[i][1][6], sides[i][1][6], sides[i][1][6], false);
	}
}