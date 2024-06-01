//sorting function for rock dislpay
var sort_by_height = function(inst1, inst2) {
	//order with dead guys
	if (inst1[0][7] >= 0) && (inst2[0][7] >= 0) {
		return inst2[0][6].y - inst1[0][6].y;
	} else if (inst1[0][7] >= 0) {
		return 1;
	} else if (inst2[0][7] >= 0) {
		return -1;
	}
	
	//order wih finished
	if (inst1[0][5] != 0) && (inst2[0][5] != 0) {
		return (inst1[0][5] - inst2[0][5]);
	} else if (inst1[0][5] != 0) {
		return -1;
	} else if (inst2[0][5] != 0) {
		return 1;
	}
	return inst2[0][6].y - inst1[0][6].y;
}

var sort_for_camera = function(inst1, inst2) {
	if (inst2[0][5]) {
		return -1;
	} else if (inst1[0][5]) {
		return 1;
	} 
	return inst2[0][6].y - inst1[0][6].y;
}

//maker new list for changing values inside array
var rocks = [];
var camera_lock = [];
for (var i = 0; i < len(colours); i++) {
	array_push(rocks, [colours[i], i]); //the ids
	array_push(camera_lock, [colours[i], i]); //the ids
}

array_sort(rocks, sort_by_height);
array_sort(camera_lock, sort_for_camera);
for (var i = 0; i < len(rocks); i++) { //ading new positions to old list
	colours[rocks[i][1]][3] = i;
}
camera_on = camera_lock[0][1]; //index, not name

/*msg("");
for (var i = 0; i < len(colours); i++) {
	msg(colours[i]);
}*/

for (var i = 0; i < len(colours); i++) { //make all rocks glide to their positions
	colours[i][4] = lerp(colours[i][4], colours[i][3], 0.4);
}

//stop the rockles at each check oint
for (var i = 0; i < len(colours); i++) {
	if !(colours[i][5]){ //if not reached checkpoint yet
		if (colours[i][6].y >= point_list[checkpoint_reached+1]) || (colours[i][7] >= 0) { //if passed or dead
			//sweep over others to see if they the last
			var count_finished = 0;
			var count_dead = 0;
			for (var j = 0; j < len(colours); j++) {
				if (colours[j][5]) {
					count_finished += 1;
				} 
				if (colours[j][7] >= 0) {
					count_dead += 1;
				}
			}
			colours[i][5] = count_finished+1-count_dead;
			var chat = [colours[i][0] + " got there " + positions[count_finished+1-count_dead-1], colours[i][1], colours[i][2], 0];
			if (count_finished == len(colours)-1) { //the final one to pass check point
				colours[i][7] = 0; //killed
				var chat = [colours[i][0] + " has DIED", colours[i][1], colours[i][2], 0];
				checkpoint_reached += 1;
				checkpoint_booster(checkpoint_reached);
				for (var j = 0; j < len(colours); j++) { //reset everyone
					if (colours[j][7] < 0) {
						colours[j][5] = false;
						colours[j][6].yvel = 40+colours[i][8]*10;//max(10, colours[i][6].yvel);
						colours[j][6].xvel = random_range(-5, 5);
						if (checkpoint_reached == 5) {
							sucking = 0;
							colours[j][6].yvel = 5;
							colours[j][6].top_collision = true;
							win_text = string_upper(colours[j][0]) + " WON!!"
							win_in = 1;
							win_col = colours[j][1];
							win_col2 = colours[j][2];
						}
					}
				}
			} else {
				colours[i][9] += ceil(power((checkpoint_reached+1), 2)*15) - (count_finished+1-count_dead)*(checkpoint_reached+1); //point calculatiom
			}
			array_insert(chat_log, 0, chat);
		}
	}
}


//check in range for the suck
if (sucking == 0) && (checkpoint_reached != 5) {
	var suck_check = true;
	for (var i = 0; i < len(colours); i++) {
		if (colours[i][6].y < 69600) && (colours[i][7] < 0) {
			suck_check = false;
		}
	}
	if (suck_check) {
		sucking = 1;
	}
}


//update chat log
for (var i = len(chat_log)-1; i >= 0; i--) {
	chat_log[i][3] += 1;
	if (chat_log[i][3] >= 240) {
		array_delete(chat_log, i, 1);
	}
}
chat_log_height = lerp(chat_log_height, len(chat_log), 0.3);

lifespan++;
if (sucking) {
	sucking++;
}
if (win_in) {
	win_in++;
}