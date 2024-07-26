action = [false];

if (todo) {
	x = oRockStart.x;
	y = oRockStart.y;
	
	if !(oInfo.automatic) {
		push(string(oInfo.rooms), positions);
	}
	
	positions = [];
	oInfo.rooms++;
	if (oInfo.automatic) {
		oInfo.past_record = pull(string(oInfo.rooms));
	}
	oInfo.lifespan = 0;
	if (oInfo.rooms == 1) {
		oInfo.tex = "practice area";
		oInfo.in = 300;
	} else if (oInfo.rooms == 2) {
		oInfo.tex = "it is timed now\nGO FAST";
		oInfo.in = 300;
	}

	todo = false;
}

snatch_controls();
state();
hit_stuff();
if (room != TheEnd) {
	log_controls();
}