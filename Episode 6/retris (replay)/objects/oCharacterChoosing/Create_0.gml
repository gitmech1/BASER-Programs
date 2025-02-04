player_device = [noone, noone, noone, noone, noone];
players_not_connected = ["keyboard", 0, 1, 2, 3];
players_connected = 0;
player_choice = [-1, -1, -1, -1, -1];
player_clicked = [0, 0, 0, 0, 0];
player_hover = [-1, -1, -1, -1, -1]; //actual
player_slow_hover = array_clone(player_hover); //visual

positions = [300, 790, 1280, 1770, 2260];
past_verts = [0, 0, 0, 0, 0];

height = 930; //height of each thingy
width = 400; //width of the thingy
centre = 520;
text_height = 850;

lifespan = 0;
countdown = 120;

player_min = 1;


oMusic.music(flutey);


function draw_sprite_specific(sprite, subimg, xx, yy, i) {
	draw_sprite(sprite, subimg, xx, yy); //top
	
	if (player_clicked[i] > 0) { //white
		draw_sprite_ext(sIcons, 6, xx, yy, 1, 1, 0, -1, 0.2);
	}
	else if (array_contains(player_choice, subimg-1)) && (player_choice[i] != subimg-1) { //black
		draw_sprite_ext(sIcons, 7, xx, yy, 1, 1, 0, -1, 0.3);
	}
}