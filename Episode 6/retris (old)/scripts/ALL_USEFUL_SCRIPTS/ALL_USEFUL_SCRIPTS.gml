//BASIC =========================================================================================================================

function len(thing){ //finds the length of different data types
	if typeof(thing) == "number" {
		return string_length(string(thing));
	} else if typeof(thing) == "string" {
		return string_length(thing);
	} else if typeof(thing) == "array" {
		return array_length(thing);
	} else if typeof(thing) == "struct" {
		return struct_names_count(thing);
	}
}

function msg(words){ //shortened show_debug_message
	show_debug_message(words);
}

function sfx(index, priority, loop, gain=1, offset=0, pitch=1){ //shortened audio_play_sound
	audio_play_sound(index, priority, loop, gain, offset, pitch);
}

function add_to_array(array, values){ //adds list of values to array
	for (var njldfs = 0; njldfs < len(values); njldfs++) {
		array_push(array, values[njldfs]);
	}
}

function array_find_and_kill(array, value) { //finds specific value in array, and kills it
	for (var i = len(array)-1; i >= 0; i--) {
		if (array[i] == value) {
			array_delete(array, i, 1);
		}
	}
}

function array_clone(array) {
	var new_array = [];
	array_copy(new_array, 0, array, 0, len(array));
	return new_array;
}

function array_create_layered(size, size_in, value) {
	var array = array_create_ext(3, function(size_in, value){
		return array_create(size_in, value);
	});
	return array;
}

function array_make(value, amount) {
	var list = [];
	for (var i = 0; i < amount; i++) {
		array_push(list, value);
	}
	return list;
}

function array_min(array) {
	var lowest = infinity;
	for (var i = 0; i < len(array); i++) {
		if (array[i] < lowest) {
			lowest = array[i];
		}
	}
	return lowest;
}

function array_max(array) {
	var highest = -infinity;
	for (var i = 0; i < len(array); i++) {
		if (array[i] > highest) {
			highest = array[i];
		}
	}
	return highest;
}

function array_sum(array) {
	var total = 0;
	for (var i = 0; i < len(array); i++) {
		total += array[i];
	}
	return total;
}

function array_multiply(array, multiplier, dimensions) { //unadequate coding tech bcoz idk how to do it differently
	var list = array_clone(array);
	if (dimensions == 1) {
		for (var i = 0; i < len(list); i++) {
			list[i] *= multiplier;
		}
	} else if (dimensions == 2) {
		for (var i = 0; i < len(list); i++) {
			for (var j = 0; j < len(list[i]); j++) {
				list[i][j] *= multiplier;
			}
		}
	} else if (dimensions == 3) {
		for (var i = 0; i < len(list); i++) {
			for (var j = 0; j < len(list[i]); j++) {
				for (var k = 0; k < len(list[i][j]); k++) {
					list[i][j][k] *= multiplier;
				}
			}
		}
	}
	return list;
}

//structure eg; array_combine([[1, 2, 3, 4], [5, 6, 7]], [0, 2]);
function array_combine(arrays, positions) {
	//finding left and right
	var left = array_min(positions);
	var right = 0;
	for (var i = 0; i < len(arrays); i++) {
		if (len(arrays[i])+positions[i] > right) {
			right = len(arrays[i])+positions[i];
		}
	}
	//making base list
	var base = [];
	for (var i = left; i < right; i++) {
		array_push(base, 0);
	}
	//adding all to thingy
	for (var arr = 0; arr < len(arrays); arr++) {
		var array = arrays[arr];
		for (var i = 0; i < len(array); i++) {
			base[i+positions[arr]] += array[i]
		}
	}
	return base;
}

function array_count(array, value) {
	var count = 0;
	for (var i = 0; i < len(array); i++) {
		if (array[i] == value) {
			count++;
		}
	}
	return count;
}

//structure eg; array_combine_2d([[[1, 2, 3], [3, 2, 4], [5, 1, 1]], [[5, 6], [7, 9]]], [[0, 1], [2, 3]]);
function array_combine_2d(arrays, positions) { //assumes everything is rectangular
	/*fixing stupid gamemaker issue
	var arrays = [];
	for (var i = 0; i < len(old_arrays); i++) {
		var temp1 = [];
		for (var j = 0; j < len(old_arrays[i]); j++) {
			var temp2 = [];
			for (var k = 0; k < len(old_arrays[i][j]); k++) {
				array_push(temp2, old_arrays[i][j][k]);
			}
			array_push(temp1, temp2);
		}
		array_push(arrays, temp1);
	}*/
	
	//finding bounds
	var left = infinity;
	var top = infinity;
	var right = -infinity;
	var bottom = -infinity;
	for (var i = 0; i < len(positions); i++) {
		var xx = positions[i][0];
		var yy = positions[i][1];
		if (xx < left) { //left
			left = xx;
		}
		if (yy < top) { //top
			top = yy
		}
		if (xx+len(arrays[i][0]) > right) { //right
			right = xx+len(arrays[i][0]);
		}
		if (yy+len(arrays[i]) > bottom) { //bottom
			bottom = yy+len(arrays[i]);
		}
	}
	//make base
	var base = [];
	for (var i = top; i < bottom; i++) {
		var temp_base = [];
		for (var j = left; j < right; j++) {
			array_push(temp_base, 0);
		}
		array_push(base, temp_base);
	}
	//add em all together
	for (var arr = 0; arr < len(arrays); arr++) {
		var xx = positions[arr][0];
		var yy = positions[arr][1];
		for (var i = 0; i < len(arrays[arr]); i++) {
			base[yy+i-top] = array_combine([base[yy+i-top], arrays[arr][i]], [left, xx]);
		}
	}
	return base;
}

function array_create_2d(iSize, jSize, value=0) { //frostycat u r the best
    var result = array_create(iSize);
    for (var i = iSize-1; i >= 0; --i) {
        result[i] = array_create(jSize, value);
    }
    return result;
}

function ldx(lenn, dirr){ //lengthdir_x
	return lengthdir_x(lenn, dirr);
}

function ldy(lenn, dirr){ //lengthdir_y
	return lengthdir_y(lenn, dirr);
}

function image_scale(num){
	image_xscale = num;
	image_yscale = num;
}

function reverse_lerp(val1, val2, number) {
	return (number-val1)/(val2-val1);
}

function round_dp(num, dp) {
	return round(num*power(10, dp))/power(10, dp);
}

function point_rectangle(px, py, x1, y1, x2, y2) { //checks whether point in rectngle, but flips if in wrong bounds
	var temp = 0;
	if (x2 < x1) {
		temp = x1;
		x1 = x2;
		x2 = temp;
	}
	if (y2 < y1) {
		temp = y1;
		y1 = y2;
		y2 = temp;
	}
	return point_in_rectangle(px, py, x1, y1, x2, y2);
}

function dot_product_more(x1, y1, x2, y2, px, py) {
    var line_length = pythag(x1, y1, x2, y2);
    return ((px-x1)*(x2-x1)+(py-y1)*(y2-y1)) / power(line_length, 2);
}

function line_point(px, py, x1, y1, x2, y2, buffer=0.1) {
    var line_length = pythag(x1, y1, x2, y2);
    var d1 = pythag(px, py, x1, y1);
    var d2 = pythag(px, py, x2, y2);

    if (d1+d2 >= line_length-buffer and d1+d2 <= line_length+buffer) {
        return true;
	}
    return false;
}

function rectangle_point(px, py, x1, y1, x2, y2) {
    if (x1 > x2) {
		var temp = x1;
		x1 = x2;
        x2 = temp;
	}
	if (y2 > y1) {
        var temp = x1;
		x1 = x2;
        x2 = temp;
	}
        
    if (px >= x1) and (px <= x2) and (py <= y1) and (py >= y2) {
        return true;
	}
    return false;
}

function circle_point(px, py, cx, cy, r) {
    if pythag(px, py, cx, cy) <= r {
        return true;
	}
    return false;
}

function circle_circle(cx1, cy1, r1, cx2, cy2, r2) {
    var dist = pythag(cx1, cy1, cx2, cy2);
    if (dist < r1+r2) {
        return true;
	}
    return false;
}

function circle_line(cx, cy, r, x1, y1, x2, y2) {
    var inside1 = circle_point(x1, y1, cx, cy, r);
    var inside2 = circle_point(x2, y2, cx, cy, r);
    if (inside1 or inside2) {
        return true;
	}
        
    var dot = dot_product_more(x1, y1, x2, y2, cx, cy);
	
    var closest_x = x1 + dot*(x2-x1);
    var closest_y = y1 + dot*(y2-y1);

    if (not line_point(closest_x, closest_y, x1, y1, x2, y2)) {
        return false;
	}
        
    return circle_point(closest_x, closest_y, cx, cy, r);
}

function sa(str, ind, replacement){ //replace guy in list with new guy
	var newstr = string_delete(str, ind+1, 1);
	newstr = string_insert(replacement, newstr, ind+1);
	return newstr;
}

function string_capitalise(str) { //capitalises the first letter (doesn't work with many words)
	var tempstr = string_char_at(str, 1); // return the first character of the string
	tempstr = string_upper(tempstr);    // make the character uppercase

	str = string_delete(str, 1, 1);   // delete the first (lowercase) character
	str = string_insert(tempstr, str, 1) // insert the uppercase character into the original string
	
	return str
}

function object_name(object) { //gets the physcial name of objecto
	return object_get_name(object.object_index);
}

function triangle(n, factor=1) {
	var flore = floor((n/factor)%2);
	return (((n/factor)%1) * (flore*-2+1) + flore)*2-1;
}

function between(n, low, high, inclusive=true) {
	if (inclusive) {
		return (n >= low) && (n <= high);
	} else {
		return (n > low) && (n < high);
	}
}

function irandom_range_exclusion(x1, x2, array_of_numbers_to_exclude) {
	var random_num = irandom_range(x1, x2);
	while (array_contains(array_of_numbers_to_exclude, random_num)) {
		var random_num = irandom_range(x1, x2);
	}
	return random_num;
}

function weighted_random(weights) {
	var multiplier = array_sum(weights);
	var num = random_range(0, 1);
	var total = 0;
	for (var i = 0; i < len(weights); i++) {
		total += weights[i];
		if (num <= total/multiplier) {
			return i;
		}
	}
	return len(weights-1); //should never happen, just in case
}

function frames_to_time(frames, fpss) {
	var seconds = string(floor(frames/fpss) % 60);
	var minutes = string(floor(frames/fpss/60) % 99);
	seconds = string_repeat("0", 2-len(seconds)) + seconds;
	minutes = string_repeat("0", 2-len(minutes)) + minutes;
	return minutes + ":" + seconds
}


//DRAWING =========================================================================================================================

function draw_border_triangle(x1, y1, x2, y2, x3, y3, width, bordercol, insidecol){ //draws triangle with border
	draw_triangle_color(x1, y1, x2, y2, x3, y3, insidecol, insidecol, insidecol, false);
	draw_line_width_color(x1, y1, x2, y2, width, bordercol, bordercol); //line 1
	draw_line_width_color(x2, y2, x3, y3, width, bordercol, bordercol); //line 2
	draw_line_width_color(x3, y3, x1, y1, width, bordercol, bordercol); //line 3
}

function draw_rectangle_color_simple(x1, y1, x2, y2, col, outline=false) {
	draw_rectangle_color(x1, y1, x2, y2, col, col, col, col, outline);
}

function draw_triangle_color_simple(x1, y1, x2, y2, x3, y3, col, outline=false) {
	draw_triangle_color(x1, y1, x2, y2, x3, y3, col, col, col, outline);
}

function draw_rectangle_borders(x1, y1, x2, y2, w, col) {
	draw_line_width_color(x1, y1, x2, y1, w, col, col); //top
	draw_line_width_color(x1, y2, x2, y2, w, col, col); //bottom
	draw_line_width_color(x1, y1, x1, y2, w, col, col); //left
	draw_line_width_color(x2, y1, x2, y2, w, col, col); //right
}

function draw_border_rectangle(x1, y1, x2, y2, width, bordercol, insidecol){
	var temp = 0;
	if (x2 < x1) {
		temp = x1;
		x1 = x2;
		x2 = temp;
	}
	if (y2 < y1) {
		temp = y1;
		y1 = y2;
		y2 = temp;
	}
	
	draw_rectangle_color(x1, y1, x2, y2, insidecol, insidecol, insidecol, insidecol, false);
	for (var r = 0; r < width; r++) {
		draw_rectangle_color(x1+r, y1+r, x2-r, y2-r, bordercol, bordercol, bordercol, bordercol, true);	
	}
}

function draw_border_text(_x, _y, _string, _sep, _w, _xscale, _yscale, _width, _angle, _insidecol, _bordercol, _alpha, extra=false){ //draw text with a border
	//corners
	draw_text_ext_transformed_color(_x+_width, _y+_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	draw_text_ext_transformed_color(_x+_width, _y-_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	draw_text_ext_transformed_color(_x-_width, _y+_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	draw_text_ext_transformed_color(_x-_width, _y-_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	if (extra) {
		//sides if cheeky
		draw_text_ext_transformed_color(_x+_width, _y, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
		draw_text_ext_transformed_color(_x, _y-_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
		draw_text_ext_transformed_color(_x, _y+_width, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
		draw_text_ext_transformed_color(_x-_width, _y, _string, _sep, _w, _xscale, _yscale, _angle, _bordercol, _bordercol, _bordercol, _bordercol, _alpha);
	}
	//normal one
	draw_text_ext_transformed_color(_x, _y, _string, _sep, _w, _xscale, _yscale, _angle, _insidecol, _insidecol, _insidecol, _insidecol, _alpha);
}

function draw_border_sprite(obj, index, xx, yy, col, width, xscale = 1, yscale = 1, rot = 0, alpha = 1){ //draws simple border around object
	draw_sprite_ext(obj, index, xx+width, yy+width, xscale, yscale, rot, col, alpha);
	draw_sprite_ext(obj, index, xx+width, yy-width, xscale, yscale, rot, col, alpha);
	draw_sprite_ext(obj, index, xx-width, yy+width, xscale, yscale, rot, col, alpha);
	draw_sprite_ext(obj, index, xx-width, yy-width, xscale, yscale, rot, col, alpha);
	draw_sprite_ext(obj, index, xx, yy, xscale, yscale, rot, col, alpha);
}

function draw_shape(points, color, width, wrap_back){ //draws big shape with points (dont tknow how to fill please hel)
	//outline
	for (var i = 0; i < len(points)-1+wrap_back; i++) {
		var x1 = points[i][0];
		var y1 = points[i][1];
		var x2 = points[(i+1)%len(points)][0];
		var y2 = points[(i+1)%len(points)][1];
		draw_line_width_color(x1, y1, x2, y2, width, color, color);
	}
}

function draw_line_edges(x1, y1, x2, y2, w, col1, col2) {
	draw_circle_color(x1, y1, w/2, col1, col1, false);
	draw_circle_color(x2, y2, w/2, col2, col2, false);
	draw_line_width_color(x1, y1, x2, y2, w, col1, col2);
}


//MATHS =========================================================================================================================

function remainder(bignum, lilnum){ //returns the remainder (same as python %)
	var tempnum = bignum;
	var countnum = 0;
	while (tempnum >= 0) {
		tempnum -= lilnum;
		countnum++;
	}
	countnum--;
	return bignum-(lilnum*countnum);
}

function avg(list) {
	var sum_total = 0;
	for (var i = 0; i < len(list); i++) {
		sum_total += list[i];
	}
	return sum_total/len(list);
}

function pythag(x1, y1, x2, y2){ //pythagoras theorem
	return sqrt(sqr(x1-x2) + sqr(y1-y2));
}

function pythag_3d(x1, x2, y1, y2, z1, z2){ //pythagoras in the THIRD DIMENSION
	return sqrt(sqr(x1-x2) + sqr(y1-y2) + sqr(z1-z2));
}

function triangle_3d_vector(x1, y1, z1, x2, y2, z2, x3, y3, z3, flip=false){ //calculates the normal vector of a 3d triangle
	//for clarification i have literally no idea how this works
	var dx = x2-x1;
	var dy = y2-y1;
	var dz = z2-z1;
	var ex = x3-x2;
	var ey = y3-y2;
	var ez = z3-z2;
	
	if (flip) {
		var cx = ey * dz - ez * dy;
		var cy = ez * dx - ex * dz;
		var cz = ex * dy - ey * dx;
	} else {
		var cx = dy * ez - dz * ey;
		var cy = dz * ex - dx * ez;
		var cz = dx * ey - dy * ex;
	}
	
	var xzangle = (-point_direction(0, 0, cx, cz)+90) % 360;
	var yangle = darctan(cy / pythag(0, 0, cx, cz));
	
	return [xzangle, yangle];
}

function perlin_noise(_x, _y = 100.213, _z = 450.4215) { //generates perlin_noise in 1, 2 or 3 dimensions
	
	//from (https://github.com/samspadegamedev/YouTube-Perlin-Noise-Public/blob/main/scripts/perlin_noise_script_functions/perlin_noise_script_functions.gml)
	
	#region //doubled perm table
	static _p = [
		151,160,137,91,90,15,
		131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
		190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
		88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
		77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
		102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
		135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
		5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
		223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
		129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
		251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
		49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
		138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180,
		151,160,137,91,90,15,
		131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
		190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
		88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
		77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
		102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
		135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
		5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
		223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
		129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
		251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
		49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
		138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180
	];
	#endregion

    static _fade = function(_t) {
        return _t * _t * _t * (_t * (_t * 6 - 15) + 10);
    }

	static _lerp = function(_t, _a, _b) { 
		return _a + _t * (_b - _a); 
	}

    static _grad = function(_hash, _x, _y, _z) {
        var _h, _u, _v;
        _h = _hash & 15;                       // CONVERT 4 BITS OF HASH CODE
        _u = (_h < 8) ? _x : _y;                 // INTO 12 GRADIENT DIRECTIONS.
        if (_h < 4) {
            _v = _y;
        } else if ((_h == 12) || (_h == 14)) {
            _v = _x;
        } else {
            _v = _z;
        }
		if ((_h & 1) != 0) {
			_u = -_u;
		}
		if ((_h & 2) != 0) {
			_v = -_v;
		}		
        return _u + _v;
    }

    var _X, _Y, _Z;
    _X = floor(_x);
    _Y = floor(_y);
    _Z = floor(_z);
    
    _x -= _X;
    _y -= _Y;
    _z -= _Z;
    
    _X = _X & 255;
    _Y = _Y & 255;
    _Z = _Z & 255;
    
    var _u, _v, _w;
    _u = _fade(_x);
    _v = _fade(_y);
    _w = _fade(_z);
    
    var A, AA, AB, B, BA, BB;
    A  = _p[_X]+_Y;
    AA = _p[A]+_Z;
    AB = _p[A+1]+_Z;
    B  = _p[_X+1]+_Y;
    BA = _p[B]+_Z;
    BB = _p[B+1]+_Z;

	//returns a number between -1 and 1
    return _lerp(_w, _lerp(_v, _lerp(_u,_grad(_p[AA  ], _x  , _y  , _z   ),  // AND ADD
										_grad(_p[BA  ], _x-1, _y  , _z   )), // BLENDED
                             _lerp(_u,	_grad(_p[AB  ], _x  , _y-1, _z   ),  // RESULTS
										_grad(_p[BB  ], _x-1, _y-1, _z   ))),// FROM  8
                    _lerp(_v, _lerp(_u,	_grad(_p[AA+1], _x  , _y  , _z-1 ),  // CORNERS
										_grad(_p[BA+1], _x-1, _y  , _z-1 )), // OF CUBE
                             _lerp(_u,	_grad(_p[AB+1], _x  , _y-1, _z-1 ),
										_grad(_p[BB+1], _x-1, _y-1, _z-1 )))); 

}

function dfs(map, xx, yy) { //depth first search
	var to = 2;
	var from = map[# xx, yy];
	
	var fill_q = ds_queue_create();
	ds_queue_enqueue(fill_q, xx, yy);
	
	while(!ds_queue_empty(fill_q)) {
		var tx = ds_queue_dequeue(fill_q);
		var ty = ds_queue_dequeue(fill_q);
		if (tx >= 0 && tx < ds_grid_width(map) && ty >= 0 && ty < ds_grid_height(map)) {
			map[# tx, ty] = to; //replace with new
			
			if (map[# tx+1, ty] == from) {
				ds_queue_enqueue(fill_q, tx+1, ty);
			}
			if (map[# tx-1, ty] == from) {
				ds_queue_enqueue(fill_q, tx-1, ty);
			}
			if (map[# tx, ty+1] == from) {
				ds_queue_enqueue(fill_q, tx, ty+1);
			}
			if (map[# tx, ty+1] == from) {
				ds_queue_enqueue(fill_q, tx, ty-1);
			}
		}
	}
	
	ds_queue_destroy(fill_q);
}


// EASING =========================================================================================================================

function no_ease(n){
	return n;
}

function ease_in(n, p=2){
	return power(n, p);
}

function ease_out(n, p=2){
	return 1 - power(1 - n, p);
}

function ease_in_cubic(n){
	return ease_in(n) * ease_in(n);
}

function ease_out_cubic(n){
	return ease_out(n) * ease_out(n);
}

function ease_in_out(n, p=1.7){
	if (n <= 0.5) {
		return power(2*n, p) / 2;
	} else {
		return 1 - power(2-2*n, p) / 2;
	}
}

function ease_bounce(n) { //bounces in
	var nn = n*0.844;
	if (nn < 0.4) {
		return 6.26*power(nn, 2);
	} else if (nn < 0.683) {
		return 12*power(nn, 2) - 13*nn + 4.28;
	} else if (nn < 0.797) {
		return 25*power(nn, 2) - 37*nn + 14.61;
	} else if (nn < 0.844) {
		return 50*power(nn, 2) - 82*nn + 34.592;
	} else {
		return 1;
	}
}

function ease_in_out_clamp(start, fin, value){ //eases in and out but any higher or lower numbers dont fly around
	if (value < start) {
		return 0;
	} else if (value > fin) {
		return 1;
	} else {
		return ease_in_out((value-start)/(fin-start));
	}
}

function elastic_ease(n, stretch=3) {
	var numerator = -sin(10*(stretch*n+0.26));
    var denominator = 15*power(stretch*n+0.26, 2.5);
    return numerator/denominator + 1;
}


// GENERATE STUFF =========================================================================================================================

function generate_cube(x1, y1, z1, x2, y2, z2, col_p, col_f){ //makes a 3d cube given corners (no rotation)
	var big_list = [];
	
	array_push(big_list, [[[x1, y1, z1], [x1, y2, z1], [x2, y1, z1]], col_p, col_f]); //1
	array_push(big_list, [[[x1, y2, z1], [x2, y2, z1], [x2, y1, z1]], col_p, col_f]); //2
	array_push(big_list, [[[x1, y2, z2], [x1, y2, z1], [x1, y1, z1]], col_p, col_f]); //3
	array_push(big_list, [[[x1, y2, z2], [x1, y1, z2], [x1, y1, z1]], col_p, col_f]); //4
	array_push(big_list, [[[x2, y2, z2], [x1, y2, z2], [x1, y2, z1]], col_p, col_f]); //5
	array_push(big_list, [[[x2, y2, z2], [x2, y2, z1], [x1, y2, z1]], col_p, col_f]); //6
	array_push(big_list, [[[x2, y2, z2], [x2, y2, z1], [x2, y1, z1]], col_p, col_f]); //7
	array_push(big_list, [[[x2, y2, z2], [x2, y1, z2], [x2, y1, z1]], col_p, col_f]); //8
	array_push(big_list, [[[x2, y1, z2], [x2, y1, z1], [x1, y1, z1]], col_p, col_f]); //9
	array_push(big_list, [[[x2, y1, z2], [x1, y1, z1], [x1, y1, z2]], col_p, col_f]); //10
	array_push(big_list, [[[x1, y2, z2], [x2, y1, z2], [x1, y1, z2]], col_p, col_f]); //11
	array_push(big_list, [[[x2, y2, z2], [x1, y2, z2], [x2, y1, z2]], col_p, col_f]); //12
	
	return big_list;
}

function generate_maze(sizex, sizey) { //generates a maze
	function maze_check(map, sizex, sizey) {
		//resets visited
		for (var i = 0; i < sizey; i++) {
			for (var j = 0; j < sizex; j++) {
				if (string_char_at(map[i], j+1) == "1") {
					visited[# j, i] = 1;
				} else {
					visited[# j, i] = 0;
				}
			}
		}
	
	    //check if some parts of map accessable
	    dfs(visited, 1, 1);
	
	    //sweep to see if any squares are false
	    for (var i = 0; i < floor((sizey-1)/2); i++) {
	        for (var j = 0; j < floor((sizex-1)/2); j++) {
	            if (visited[# j*2+1, i*2+1] == false) {
	                return false;
				}
			}
		}
	    return true;
	}
	
	visited = ds_grid_create(sizex*2+1, sizey*2+1);
	
	//make base template
    var temp_maze = [];
    array_push(temp_maze, string_repeat("1", (sizex*2+1)));
    array_push(temp_maze, ("1" + string_repeat("0", (sizex*2-1)) + "1"));
    for (var i = 0; i < sizey-1; i++) {
        array_push(temp_maze, string_repeat("10", (sizex) + "1"));
        array_push(temp_maze, ("1" + string_repeat("0", (sizex*2-1)) + "1"));
	}
    array_push(temp_maze, string_repeat("1", (sizex*2+1)));

    //make walls
    var false_count = 0
    //makes fairly compliczated maze
    while (false_count < 100) {
        var past_maze = [];
		array_copy(past_maze, 0, temp_maze, 0, len(temp_maze)); //wack ass code but it works !!!!!!!!
        //place random wall
        for (var i = 0; i < 100-false_count; i++) {
            //horizontal or vertical choice of wall
            hov = irandom_range(1, 2);
            if (hov == 1) {
                //make wall
                var wallx = irandom_range(0, sizex-2);
                var wally = irandom_range(0, sizey-1);
                temp_maze[wally*2+1] = sa(temp_maze[wally*2+1], wallx*2+2, "1");
			} else {
                //make wall sequel
                var wallx = irandom_range(0, sizex-1);
                var wally = irandom_range(0, sizey-2);
                temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+1, "1");
			}
		}
        if (!maze_check(temp_maze, sizex*2+1, sizey*2+1)) {
            //reset to old
            temp_maze = past_maze;
            //get ever closer to finishing
            false_count++;
		}
	}

    //nail off isolated walls
    for (var wally = 0; wally < sizey-1; wally++) {
        for (var wallx = 0; wallx < sizex-1; wallx++) {
            //if wall isolated
            if string_char_at(temp_maze[wally*2+1], wallx*2+2) == "0" || string_char_at(temp_maze[wally*2+3], wallx*2+2) == "0" || string_char_at(temp_maze[wally*2+2], wallx*2+1) == "0" || string_char_at(temp_maze[wally*2+2], wallx*2+3) == "0" {
                //so no weird chqnnels made
                if (irandom_range(1, 2) == 1) {
                    //left
                    temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+1, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+1, "0");
					}
                    //right
                    temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+3, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+3, "0");
					}
                    //up
                    temp_maze[wally*2+1] = sa(temp_maze[wally*2+1], wallx*2+2, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+1] = sa(temp_maze[wally*2+1], wallx*2+2, "0");
					}
                    //down
                    temp_maze[wally*2+3] = sa(temp_maze[wally*2+3], wallx*2+2, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+3] = sa(temp_maze[wally*2+3], wallx*2+2, "0");
					}
				} else {
                    //up
                    temp_maze[wally*2+1] = sa(temp_maze[wally*2+1], wallx*2+2, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+1] = sa(temp_maze[wally*2+1], wallx*2+2, "0");
					}
                    //down
                    temp_maze[wally*2+3] = sa(temp_maze[wally*2+3], wallx*2+2, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+3] = sa(temp_maze[wally*2+3], wallx*2+2, "0");
					}
                    //left
                    temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+1, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+1, "0");
					}
                    //right
                    temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+3, "1");
                    if not maze_check(temp_maze, sizex*2+1, sizey*2+1) {
                        temp_maze[wally*2+2] = sa(temp_maze[wally*2+2], wallx*2+3, "0");
					}
				}
			}
		}
	}
	//clean up
	ds_grid_destroy(visited);
	
	return temp_maze;
}


// OTHER =========================================================================================================================


function show(msgit) { //drop entire save (put it in chat or return it)
	//actually pulling stuff
	var buffer = buffer_load("savedgame.save");
	var str = buffer_read(buffer, buffer_string);
	buffer_delete(buffer);
		
	//make into data mode
	var struct = json_parse(str);
	
	if (msgit) {
		var names = variable_struct_get_names(struct);
		for (var i = 0; i < len(names); i++) {
			msg(names[i] + ":");
			msg(struct[$ names[i]]);
			msg("");
		}
	} else {
		return struct;
	}
}

function push(keyword, data) {
	//get save stuff
	if (file_exists("savedgame.save")) {
		var struct = pull();
	} else {
		var struct = {};
	}
	
	//add data to ta thingy
	struct[$ keyword] = data;
	
	//convert to a json thingy and push
	var str = json_stringify(struct);
	var buffer = buffer_create(string_byte_length(str) +1, buffer_fixed, 1);
	buffer_write(buffer, buffer_string, str);
	buffer_save(buffer, "savedgame.save");
}

function pull(keyword="NOTHING") {
	if (file_exists("savedgame.save")) {
		//actually pulling stuff
		var buffer = buffer_load("savedgame.save");
		var str = buffer_read(buffer, buffer_string);
		buffer_delete(buffer);
		
		//make into data mode
		var struct = json_parse(str);
		
		//return stuff
		if (keyword == "NOTHING") {
			return struct; //full struct
		} else {
			if (struct_exists(struct, keyword)) { //check if it actually exists
				return struct[$ keyword]; //keyword only
			} else {
				return [];
			}
		}
	}
}

function snap(keyword) {
	if (file_exists("savedgame.save")) {
		//make into data mode
		var struct = pull();
		
		if (struct_exists(struct, keyword)) {
			struct_remove(struct, keyword);
		}
		
		//convert to a json thingy and push
		var str = json_stringify(struct);
		var buffer = buffer_create(string_byte_length(str) +1, buffer_fixed, 1);
		buffer_write(buffer, buffer_string, str);
		buffer_save(buffer, "savedgame.save");
	}
}

function in_save(keyword) {
	if (file_exists("savedgame.save")) {
		var struct = pull();
		
		if (struct_exists(struct, keyword)) {
			return true;
		}
		return false;
	} else {
		return false;
	}
}

function get_keyboard_check() {
	var letters = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
					"A", "S", "D", "F", "G", "H", "J", "K", "L", 
					"Z", "X", "C", "V", "B", "N", "M"];
	var pressed = [];
	for (var i = 0; i < len(letters); i++) {
		if (keyboard_check(ord(letters[i]))) {
			array_push(pressed, letters[i]);
		}
	}
	
	return pressed;
}

function get_keyboard_pressed() {
	var letters = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
					"A", "S", "D", "F", "G", "H", "J", "K", "L", 
					"Z", "X", "C", "V", "B", "N", "M"];
	var pressed = [];
	for (var i = 0; i < len(letters); i++) {
		if (keyboard_check_pressed(ord(letters[i]))) {
			array_push(pressed, letters[i]);
		}
	}
	
	return pressed;
}

function get_keyboard_released() {
	var letters = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
					"A", "S", "D", "F", "G", "H", "J", "K", "L", 
					"Z", "X", "C", "V", "B", "N", "M"];
	var pressed = [];
	for (var i = 0; i < len(letters); i++) {
		if (keyboard_check_released(ord(letters[i]))) {
			array_push(pressed, letters[i]);
		}
	}
	
	return pressed;
}


//ME AFTER WRITING THESE CORRECTLY FIRST TRY
function bin_to_num(bin) { //binary to number, assuming in string form
	var total = 0;
	for (var i = 0; i < len(bin); i++) {
		if (string_char_at(bin, i+1) == "1") {
			total += power(2, len(bin)-1-i);
		}
	}
	return total;
}

//? WE BEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEG
function num_to_bin(num) {
	var length = 0; //finding length of binary thingle
	while (power(2, length) < num) {
		length++;
	}
	//with length comes strength
	var binary_string = "";
	for (var i = 0; i < length; i++) {
		if (num-power(2, length-1-i) >= 0) {
			num -= power(2, length-1-i);
			binary_string += "1";
		} else {
			binary_string += "0";
		}
	}
	return binary_string;
}

function ctc(txt){ //convert to cool
    string_replace(txt, "1", "██");
    string_replace(txt, "0", "░░");
    string_replace(txt, "D", "||");
    string_replace(txt, "t", "tr");
    string_replace(txt, "f", "▀▄");
    string_replace(txt, "B", "QQ");
    string_replace(txt, "=", "==");
    string_replace(txt, "s", "t=");
    string_replace(txt, "c", "CO");
    string_replace(txt, "l", "-c");
    string_replace(txt, "T", "TE");
    string_replace(txt, "b", "BA");
    string_replace(txt, "o", "()");
    string_replace(txt, "L", "LE");
    string_replace(txt, "M", "mm");
    return txt;
}




















