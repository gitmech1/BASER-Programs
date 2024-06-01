if (oInfo.fighting) {
	if (string_char_at(oInfo.sequence1, sequence_spot+1) == "1") {
		draw_sprite_ext(sArrow, 0, x, y, 2-sequence_cooldown/20, 2-sequence_cooldown/20, angle-90, -1, 0.5-sequence_cooldown/40);
	} else if (string_char_at(oInfo.sequence1, sequence_spot+1) == "2") {
		oFakePlayer1.preshoot = max(0, 20/oInfo.spd-sequence_cooldown);
	}
}