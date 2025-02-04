if (screenshot_mode) {
	if (lifespan <= 20080) {
		screen_save(working_directory + "screenshots\\shot_" + string_repeat("0", 4-len(string(lifespan))) + string(lifespan) + ".png");
	} else {
		game_end();
	}
}