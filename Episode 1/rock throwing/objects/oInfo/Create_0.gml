randomize();
elapsed_time = 0;
// red: #E73133, #431C1E
// shrimp: #F9806B, #7B3E33
// orange: #FD9B30, #774012
// tan: #EFE4B9, #6B6552
// lime: #4CF664, #23792E
// green: #277E46, #10331B
// blue: #32C2F7, #186096
// purple: #BB5CF8, #552B7B
// magenta: #F92AF0, #4B132F
colour_name = "Red"; //name of colour
rock_colour = #E73133; //base col
rock_comp_colour = #431C1E; //edge col
angle = 17; //angle thrown
dots = false; //if u want the dot dot dot at the end, showing irrationality
precision = -1; //if anything is wanted above 2 dp
force = 30; //force of throw, 30 is what was used

flags = [
	//[141.9, #E73133],
	//[152.7, #F9806B],
	//[144.3, #FD9B30],
	//[92.8, #EFE4B9],
	//[189.3, #4CF664],
	//[179.1, #277E46],
	//[200.0, #32C2F7],
	//[147.4, #BB5CF8],
	//[99.2, #F92AF0]
];

for (var i = 0; i < len(flags); i++) {
	var distanc = flags[i][0]; //idk why i have to do this, but it works
	var colou = flags[i][1];
	with (instance_create_layer(-94.5*distanc+19319, 2100, "ramps", oFlag)) {
		lifespanner = 200;
		colour = colou;
		end_distance = string_format(distanc, len(string(floor(distanc))), 1) + " m";
	}
}