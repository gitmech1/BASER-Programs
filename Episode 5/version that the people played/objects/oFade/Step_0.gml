if (place_meeting(x, y, oRock)) {
	oRock.yvel -= ((300-pythag(x, y, oRock.x, oRock.y))/300)*1.5;
}