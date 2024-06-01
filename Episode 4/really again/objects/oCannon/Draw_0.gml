//drawing of the me
var tl = convert_to_2d([x+75, y-75, 128]);
var br = convert_to_2d([x-75, y+75, 128]);
var m = convert_to_2d([x, y, 128]);

var sizing = abs(tl[0]-br[0]);

draw_sprite_ext(sprite_index, 1, avg([tl[0], br[0]]), br[1]+(size-1)*sizing/1.5, sizing/150, sizing/150, 0, -1, 1); //back
draw_sprite_ext(sprite_index, size+1, avg([tl[0], br[0]]), br[1], sizing/150, sizing/150, 0, oInfo.colours[assigned_rock][1], 1); //front
draw_sprite_ext(sprite_index, 0, avg([tl[0], br[0]]), br[1], sizing/150, sizing/150, 0, -1, 1); //wheels
