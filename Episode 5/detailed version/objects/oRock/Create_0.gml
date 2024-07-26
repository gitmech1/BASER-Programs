image_xscale = 1.5;
image_yscale = 1.5;

xvel = 0;
yvel = 0;
rot = 0;
rvel = 0;

left = 0;
right = 0;
up = 0;

//for tracking and saving player moves
positions = [];
action = [false]; //[false], ["die", x, y], ["door", door_id], ["boing", collider, x, y, vel]
done = false;

colour = oInfo.colours[$ colour_name][0];
spawnx = x;
spawny = y;
rot_shift = irandom_range(0, 359);

data = [
	pull(colour_name + "0"),
	pull(colour_name + "1"),
	pull(colour_name + "2"),
	pull(colour_name + "3"),
	pull(colour_name + "4"),
	pull(colour_name + "5")
];

keys = []; //[xpos, ypos, goalx, goaly, rot, sinscale, lifespan, door, animation, shake]
switch_colour = false; //false == yellow, true == green, it is the one it can interact with
switch_colliding = false; //checks if in collision with a switch
coyote = 0; //som,e thinhg
coyote_collide = noone;




update_keys = function() {
	for (var i = 0; i < len(keys); i++) {
		//[xpos, ypos, goalx, goaly, rot, sinscale, lifespan, door, animation, shake]
		var key = keys[i];
		
		if !(key.animation) {
			var xamount = (x - key.xpos)*0.04;
			var yamount = (y - key.ypos)*0.04;

			key.xpos += xamount;
			key.ypos += yamount;

			key.rot = xamount;
		} else {
			key.xpos = lerp(key.xpos, key.door.centerx, 0.06);
			key.ypos = lerp(key.ypos, key.door.centery, 0.06);
	
			key.sinscale = max(0, 1 - key.animation/100);
			key.rot = lerp(key.rot, 0, 0.1);
			key.shake = 9*power(key.animation, 5)/power(10, 9.5);
			key.animation++;
	
			if (key.animation == 100) {
				array_delete(keys, 0, 1);
			}
		}

		key.lifespan++;
	}
}


draw_keys = function() {
	for (var i = 0; i < len(keys); i++) {
		//[xpos, ypos, goalx, goaly, rot, sinscale, lifespan, door, animation, shake]
		var key = keys[i];
		
		var xshift = random_range(-key.shake, key.shake);
		var yshift = random_range(-key.shake, key.shake);

		if (key.animation < 100) { //normal colour key
			draw_sprite_ext(sKey, 0,
				key.xpos+xshift+oInfo.shakex, key.ypos+yshift+oInfo.shakey+dsin(key.lifespan*2)*15*key.sinscale,
				1, 1, key.rot, colour, 1);
		}
	
		if (key.animation > 50) { //white key
			draw_sprite_ext(sKey, 1,
				key.xpos+xshift+oInfo.shakex, key.ypos+yshift+oInfo.shakey+dsin(key.lifespan*2)*15*key.sinscale,
				1, 1, key.rot, -1, ease_out(min(1, (key.animation-50)/50), 3));
		}
	}
}




//miscellanoeusuesuueusss functiosn
collide_with_door = function(door) {
	var colos = ["orange", "lime", "green", "blue", "magenta"];
	var index = array_find(colos, colour_name);
	
	if (len(keys) > 0) && (door.c[index].collided == false) {
		action = ["door", door];
		keys[0].animation = 1;
		keys[0].door = door;
		door.c[index].dir = 1;
	}
}


collide_with_spikes = function(dir, spike) {
	if (dir == "v") && ((spike.image_angle+3600) % 180 == 0) {
		die(); //death
	}
	if (dir == "h") && ((spike.image_angle+3600) % 180 == 90) {
		die(); //death
	}
}


die = function() {
	action = ["die", x, y];
	var xdiff = spawnx-x;
	var ydiff = spawny-y;
	x += xdiff;
	y += ydiff;
	for (var i = 0; i < len(keys); i++) {
		keys[i].xpos += xdiff;
		keys[i].ypos += ydiff;
	}
	xvel = 0;
	yvel = 0;
}






snatch_controls = function() { //get the controls from, the player
	if !(oInfo.automatic) {
		left = keyboard_check(ord("A")) || keyboard_check(vk_left);
		right = keyboard_check(ord("D")) || keyboard_check(vk_right);
		up = keyboard_check(ord("W")) || keyboard_check(vk_up) || keyboard_check(vk_space);
	}
}




log_controls = function() {
	if !(oInfo.automatic) {
		array_push(positions, [[x, y, rot], action]);
	}
}




hit_stuff = function() { //touch keys or whatever
	//spawn points
	var spawn = instance_place(x, y, oSpawn);
	if (spawn != noone) {
		var index = array_find(["orange", "lime", "green", "blue", "magenta"], colour_name);
		
		if !(spawn.triggered[index]) {
			spawn.triggered[index] = 1;
			spawnx = spawn.x;
			spawny = spawn.y;
		}
	}
	
	//keys
	var key = instance_place(x, y, oKey);
	if (key != noone) {
		//[xpos, ypos, goalx, goaly, rot, sinscale, lifespan, door, animation, shake]
		if (array_contains(key.colours_free, colour_name)) {
			array_push(keys, {
				xpos: key.x,
				ypos: key.y,
				goalx: key.goalx, 
				goaly: key.goaly,
				rot: key.rot, 
				sinscale: key.sinscale, 
				lifespan: key.lifespan,
				door: noone, 
				animation: 0, 
				shake: 0
			})
			key.grab(colour_name);
		}
	}
	
	//switches
	var swich = instance_place(x, y, oSwitch);
	if (swich != noone) {
		if !(switch_colliding) && !(swich.automatic) {
			swich.update_state(id);
			switch_colliding = true;
		}
	} else {
		switch_colliding = false;
	}
	
	//water
	if (place_meeting(x, y, oWater)) {
		die();
	}
	
	//room switcha
	if (place_meeting(x, y, oRoomChange)) {
		if !(done) {
			if (room == Beginning) || (room == Room0) {
				array_push(oInfo.completed, colour_name);
				done = true;
			} else {
				if (len(oInfo.remaining)-1 != len(oInfo.completed)) {
					array_push(oInfo.completed, colour_name);
					done = true;
				}
			}
		}
	}
}




chilling = function() { //when he is just hopping around
	yvel += oInfo.grv;
	rvel = lerp(rvel, 0, 0.01);

	//comntrol ===================================
	//left and right
	if (left) {
		xvel = max(-14, xvel-1.5);
		rvel += 0.1;
	}
	if (right) {
		xvel = min(14, xvel+1.5);
		rvel -= 0.1;
	}
	xvel = lerp(xvel, 0, 0.1);
	if (xvel < 0.05) && (xvel > -0.05) {
		xvel = 0;
	}

	//jumping stuff
	var collider = toggle_instance_place(x, y+yvel+1, oWall);
	if (coyote) {
		collider = coyote_collide;
	}
	if (up) && (collider != noone) {	
		//actuall colliding
		if (object_name(collider) == "oSlime") { //sliming it up
			action = ["boing", collider.id, x, y, yvel];
			collider.boing(x, y, yvel);
			yvel = min(-yvel-3, -7);
		} else {
			yvel = -12.3;
		}
		rvel -= sign(xvel)*12;
		
		//stuff checking
		if (object_name(collider) == "oDoor") { 
			collide_with_door(collider);
		} else if (object_name(collider) == "oSpike") {
			collide_with_spikes("v", collider);
		}
	}


	//collisioj ==================================
	//on da horizontal
	var collider = toggle_instance_place(x+xvel, y, oWall);
	if (collider != noone) {		
		//actual colliding
		while (!place_meeting(x+sign(xvel), y, collider)) {
			x += sign(xvel);
		}
		if (object_name(collider) == "oSlime") {
			action = ["boing", collider.id, x, y, xvel];
			collider.boing(x, y, xvel);
		}
		xvel = -xvel * 0.6;
		
		//stuff checking
		if (object_name(collider) == "oDoor") {
			collide_with_door(collider);
		} else if (object_name(collider) == "oSpike") {
			collide_with_spikes("h", collider);
		}
	}
	
	//on da vertical
	var collider = toggle_instance_place(x, y+yvel, oWall);
	if (collider != noone) {		
		//actual colliding
		while (!place_meeting(x, y+sign(yvel), oWall)) {
			y += sign(yvel);
		}
		if (abs(yvel) > 1) {
			if (object_name(collider) == "oSlime") {
				action = ["boing", collider.id, x, y, yvel];
				collider.boing(x, y, yvel);
				yvel = -yvel*0.8;
			} else {
				yvel = -yvel*0.4;
			}
			if (sign(yvel) < 0) {
				coyote = 4; //CHNAGE LATER
				coyote_collide = collider;
			}
		} else {
			yvel = 0;
		}
		rvel = lerp(rvel, -xvel, 0.5); //constant spinning
		
		//stuff checking
		if (object_name(collider) == "oDoor") {
			collide_with_door(collider);
		} else if (object_name(collider) == "oSpike") {
			collide_with_spikes("v", collider);
		}
	}

	x += xvel;
	y += yvel;
	rot += rvel;
	if (coyote) {
		coyote--;
	}
}



autoing = function() {
	if (oInfo.lifespan < len(data[oInfo.rooms])) {
		var frame = data[oInfo.rooms][oInfo.lifespan]; //[[x, y, r], action]
	
		x = frame[0][0];
		y = frame[0][1];
		rot = frame[0][2];
		
		if (frame[1][0] == "die") {
			x = frame[1][1];
			y = frame[1][2];
			die();
		} else if (frame[1][0] == "door") {
			collide_with_door(oInfo.objects[frame[1][1]]);
		} else if (frame[1][0] == "boing") {
			oInfo.objects[frame[1][1]].boing(frame[1][2], frame[1][3], frame[1][4]);
		}
	}
}




if !(oInfo.automatic) {
	state_name = "chilling";
	state = chilling;
} else {
	state_name = "autoing";
	state = autoing;
}