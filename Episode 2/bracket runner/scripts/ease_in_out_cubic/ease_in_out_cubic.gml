// scrip
function ease_in_out_cubic(n){
	if (n < 0.5) {
		return power(2*n, 4)/2;
	} else {
		return power(2*(1-n), 4)/2;
	}
}