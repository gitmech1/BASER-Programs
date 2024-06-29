if (image_index == 1) {
	if (len(text) < 36) {
		var pressed = get_keyboard_pressed();
		for (var i = 0; i < len(pressed); i++) {
			text += string_lower(pressed[i]);
			if (len(text) % 12 == 0) {
				text += "\n";
			}
		}
	}
	
	if (keyboard_check_pressed(vk_enter)) {
		if (text != "") && !(in_save(text)) {
			oInfo.player_name = text;
			oInfo.lifespan = 0;
			room_goto_next();
		}
	}
}