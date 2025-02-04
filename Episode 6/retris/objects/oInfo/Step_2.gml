if (screenshot_mode) {
	screen_save(working_directory + "screenshots\\shot_" + string_repeat("0", 4-len(string(lifespan))) + string(lifespan) + ".png");
}