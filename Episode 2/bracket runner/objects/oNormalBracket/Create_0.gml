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
	[1, 836, 431, false, [[685, 372], [945, 375], [995, 392], [1003, 459], [952, 494], [680, 485], [648, 455], [648, 397]]],
	[3, 831, 1007, false, [[670, 951], [931, 947], [1005, 986], [1000, 1046], [918, 1076], [693, 1068], [654, 1028]]],
	[4, 1740, 434, false, [[1564, 389], [1676, 367], [1901, 385], [1912, 471], [1832, 496], [1671, 503], [1573, 481], [1552, 430]]],
	[6, 1736, 1014, false, [[1575, 962], [1894, 965], [1906, 1039], [1831, 1071], [1599, 1064], [1554, 1030], [1554, 986]]],
	[6, 1284, 568, false, [[1129, 523], [1281, 506], [1433, 521], [1464, 593], [1449, 621], [1145, 629], [1109, 602], [1101, 552]]],
	[3, 1277, 863, false, [[1116, 804], [1391, 806], [1451, 836], [1457, 891], [1367, 926], [1147, 923], [1100, 893], [1095, 837]]],
	[6, 1280, 720, true, [[1208, 671], [1275, 645], [1336, 674], [1333, 754], [1278, 781], [1207, 753]]]
];

bw = 500;
bh = 300;
textx = 1280;
texty = 222;
lifespan = 0;
background_surface = surface_create(bw, bh);