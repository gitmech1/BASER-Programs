// scrip
function check_in_triangle_box(target, width){ //checking if in laser area
	if (
		point_in_triangle(target.x, target.y,
		x+lengthdir_x(2500, image_angle)+lengthdir_x(width, image_angle+90),
		y+lengthdir_y(2500, image_angle)+lengthdir_y(width, image_angle+90),
		x+lengthdir_x(-2500, image_angle)+lengthdir_x(width, image_angle+90),
		y+lengthdir_y(-2500, image_angle)+lengthdir_y(width, image_angle+90),
		x+lengthdir_x(2500, image_angle)+lengthdir_x(-width, image_angle+90),
		y+lengthdir_y(2500, image_angle)+lengthdir_y(-width, image_angle+90))
	) || (
		point_in_triangle(target.x, target.y,
		x+lengthdir_x(-2500, image_angle)+lengthdir_x(-width, image_angle+90),
		y+lengthdir_y(-2500, image_angle)+lengthdir_y(-width, image_angle+90),
		x+lengthdir_x(-2500, image_angle)+lengthdir_x(width, image_angle+90),
		y+lengthdir_y(-2500, image_angle)+lengthdir_y(width, image_angle+90),
		x+lengthdir_x(2500, image_angle)+lengthdir_x(-width, image_angle+90),
		y+lengthdir_y(2500, image_angle)+lengthdir_y(-width, image_angle+90))
	) || (
		point_in_triangle(target.x, target.y,
		x+lengthdir_x(2500, image_angle+90)+lengthdir_x(width, image_angle),
		y+lengthdir_y(2500, image_angle+90)+lengthdir_y(width, image_angle),
		x+lengthdir_x(-2500, image_angle+90)+lengthdir_x(width, image_angle),
		y+lengthdir_y(-2500, image_angle+90)+lengthdir_y(width, image_angle),
		x+lengthdir_x(2500, image_angle+90)+lengthdir_x(-width, image_angle),
		y+lengthdir_y(2500, image_angle+90)+lengthdir_y(-width, image_angle))
	) || (
		point_in_triangle(target.x, target.y,
		x+lengthdir_x(-2500, image_angle+90)+lengthdir_x(-width, image_angle),
		y+lengthdir_y(-2500, image_angle+90)+lengthdir_y(-width, image_angle),
		x+lengthdir_x(-2500, image_angle+90)+lengthdir_x(width, image_angle),
		y+lengthdir_y(-2500, image_angle+90)+lengthdir_y(width, image_angle),
		x+lengthdir_x(2500, image_angle+90)+lengthdir_x(-width, image_angle),
		y+lengthdir_y(2500, image_angle+90)+lengthdir_y(-width, image_angle))
	) {
		return true;
	}
	return false;
}