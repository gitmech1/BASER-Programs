if (automatic) {
	if (lifespan%tempo == 0) {
		update_state("all");
	}
}

if (pressed) {
	pressed--;
}
lifespan++;