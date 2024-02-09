// red: #E73133, #431C1E
// salmon: #F9806B, #7B3E33 (still called him salmon lol)
// orange: #FD9B30, #774012
// tan: #EFE4B9, #6B6552
// lime: #4CF664, #23792E
// green: #277E46, #10331B
// blue: #32C2F7, #186096
// purple: #BB5CF8, #552B7B
// magenta: #F92AF0, #4B132F

colours = [
//name, col1, col2, start, end, spos, epos, eliminted (0 fine, 1 getting, 2 dead)
	["Red", #E73133, #431C1E, 0, 142, 0, 6, 0],
	["Shrimp", #F9806B, #7B3E33, 0, 153, 1, 3, 0],
	["Orange", #FD9B30, #774012, 0, 144, 2, 5, 0],
	["Tan", #EFE4B9, #6B6552, 0, 93, 3, 8, 1],
	["Lime", #4CF664, #23792E, 0, 189, 4, 1, 0],
	["Green", #277E46, #10331B, 0, 179, 5, 2, 0],
	["Blue", #32C2F7, #186096, 0, 200, 6, 0, 0],
	["Purple", #BB5CF8, #552B7B, 0, 147, 7, 4, 0],
	["Magenta", #F92AF0, #4B132F, 0, 99, 8, 7, 0]
]

var sort_list = function(elm1, elm2) {
	return elm1[6] - elm2[6];
}
array_sort(colours, sort_list);

max_value = 0;
for (var i = 0; i < len(colours); i++) {
	if (colours[i][4] > max_value) {
		max_value = colours[i][4];
	}
}

self.archivo = font_add("archivo.ttf", 50, false, false, 32, 127);
self.archivobig = font_add("archivo.ttf", 200, false, false, 32, 127);

amount = len(colours);
padding = 50;
size = (1440-2*padding)/amount;

time_elapsed = 0;