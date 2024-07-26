code = -1;

boings = [] //outness of boing spots of interest
boingvel = [];
boingdeltal = [];
boingdeltar = [];
boinglocked = [];

rep = 4; //specificity of boiung locationms
width = image_xscale*rep;
height = image_yscale*rep;
thick = 64/rep; //thickness of each line (length but who cares)
boingpos = map_id_to_pos(width, height, thick);
for (var i = 0; i < width*2+height*2; i++) {
	array_push(boings, 0); //every outness of point
	array_push(boingvel, 0);
	array_push(boingdeltal, 0);
	array_push(boingdeltar, 0);
	array_push(boinglocked, 0); //0 = none, 1 = block, 2 = slime
}

//locking parts
update_locked = function(j, xshift, yshift) {
	var guy = collision_circle(x+boingpos[j][0]+xshift, y+boingpos[j][1]+yshift, 1, oWall, false, false);
	if (guy != noone) {
		if (object_get_name(guy.object_index) == "oSlime") {
			boinglocked[j] = 2;
		} else {
			boinglocked[j] = 1;
		}
	}
}

for (var i = 0; i < width+1; i++) { //top
	var j = i;
	update_locked(j, 0, -2);
}
for (var i = 0; i < height+1; i++) { //right
	var j = width+i;
	update_locked(j, 2, 0);
}
for (var i = 0; i < width+1; i++) { //bottom
	var j = width+height+i;
	update_locked(j, 0, 2);
}
for (var i = 0; i < height+1; i++) { //left
	var j = (width*2+height+i)%len(boings);
	update_locked(j, -2, 0);
}


//springy stuff
k = 0.035;
d = 0.010;
spread = 0.05;

//when riock hit slimy inedividual
boing = function(xpos, ypos, force) {
	var xfinal = 0;
	var yfinal = 0;
	var ifinal = 0;
	//horizontal finding
	if (xpos <= x) {
		xfinal = 0;
	} else if (xpos > x+thick*width) {
		xfinal = width;
	} else {
		xfinal = round((xpos-x)/thick);
	}
	//vertical finding
	if (ypos <= y) {
		yfinal = 0;
	} else if (ypos > y+thick*height) {
		yfinal = height;
	} else {
		yfinal = round((ypos-y)/thick);
	}
	
	//point finding
	if (yfinal == 0) { //top
		ifinal = xfinal;
	} else if (yfinal == height) { //bottom
		ifinal = width*2+height-xfinal;
	} else if (xfinal == 0) { //left
		ifinal = (width+height)*2-yfinal;
	} else { //left
		ifinal = width+yfinal;
	}
	
	if (boinglocked[ifinal] == 0) {
		boingvel[ifinal] = -abs(force*1.3); //increase 1.3 for infinite fun
	}
}