var value = min(max(0, start_timer-60)/60, 1);

if !(end_timer) {
	draw_sprite(sDoor, 0, 0, 800-800*value);
	draw_sprite(sDoor, 1, 0, -800+800*value);
}