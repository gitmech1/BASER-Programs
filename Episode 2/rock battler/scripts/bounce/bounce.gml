// scrip
function bounce(n) { //so much brute force :(
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