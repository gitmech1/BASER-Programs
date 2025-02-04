//game starts
oInfo.player_amount = players_connected;
oInfo.padding = paddings[players_connected-1];
oInfo.make_players(player_device, player_choice);
oInfo.placements = [];
for (var i = 0; i < players_connected; i++) {
	array_push(oInfo.placements, -1);
}