camWidth = 2560;
camHeight = 1440;

fx = layer_get_fx("Background");
x_shift = 0;
y_shift = 0;

start = false;
ending = true;

move = 0;
zoom = 0;
time = 250;
if (start) {
	lifespan = -120;
	cooldown = 115;
} else {
	lifespan = -10;
	cooldown = 45;
}

x = 2560;
y = 1440;

self.font = font_add("Lemonmilk.otf", 240, false, false, 32, 127);
self.font2 = font_add("Youngster.ttf", 50, false, false, 32, 127);