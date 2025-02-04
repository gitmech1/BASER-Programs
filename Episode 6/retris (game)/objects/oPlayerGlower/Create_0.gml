player = noone;
rows = [];
visibility = 0;
time_left = 0;

to_glow = [[], [], []]; //rgb powerups [position, lifespan, strength]
to_glow_message = [false, false, false]; //communicated by player as to whether it should begin counting down

edge_glow = -1; //-1 for nothing, 0-2 for colour
edge_lifespan = 0;
edge_retracting = []; //add [colour id, lifespan, time_left]


function draw_edge_thingy(lifespano, col_id, wane=0) {
	var raw_in = ease_out(lifespano/60)*5*map_value(sin(degtorad(lifespano*2.5+180)), -1, 1, 0.5, 1.5) * (1-ease_in(wane/30, 4));
	var in = floor(raw_in);
	var in_left = raw_in-in;
	if (col_id != 2) {
		var alpha = ease_out(lifespano/60)*0.95 * (1-wane/30);
	} else {
		var alpha = ease_out(lifespano/60) * (1-wane/30);
	}
	var col = oInfo.powerup_colours[col_id];
	//main chunk
	draw_set_alpha(alpha);
	draw_rectangle_color_simple(0, 0, room_width, in, col);
	draw_rectangle_color_simple(0, in+1, in, room_height-in-1, col);
	draw_rectangle_color_simple(0, room_height-in, room_width, room_height, col);
	draw_rectangle_color_simple(room_width-in, in+1, room_width, room_height-in-1, col);
	//anti aliasing line
	draw_set_alpha(alpha*in_left);
	draw_rectangle_color_simple(in+1, in+1, room_width-in-1, room_height-in-1, col, true);
	//draw_rectangle_color_simple(in+2, in+2, room_width-in-2, room_height-in-2, col, true);
	draw_set_alpha(1);
}


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
	var m = shakiness;
	var pw = [];
	for (var i = 0; i < 8; i++) {
		array_push(pw, [random_range(-m, m), random_range(-m, m)]);
	}
	//draw_rectangle_color_simple(x, cool_y, x+oInfo.w, cool_y2, col2);
	draw_triangle_color_simple(x1+pw[0][0], y1+pw[0][1], x2+pw[1][0], y1+pw[1][1], x2+pw[2][0], y2+pw[2][1], col);
	draw_triangle_color_simple(x1+pw[0][0], y1+pw[0][1], x1+pw[3][0], y2+pw[3][1], x2+pw[2][0], y2+pw[2][1], col);
	
	if (blast_there) {
		draw_blast(avg([x1, x2]), avg([y1, y2]));
	}
}


//red
refresh_blast();

//blue
blue_lifespan = 0;