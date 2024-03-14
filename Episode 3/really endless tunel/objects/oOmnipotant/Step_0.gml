if (keyboard_check_pressed(vk_space)) {
	if (room_get_name(room) == "Rainbow") {
		room_goto_next();
	} else {
		room_goto_previous();
	}
	black = 1;
}