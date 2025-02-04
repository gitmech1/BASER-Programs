if (lifespan >= talk_points[5]+start) && !(selected) && (lifespan >= start2) {
	get_controls();
	
	if (select) && (lifespan >= start2+100) {
		selected = 1;
		shake = 50;
		sfx(purchase, 1000, false, 1, 0.1);
		sfx(die_flash);
		if (instance_exists(oMusic)) {
			oMusic.music(noone);
		}
		
		create_split_surfaces();
	}
	else {
		if (cursor_x != clamp(cursor_x+move, 0, 3)) && (move != 0) {
			sfx(toggle_b, 5, false, 0.7, 0.1);
		}
		cursor_x = clamp(cursor_x+move, 0, 3);
	}
}


if (lifespan >= start2) {
	real_cursor_x = lerp(real_cursor_x, cursor_x, 0.2);
}

if (selected) {
	selected++;
	
	if (selected == 750) {
		sfx(characterunlock, 1000023498237823789234798872378923487932, false);
	}
}
shake = max(0, shake/1.05-0.05);

lifespan++;






















