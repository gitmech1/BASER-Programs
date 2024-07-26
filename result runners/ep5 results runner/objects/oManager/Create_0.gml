// red: #E73133, #431C1E
// salmon: #F9806B, #7B3E33 (still called him salmon lol)
// orange: #FD9B30, #774012
// tan: #EFE4B9, #6B6552
// lime: #4CF664, #23792E
// green: #277E46, #10331B
// blue: #32C2F7, #186096
// purple: #BB5CF8, #552B7B
// magenta: #F92AF0, #4B132F

colours = [
//name, col1, col2, start, end, spos, epos, eliminted (0 fine, 1 getting, 2 dead)
	["Red",     #E73133, #431C1E, 232, 232, 6, 6, 2],
	["Shrimp",  #F9806B, #7B3E33, 163, 163, 7, 7, 2],
	["Orange",  #FD9B30, #774012, 999, 1099, 1, 3, 0],
	["Tan",     #EFE4B9, #6B6552, 93,  93,  8, 8, 2],
	["Lime",    #4CF664, #23792E, 1067,1567, 0, 2, 0],
	["Green",   #277E46, #10331B, 852, 1652, 2, 1, 0],
	["Blue",    #32C2F7, #186096, 611, 1811, 3, 0, 0],
	["Purple",  #BB5CF8, #552B7B, 327, 327, 5, 5, 2],
	["Magenta", #F92AF0, #4B132F, 592, 892, 4, 4, 1]
]

var sort_list = function(elm1, elm2) {
	return elm1[6] - elm2[6];
}
array_sort(colours, sort_list);

amount = len(colours); //amount of colours included
padding = 200; //edge of screen left barren
size = (1440-2*padding)/amount; //horizontal size

msg(size);

self.archivo = font_add("archivo.ttf", round(size/3), false, false, 32, 127);
self.archivobig = font_add("archivo.ttf", 200, false, false, 32, 127);

max_value = 0;
for (var i = 0; i < len(colours); i++) {
	if (colours[i][4] > max_value) {
		max_value = colours[i][4];
	}
}
max_xvalue = (2100-2*padding) + padding+400;

time_elapsed = 0;

colour_surface = -1;

/*springy stuff
k = 0.035;
d = 0.010;
spread = 0.05;


slimes = [];
for (var i = 0; i < 9; i++) {
	var temp_width = ceil(colours[i][3]*(2100-2*padding)/max_value / 16); //amount x
	var temp_height = ceil(size / 16); //amount y
	var temp_xlength = colours[i][3]*(2100-2*padding)/max_value / temp_width;
	var temp_ylength = size / temp_height;
	var temp_x = 400+padding - ((colours[i][4]-colours[i][3])*(2100-2*padding)/max_value); //ah yes. this line is the most comprehensible.
	var temp_y = padding + size*colours[i][5];
	var zeroez = []; //a list of the appropriate amount of 0s
	for (var j = 0; j < temp_width*2+temp_height*2-4; j++) {
		array_push(zeroez, 0);
	}
	
	array_push(slimes, { //thickness is by default 16
		width: temp_width, //amount on x
		height: temp_height, //amount on y
		xpos: temp_x, //x pos
		ypos: temp_y, //y pos
		point: {
			xspot: zeroez, //x pos of point
			yspot: zeroez, //y pos of point
			facing: zeroez, //normal of point
			boings: zeroez,
			boingvel: zeroez,
			boingdeltal: zeroez,
			boingdeltar: zeroez,
			boinglocked: zeroez
		}
	});
	
	//top
	for (var j = 0; j < temp_width; j++) {
		var p = j;
		slimes[i].point.xspot[p] = slimes[i].xpos + temp_xlength*j; //xpos
		slimes[i].point.yspot[p] = slimes[i].ypos; //ypos
		//facing
		if (j == 0) {
			facing = 135;
		} else if (j == temp_width-1) {
			facing = 45;
		} else {
			facing = 90;
		}
	}
	//right
	for (var j = 0; j < temp_height; j++) {
		var p = j+temp_width-1;
		slimes[i].point.xspot[p] = slimes[i].xpos + temp_xlength*(temp_width-1); //xpos
		slimes[i].point.yspot[p] = slimes[i].ypos + temp_ylength*j; //ypos
		//facing
		if (j == 0) {
			facing = 45;
		} else if (j == temp_width-1) {
			facing = 315;
		} else {
			facing = 0;
		}
	}
	//bottom
	for (var j = 0; j < temp_width; j++) {
		var p = j+temp_width+temp_height-2;
		slimes[i].point.xspot[p] = slimes[i].xpos + temp_xlength*(temp_width-1-j); //xpos
		slimes[i].point.yspot[p] = slimes[i].ypos + temp_ylength*(temp_height-1); //ypos
		//facing
		if (j == 0) {
			facing = 315;
		} else if (j == temp_width-1) {
			facing = 225;
		} else {
			facing = 270;
		}
	}
	//left
	for (var j = 0; j < temp_height; j++) {
		var p = j+temp_width*2+temp_height-3;
		slimes[i].point.xspot[p] = slimes[i].xpos; //xpos
		slimes[i].point.yspot[p] = slimes[i].ypos + temp_ylength*(temp_height-1-j); //ypos
		//facing
		if (j == 0) {
			facing = 225;
		} else if (j == temp_width-1) {
			facing = 135;
		} else {
			facing = 180;
		}
		slimes[i].point.boinglocked[p] = 1; //locked
	}
}*/








































