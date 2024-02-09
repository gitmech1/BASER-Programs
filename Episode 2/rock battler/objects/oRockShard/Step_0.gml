yvel += oInfo.grv;

//Horizontal Collision
if (place_meeting(x+xvel, y, oWall)) || (place_meeting(x+xvel, y, oPlayer1)) {
	while (!place_meeting(x+sign(xvel), y, oWall)) && (!place_meeting(x+sign(xvel), y, oPlayer1)) {
		x += sign(xvel);
	}
	xvel = -xvel*0.5;
}

//Vertical Collision
if (place_meeting(x, y+yvel, oFloor)) || (place_meeting(x, y+yvel, oPlayer1)) {
	while (!place_meeting(x, y+sign(yvel), oFloor)) && (!place_meeting(x, y+sign(yvel), oPlayer1)) {
		y += sign(yvel);
	}
	yvel = -yvel*0.4;
	xvel = xvel*0.6;
}

x += xvel;
y += yvel;