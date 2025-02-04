if (room == Start) {
	//movement of every connected player
	for (var i = 0; i < len(player_device); i++) {
		var guy = player_device[i];
	
		if (guy != noone) {
			if (guy == "keyboard") { //keyboard
				var vert = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
				var yup = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
				var nup = keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_backspace);
			} 
			else { //conmtroler
				var raw_vert = gamepad_axis_value(guy, gp_axislv);
				var vert = (abs(raw_vert) > 0.7 && abs(past_verts[i]) <= 0.7) * sign(raw_vert)  +  gamepad_button_check_pressed(guy, gp_padd) - gamepad_button_check_pressed(guy, gp_padu);
				var yup = gamepad_button_check_pressed(guy, gp_face1);
				var nup = gamepad_button_check_pressed(guy, gp_face2); //might be wrong
			}
		
			//up and down
			if (vert != 0) && (player_clicked[i] == 0) {
				player_hover[i] += vert;
				sfx(toggle_b, 800, false, 1, 0.1);
			
				if (player_hover[i] = -1) {
					player_hover[i] = 4;
					player_slow_hover[i] += 5;
				} else if (player_hover[i] = 5) {
					player_hover[i] = 0;
					player_slow_hover[i] -= 5;
				}
			}
		
			//clicking
			if (yup) {
				if (player_clicked[i] == 0) && !(array_contains(player_choice, player_hover[i])) {
					player_clicked[i] = 1;
					player_choice[i] = player_hover[i];
					sfx(player_select, 999, false, 1, 0.07);
					sfx(toggle_b, 800, false, 1, 0.1);
				}
			}
		
			if (nup) {
				if (player_clicked[i] > 2) && (countdown > 0) {
					player_clicked[i] = 0;
					player_choice[i] = -1;
					sfx(toggle_b, 800, false, 1, 0.1);
				}
			}
		
			//keep up with the times
			if (guy != "keyboard") { //storing past move for controller
				past_verts[i] = raw_vert; 
			}
			player_slow_hover[i] = lerp(player_slow_hover[i], player_hover[i], 0.15); //lerp selection to correct spot
			if (player_clicked[i] > 0) && (player_clicked[i] < 21) { //flash when click
				player_clicked[i]++;
			}
		}
	}


	//getting all devices connected
	for (var i = 0; i < len(players_not_connected); i++) {
		var guy = players_not_connected[i];
		if (guy == "keyboard" && keyboard_check_pressed(vk_space)) || (guy != "keyboard" && gamepad_button_check_pressed(guy, gp_face1)) { //checking to see if an input is made
			player_device[players_connected] = guy;
			array_find_and_kill(players_not_connected, guy);
			player_hover[players_connected] = irandom_range_exclusion(0, 4, player_hover);
			player_slow_hover[players_connected] = player_hover[players_connected];
		
			players_connected++;
		}
	}
}


//checking to see if everyone ready
if (room == Start) {
	if (players_connected >= player_min) {
		var check = true;
		for (var i = 0; i < len(player_device); i++) {
			if (player_device[i] != noone) {
				if (player_choice[i] == -1) {
					check = false;
				}
			}
		}
	} else {
		check = false;
	}
} else {
	var check = true;
}

if (check) {
	countdown--;
	if (countdown <= -60) && (room == Start) {
		room_goto(Room1);
		alarm[0] = 1;
	}
	if (countdown == 0) {
		oMusic.music(noone, 90, 0);
	}
} else {
	countdown = 120;
}

lifespan++;