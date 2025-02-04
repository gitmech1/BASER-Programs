//game starts
if (oInfo.game_mode == "replay") {
	players_connected = oInfo.game_data[0][1];
	var names = oInfo.names;
	oInfo.player_amount = players_connected;
	oInfo.make_players_replay(names, oInfo.game_data[1]);
	oInfo.placements = [];
	for (var i = 0; i < players_connected; i++) {
		array_push(oInfo.placements, -1);
	}
}
else {
	oInfo.player_amount = players_connected;
	oInfo.make_players(player_device, player_choice);
	oInfo.placements = [];
	for (var i = 0; i < players_connected; i++) {
		array_push(oInfo.placements, -1);
	}
}