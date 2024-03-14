lifespan = irandom_range(0, 10000);
loop = 1.99;
difference = 25;
crazy_mode = 0;
shape_type = 0;
rot_add = 0;

random_nums = [];

for (var i = 0; i < 100; i++) {
	array_push(random_nums, irandom_range(shape_type*3, shape_type*3+2));
}