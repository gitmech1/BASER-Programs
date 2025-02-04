// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function piece_rotated(piece, rotation) {
	var new_piece = [];
	for (var i = 0; i < len(oInfo.pieces[piece][0]); i++) {
		array_push(new_piece, oInfo.pieces[piece][0][i][rotation]);
	}
	return new_piece;
}