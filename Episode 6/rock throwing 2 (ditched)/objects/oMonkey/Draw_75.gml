var value2 = bounce(clamp(end_timer-200, 0, 100)/80);

if (end_timer) {
	draw_sprite(sDoor, 0, 0, 800-800*value2);
	draw_sprite(sDoor, 1, 0, -800+800*value2);
	
	/*if (end_timer == 187) {
		audio_play_sound(sBetterMetal, 1000, false, 1);
	} else if (end_timer == 214) {
		audio_play_sound(sBetterMetal, 1000, false, 0.5);
	} else if (end_timer == 225) {
		audio_play_sound(sBetterMetal, 1000, false, 0.25);
	} else if (end_timer == 229) {	
		audio_play_sound(sBetterMetal, 1000, false, 0.125);
	}*/
}