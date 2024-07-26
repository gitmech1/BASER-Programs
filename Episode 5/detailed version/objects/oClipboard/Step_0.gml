if (place_meeting(x, y, oRock)) && !(touched) {
	clipboard_set_text([pull("0"), pull("1"), pull("2"), pull("3"), pull("4"), pull("5")]);
	touched = true;
}