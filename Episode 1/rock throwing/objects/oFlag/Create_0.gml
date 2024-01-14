image_speed = 0;

lifespan = x/10 + oInfo.elapsed_time;
lifespanner = 0;
yoffset = 0;
yy = 2100;
colour = oInfo.rock_colour;

end_distance = "xd";

with (instance_create_layer(x, y, "Omnipotent", oFlagFriend)) {
	flag = other.id;
}