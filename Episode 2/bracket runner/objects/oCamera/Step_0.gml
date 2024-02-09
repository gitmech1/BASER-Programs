move = ease_in_out(clamp((lifespan-cooldown)/time, 0, 1));
x = lerp(oStart.x, oEnd.x, move);
y = lerp(oStart.y, oEnd.y, move);
if (start) {
	zoom = -0.000055*lifespan*(lifespan-(time+cooldown*2))-2;
} else {
	zoom = -0.0001*lifespan*(lifespan-(time+cooldown*2))-2;
}

camera_set_view_pos(view_camera[0], x-power(2, zoom)*camWidth/2, y-power(2, zoom)*camHeight/2);
camera_set_view_size(view_camera[0], power(2, zoom)*camWidth, power(2, zoom)*camHeight);

x_shift += 0.0003;
if (x_shift >= 1) { x_shift--; }
y_shift += 0.01;
fx_set_parameter(fx, "g_PanoramaDirection", [x_shift, sin(y_shift)/80+0.5]);

if (ending) {
	lifespan = lerp(lifespan, time/2+cooldown, 0.01+clamp((lifespan-30)/5000, 0, 0.99));
} else {
	lifespan++;
}