if (mouse_check_button(mb_right)) {
	speedy = 100;
} else {
	speedy = 15;
}

if (mouse_wheel_down()) {
	d /= 0.85;
}
if (mouse_wheel_up()) {
	d *= 0.85;
}

if (keyboard_check(ord("W"))) {
	zpos -= 2*speedy;
}
if (keyboard_check(ord("S"))) {
	zpos += 2*speedy;
}
if (keyboard_check(ord("A"))) {
	xpos += 2*speedy;
}
if (keyboard_check(ord("D"))) {
	xpos -= 2*speedy;
}
if (keyboard_check(vk_space)) {
	ypos += 2*speedy;
}
if (keyboard_check(vk_shift)) {
	ypos -= 2*speedy;
}

visibility = clamp(ypos-78250, 0, 79630-78250) / (79630-78250);


//CAMERA CONTROL ================================================================
if (oInfo.camera_on != -1) {
	ypos = lerp(ypos, oInfo.colours[oInfo.camera_on][6].y, 0.2);
}

if (ypos > 3000) && (stage == 0) {
	stage = 1;
	stage_real = 0;
}

if (ypos > 50000) && (stage == 1) {
	stage = 2;
	stage_real = 0;
}

zpos = lerp(stage_levels[stage], stage_levels[stage+1], ease_in_out(stage_real));

stage_real = min(1, stage_real + 0.003);