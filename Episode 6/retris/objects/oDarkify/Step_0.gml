for (var i = 0; i < len(to_do); i++) {
	to_do[i][0]++;
	if (to_do[i][0] > to_do[i][1]) {
		array_delete(to_do, i, 1);
		i--;
	}
}