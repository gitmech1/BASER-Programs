state = desired_state;

//rock checking in the bounds of da area
if (state == col) { //fan is on
	//4 3
	//1 2
	var dist = 400*size;
	var width = 64*size;
	var a = image_angle;
	var x1 = x+ldx(width, a);
	var y1 = y+ldy(width, a);
	var x2 = x+ldx(width, a) + ldx(width*2, a-90);
	var y2 = y+ldy(width, a) + ldy(width*2, a-90);
	var x3 = x+ldx(width+dist, a) + ldx(width*2, a-90);
	var y3 = y+ldy(width+dist, a) + ldy(width*2, a-90);
	var x4 = x+ldx(width+dist, a);
	var y4 = y+ldy(width+dist, a);
	var pow = 250*size/pythag(oRock.x, oRock.y, x+ldx(width, a-90), y+ldy(width, a-90));
	
	if (point_in_triangle(oRock.x, oRock.y, x1, y1, x2, y2, x3, y3) ||
	point_in_triangle(oRock.x, oRock.y, x1, y1, x3, y3, x4, y4)) {
		oRock.xvel += ldx(pow, a);
		oRock.yvel += ldy(pow, a);
	}
}

lifespan++;