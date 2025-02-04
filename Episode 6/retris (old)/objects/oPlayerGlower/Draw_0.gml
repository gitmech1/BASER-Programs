if (player.pause) {
	if (player.pause <= 15 && player.pause >= 11) || (player.pause <= 5 && player.pause >= 1) {
		rows = player.lines_removed;
		visibility = 1;
	}
}

if (visibility > 0) {
	for (var i = 0; i < len(player.lines_removed); i++) {
		var spot = rows[i];
		draw_set_alpha(visibility);
		draw_rectangle_color_simple(player.x+player.shake_x, player.y+oInfo.square_size*(spot+1)+player.shake_y, player.x+oInfo.w+player.shake_x, player.y+oInfo.square_size*(spot)-1+player.shake_y, c_white); 
		draw_set_alpha(1);
	}
}

visibility = max(0, visibility/1.2-0.01);