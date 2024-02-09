self.font = font_add("Youngster.ttf", 50, false, false, 32, 127);
self.font2 = font_add("Youngster.ttf", 100, false, false, 32, 127);
draw_set_font(font);

colours = [
	["Red", #E73133, #431C1E],
	["Shrimp", #F9806B, #7B3E33],
	["Orange", #FD9B30, #774012],
	["Lime", #4CF664, #23792E],
	["Green", #277E46, #10331B],
	["Blue", #32C2F7, #186096],
	["Purple", #BB5CF8, #552B7B],
	["Magenta", #F92AF0, #4B132F]
];

points = [
	[-1, 1284, 568, false, [[1129, 523], [1281, 506], [1433, 521], [1464, 593], [1449, 621], [1145, 629], [1109, 602], [1101, 552]]],
	[-1, 1277, 863, false, [[1116, 804], [1391, 806], [1451, 836], [1457, 891], [1367, 926], [1147, 923], [1100, 893], [1095, 837]]],
	[-1, 1280, 720, true, [[1208, 671], [1275, 645], [1336, 674], [1333, 754], [1278, 781], [1207, 753]]]
];

bw = 500;
bh = 300;
textx = 1280;
texty = 383;
lifespan = 0;
background_surface = surface_create(bw, bh);