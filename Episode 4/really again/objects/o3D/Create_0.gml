xpos = 0;
ypos = -13500;
zpos = 735;
d = 60;

width = 3; //width of pen
speedy = 1; //speed of player controler
visibility = 0; //visibility of glass at top of thingy

stage = 0; //zoom of camera
stage_real = 1;
stage_levels = [0, 735, 6500, 1515];


/*shape = [
	[[[100, 100, 0], [100, 200, 0], [200, 200, 0]], c_green, c_lime],
	[[[100, 100, 0], [200, 200, 0], [200, 100, 0]], c_green, c_lime],
	[[[200, 200, 0], [100, 200, 0], [200, 200, 100]], c_green, c_lime],
	[[[100, 200, 100], [100, 200, 0], [200, 200, 100]], c_green, c_lime],
];

shape = generate_cube(-100, -100, -100, 100, 100, 100, c_green, c_lime);*/

shape = array_concat(
	//generate_terrain(200, 15, 0, -600, -3500, 150, #449251, #77C084, 300, true, ease_in), //further ground
	//generate_terrain(200, 12, 0, 0, -700, 150, #449251, #77C084, -600, true, ease_in), //closer cliff
	//generate_trees(4, 15, 0, -600, -3500, 150, 300, ease_in, 150),
	[[[[0, 0, -99999], [0, 0, -99999], [0, 0, -99999]], #449251, #449251, [0, 0, -99999], "ground"]],
	[[[[0, 0, -999999], [0, 0, -999999], [0, 0, -999999]], #60B9F5, #60B9F5, [0, 0, -999999], "water"]],
);

points = []

update_2d(shape);