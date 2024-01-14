draw_set_font(font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (lifespan == 240) {
	audio_play_sound(sBwouw, 1001, false);
}

var clam = clamp(lifespan-60, 0, 60)/60;
var scale = (clam+0.35)*1.8;
var rotation = clam*360;
var startx = 2560/2;
var endx = 2560-string_width("- " + oInfo.colour_name + "'s Turn -")*0.315-30;
var xpos = endx - (endx-startx)*clam;
var ypos = 60 - (60-1440/2)*clam;

var nl = min(40, 240-lifespan);
var nla = -0.000625*power(nl, 2) + 0.05*nl;

draw_border_text(xpos, ypos, "- " + oInfo.colour_name + "'s Turn -", -1, 999999, scale*nla, scale*nla, scale*2+1.5, rotation+nla*720, oInfo.rock_colour, oInfo.rock_comp_colour, 1*nl/40, true);

lifespan--;