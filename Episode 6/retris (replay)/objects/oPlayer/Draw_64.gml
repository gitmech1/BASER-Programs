/*var orientation = fa_center;
var x_zone = room_width/2;
if (player_id == 0) {
	orientation = fa_left;
	x_zone = 20;
} else if (player_id == 1) {
	orientation = fa_right;
	x_zone = room_width-20;
}

var yea = true;

if (player_id <= 1) && (yea) {

	var yspot = 20;

	yspot += f3_strings("- oINFO", [
		["time 'fore drop", oInfo.time_before_drop],
		["GOOD MODE", oInfo.good_mode], 
		["replay date", oInfo.replay_date], 
		["p count", oInfo.p_count],
		["p step", oInfo.p_step],
		["column step", oInfo.column_step],
		["placements", string_start_of_array(oInfo.placements, 15)]], x_zone, yspot, orientation)[1];

	yspot+=20;
	
	yspot += f3_strings("- UNIQUE STUFF", [
		["lifespan", lifespan],
		["controls", controls], 
		["colour", oInfo.colour_names[colour_id]], 
		["player id", player_id]], x_zone, yspot, orientation)[1];

	yspot+=20;

	yspot += f3_strings("- VARIABLES", [
		["game mode", oInfo.game_mode],
		["hor", hor], 
		["distance wait", distance_wait], 
		["distance", distance], 
		["height", height], 
		["colliding", string(check_piece_colliding(grid, piece_rotated(piece, rotation), distance, height))], 
		["piece", piece], 
		["rotation", rotation],
		["pause", pause],
		["da slam break", slam_break],
		["moves", string_start_of_array(moves, 30)]], x_zone, yspot, orientation)[1];

	yspot+=20;

	yspot += f3_strings("- PLAYER GLOWER", [
		["visibility", glower_guy.visibility], 
		["time left", glower_guy.time_left], 
		["to glow", string_end_of_array(glower_guy.to_glow, 25)], 
		["to glow message", glower_guy.to_glow_message]], x_zone, yspot, orientation)[1];

	yspot+=20;

	/*yspot += f3_strings("- POWERUP STUFF", [
		["global powerup pause", oInfo.powerup_pause], 
		["using", powerup_using], 
		["triggering", powerup_triggering], 
		["lifespan", powerup_lifespan],
		["powerup_x", powerup_x],
		["powerup_y", powerup_y],
		["red selected", red_selected],
		["red given up", red_given_up],
		["height map", string_end_of_array(height_map, 25)],
		["height lifespan", height_lifespan], 
		["height guy", height_guy]], x_zone, yspot, orientation)[1];

	yspot+=20;*//*

	if (oInfo.game_mode == "record") {
		yspot += f3_strings("- RECORDING STUFF", [
			["seed", oInfo.seed],
			["horizontal", string_end_of_array(move_horizontal_list, 25)], 
			["down", string_end_of_array(move_down_list, 25)], 
			["rotate", string_end_of_array(move_rotate_list, 25)],
			["slam", string_end_of_array(move_slam_list, 25)],
			["trash", string_end_of_array(move_trash_list, 25)]], x_zone, yspot, orientation)[1];
	}
	else if (oInfo.game_mode == "replay") {
		yspot += f3_strings("- REPLAYING STUFF", [
			["seed", oInfo.seed],
			["horizontal", string_start_of_array(move_horizontal_list, 25)], 
			["down", string_start_of_array(move_down_list, 25)], 
			["rotate", string_start_of_array(move_rotate_list, 25)],
			["slam", string_start_of_array(move_slam_list, 25)],
			["trash", string_start_of_array(move_trash_list, 25)]], x_zone, yspot, orientation)[1];
	}
	
	
	/*var yspot = 20;

	yspot += f3_2d_array("GRID -", grid, room_width-20, yspot, " ", fa_right, 20)[1];
	yspot+=20;
	yspot += f3_2d_array("COLOURED GRID -", coloured_grid, room_width-20, yspot, " ", fa_right, 20)[1];
	

}*/
/*
else {
	var yspot = 20;

	yspot += f3_strings("- GREEN RECIEVING", [
		["player", pointer_player],
		["spots", string_end_of_array(pointer_spots, 25)]], room_width/2, yspot, fa_center)[1];
}
*/