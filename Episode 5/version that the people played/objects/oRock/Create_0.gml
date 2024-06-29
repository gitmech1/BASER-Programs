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
todo = false;

// red: #E73133, #431C1E
// shrimp: #F9806B, #7B3E33
// orange: #FD9B30, #774012
// tan: #EFE4B9, #6B6552
// lime: #4CF664, #23792E
// green: #277E46, #10331B
// blue: #32C2F7, #186096
// purple: #BB5CF8, #552B7B
// magenta: #F92AF0, #4B132F
colour = #00FF87;
spawnx = x;
spawny = y;

keys = []; //updationg list of keys held
switch_colliding = false; //checks if in collision with a switch
coyote = 0; //som,e thinhg
coyote_collide = noone;

//set to camera
with (oCamera) {
	tracking = other.id;
	goalx = other.x;
	goaly = other.y;
}




//miscellanoeusuesuueusss functiosn
collide_with_door = function(door) {
	if (len(keys) > 0) && (door.animation == 0) {
		action = ["door", door];
		keys[0].animation = 1;
		keys[0].door = door;
		door.animation = 1;
		array_delete(keys, 0, 1);
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
		keys[i].x += xdiff;
		keys[i].y += ydiff;
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
		if !(spawn.triggered) {
			spawn.triggered = true;
			spawnx = spawn.x;
			spawny = spawn.y;
		}
	}
	
	//keys
	var key = instance_place(x, y, oKey);
	if (key != noone) {
		if (key.lockedto == noone) {
			key.lockedto = id;
			array_push(keys, key.id);
		}
	}
	
	//switches
	var swich = instance_place(x, y, oSwitch);
	if (swich != noone) {
		if !(switch_colliding) && !(swich.automatic) {
			swich.update_state();
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
		room_goto_next();
		keys = [];
		todo = true; //go to right spot next frame
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
	try {
		if (len(oInfo.past_record) > 0) {
			var frame = oInfo.past_record[oInfo.lifespan]; //[[x, y, r], action]
	
			x = frame[0][0];
			y = frame[0][1];
			rot = frame[0][2];
		
			if (frame[1][0] == "die") {
				x = frame[1][1];
				y = frame[1][2];
				die();
			} else if (frame[1][0] == "door") {
				collide_with_door(frame[1][1]);
			} else if (frame[1][0] == "boing") {
				frame[1][1].boing(frame[1][2], frame[1][3], frame[1][4]);
			}
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