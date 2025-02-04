lifespan = 0; //2200;

youngster2 = font_add("Youngster.ttf", 80, false, false, 32, 127);
draw_set_font(youngster2);

if (instance_exists(oInfo)) {
	colour_names = oInfo.colour_names;
	chosen_guy = oInfo.chosen_guy;
	joystick_spot = oInfo.joystick_spot; //point where movement is registered
} else {
	colour_names = ["red", "shrimp", "tan", "purple", "magenta"];
	chosen_guy = [1, "keyboard"];
	joystick_spot = 0.3; //point where movement is registered
}

colours = [
	[ #E73133, #431C1E], //red
	[ #F9806B, #7B3E33], //shrimp
	//[ #FD9B30, #774012], //orange
	[ #EFE4B9, #6B6552], //tan
	//[ #4CF664, #23792E], //lime
	//[ #277E46, #10331B], //green
	//[ #32C2F7, #186096], //blue
	[ #BB5CF8, #552B7B], //purple
	[ #F92AF0, #4B132F], //magenta
	[ #F0B642, #5A2B11, #E589FE, #3513FE], //shlurkle (orange then grape)
	[ #848484, #353535] //dead
];
alive_colours = [
	[ #FD9B30, #774012], //orange
	[ #4CF664, #23792E], //lime
	[ #277E46, #10331B], //green
	[ #32C2F7, #186096]  //blue
];
alive_colour_names = ["orange", "lime", "green", "blue"];

talk_points = [[280, 250], [600, 250], [920, 280], [1250, 300], [1610, 350], 1700, [300, 300]];


start = 400;
start2 = 2450;

cursor_x = -1;
real_cursor_x = -1;

past_raw_move = 0;
selected = 0;
shake = 0;

move = 0;
raw_move = 0;
past_raw_move = 0;
select = 0;

da_width = 300;
da_height = 200;
expansion = 20;
split_surface1 = surface_create(da_width+expansion*2, da_height+expansion*2);
split_surface2 = surface_create(da_width+expansion*2, da_height+expansion*2);


function get_controls() {
	if (chosen_guy[1] == "keyboard") { //ketboRAD
		move = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
		select = keyboard_check_pressed(vk_space);
	} 
	else { //conmtroler
		raw_move = gamepad_axis_value(chosen_guy[1], gp_axislh);
		if (abs(raw_move) > joystick_spot) && (abs(past_raw_move) <= joystick_spot) {
			move = sign(raw_move);
		} else {
			move = 0;
		}
		past_raw_move = raw_move;
		select = gamepad_button_check_pressed(chosen_guy[1], gp_face1) || gamepad_button_check_pressed(chosen_guy[1], gp_shoulderrb);
	}
}


function create_split_surfaces() {
	for (var i = 0; i < 2; i++) {
		var p1 = [da_width/2+expansion+30, -1];
		var p2 = [da_width/2+expansion-30, da_height+expansion*2];
		if (i == 0) {
			surface_set_target(split_surface1);
			var p3 = [da_width+expansion*2, da_height+expansion*2];
			var p4 = [da_width+expansion*2, -1];
		} else {
			surface_set_target(split_surface2);
			var p3 = [-1, da_height+expansion*2];
			var p4 = [-1, -1];
		}
		
		var x1 = 0;
		var y1 = 0;
		var x2 = da_width+expansion*2;
		var y2 = da_height+expansion*2;
		var w2 = 10;
		
		var xref = lifespan*1.6 % 400;
		var yref = lifespan*1.1 % 400;
		
		var index = 4;
		var col1 = colours[6][0];
		var col2 = colours[6][1];
		
		//slab of stuff
		draw_rectangle_color_simple(x1, y1, x2, y2, col2);
		draw_sprite_general(sTiles, index, xref, yref, (x2-x1-w2*2)*2, (y2-y1-w2*2)*2, x1+w2, y1+w2, 0.5, 0.5, 0, c_white, c_white, c_white, c_white, 1);
		draw_border_text(avg([x1, x2]), avg([y1, y2]), string_capitalise(alive_colour_names[cursor_x]), -1, 999999, 0.7+0.05, 0.7+0.05, 6, 0, col1, col2, 1, true);
		
		
		//chunk taken outta
		gpu_set_blendmode(bm_subtract);
		draw_triangle(p1[0], p1[1], p2[0], p2[1], p3[0], p3[1], false);
		draw_triangle(p1[0], p1[1], p3[0], p3[1], p4[0], p4[1], false);
		gpu_set_blendmode(bm_normal);
		
		
		surface_reset_target();
	}
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);





function generate_impact_numbers() {
	var stuff = [];
	for (var i = 0; i < 20; i++) { //small
		array_push(stuff, [random_range(0, 360), random_range(1, 3)]);
	}
	for (var i = 0; i < 10; i++) { //big
		array_push(stuff, [random_range(0, 360), random_range(5.5, 7)]);
	}
	return stuff;
}

function generate_impact_lines() {
	var stuff = [];
	for (var i = 0; i < 50; i++) { //small
		array_push(stuff, random_range(0, 360));
	}
	return stuff;
}

function refresh_blast() {
	impact_numbers = generate_impact_numbers();
	impact_lines = generate_impact_lines();
}


function draw_blast(xx, yy, col=c_white, scale=1) {
	var l = room_width;
	//triangles
	for (var i = 0; i < 30; i++) {
		var angle = impact_numbers[i][0] + random_range(-0.75, 0.75);
		var spread = impact_numbers[i][1]*scale;
		draw_triangle_color_simple(xx, yy, xx+ldx(l, angle+spread), yy+ldy(l, angle+spread), xx+ldx(l, angle-spread), yy+ldy(l, angle-spread), col);
	}
	//lines
	for (var i = 0; i < 50; i++) {
		var angle = impact_lines[i] + random_range(-0.75, 0.75);
		draw_line_width_color(xx, yy, xx+ldx(l, angle), yy+ldy(l, angle), 1, col, col);
	}
}


function draw_cube_blast(x1, y1, x2, y2, col=c_white, blast_there=true, scale=1, shakiness=8) {
	draw_shape_blast(x1, y1, x2, y1, x2, y2, x1, y2, col, blast_there, scale, shakiness);
}


function draw_shape_blast(x1, y1, x2, y2, x3, y3, x4, y4, col=c_white, blast_there=true, scale=1, shakiness=8) {
	// 1   2
	//
	// 4   3
	var m = shakiness;
	var pw = [];
	for (var i = 0; i < 8; i++) {
		array_push(pw, [random_range(-m, m), random_range(-m, m)]);
	}
	//draw_rectangle_color_simple(x, cool_y, x+oInfo.w, cool_y2, col2);
	draw_triangle_color_simple(x1+pw[0][0], y1+pw[0][1], x2+pw[1][0], y2+pw[1][1], x3+pw[2][0], y3+pw[2][1], col);
	draw_triangle_color_simple(x1+pw[0][0], y1+pw[0][1], x3+pw[2][0], y3+pw[2][1], x4+pw[3][0], y4+pw[3][1], col);
	
	if (blast_there) {
		draw_blast(avg([x1, x2, x3, x4]), avg([y1, y2, y3, y4]));
	}
}

refresh_blast();

























