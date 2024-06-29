state = false; //false == yellow, true == green
children = []; //all toggle blocks linked to this guy

lifespan = 1;


update_state = function() {
	state = !state;
	for (var i = 0; i < len(children); i++) {
		children[i].desired_state = state;
	}
}