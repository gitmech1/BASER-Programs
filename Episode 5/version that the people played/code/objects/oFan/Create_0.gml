desired_state = false; //technically not but makes prior code work (i think)
state = false; //yellow or green
col = bool(round(image_index%6/3)); //false == yellow, true == green
lifespan = 0;

size = image_xscale;

alarm[0] = 1;