if (!surface_exists(background_surface)) {
	surface_free(background_surface);
	background_surface = surface_create(bw, bh);
}

draw_sprite_ext(sprite_index, image_index, x-20, y+20, 1, 1, 0, c_black, 0.5);

for (var i = 0; i < len(points); i++) {
	draw_background_surface(points[i][1], points[i][2], points[i][4], points[i][0], points[i][3]);
}

draw_self();

draw_set_font(font2);
draw_text_ext_transformed_color(textx+x-2560/2-20, texty+y-1440/2+20, "Normal Bracket", -1, 999999, 0.8, 0.8, 5*sin(degtorad(lifespan+180)), c_black, c_black, c_black, c_black, 0.5);
draw_border_text(textx+x-2560/2, texty+y-1440/2, "Normal Bracket", -1, 999999, 0.8, 0.8, 8, 5*sin(degtorad((lifespan+180))), #F09367, #9E5738, 1, true);
draw_set_font(font);

lifespan++;