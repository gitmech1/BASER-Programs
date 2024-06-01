if (lifespan < 360) { //starting thingy
	arrow_rot = -90 + ((lifespan%2)*2-1)*4  *  max(0, -0.02*lifespan + 4);
	arrow_size = arrow_size_max * clamp(lifespan-200, 0, 20)/20;
	
} else { //everything else
	if !(oInfo.colours[rock_reference][5]) && (oInfo.colours[rock_reference][7] < 0) {
		//collision with obstacles
		for (var i = 0; i < len(oInfo.obstacles); i++) {
			var o = oInfo.obstacles[i];
			if !(array_contains(collided_obstacles, o)) {
				if (o.image_index == 0) { //cloud
					var x1 = o.x-700*o.xscale;
					var y1 = o.y-150*o.yscale;
					var x2 = o.x+700*o.xscale;
					var y2 = o.y+150*o.yscale;
				} else { //weird shape
					var x1 = o.x-200*o.xscale;
					var y1 = o.y-100*o.yscale;
					var x2 = o.x+200*o.xscale;
					var y2 = o.y+100*o.yscale;
				}
				if (point_rectangle(x, y, x1, y1, x2, y2)) {
					yvel = 0;
					xvel = 5 * sign(x-o.x);
					array_push(collided_obstacles, o);
					oInfo.obstacles[i].hit = 5;
				}
			}
		}
	
		if (oInfo.sucking) {
			//stopping moving at beginning
			if (oInfo.sucking < 120) {
				xvel = lerp(xvel, 0, 0.4);
				yvel = lerp(yvel, 0, 0.4);
			} else {
				yvel = min(6, yvel+0.075);
			}
	
	
			//collision once more
			for (var i = 0; i < len(oInfo.collisions); i++) { //every collidable shape
				var x1 = oInfo.collisions[i][0];
				var y1 = oInfo.collisions[i][1];
				var x2 = oInfo.collisions[i][2];
				var y2 = oInfo.collisions[i][3];
	
				if (point_rectangle(x, y+yvel, x1, y1, x2, y2)) { //vertical collision
					while (point_rectangle(x, y+yvel, x1, y1, x2, y2)) {
						y -= sign(yvel);
					}
					yvel *= -0.9;
					rvel = (rvel - 0.5*xvel)*0.7;
				}
				if (point_rectangle(x+xvel, y, x1, y1, x2, y2)) { //hroizontal collision
					if !( (i == len(oInfo.collisions)-1) && (yvel <= 0) ) {
						while (point_rectangle(x+xvel, y, x1, y1, x2, y2)) {
							x -= sign(xvel);
						}
						xvel *= -0.9;
					}
				}
			}
	
			r += rvel
			x += xvel;
			y += yvel;
	
	
	
	
	
		} else {
	
			if (oInfo.checkpoint_reached != 3) { //every other section
				yvel -= oInfo.grv;
			} else { //section 3 (free area)
				yvel = lerp(yvel, 40, 0.01);
			}
			
			//mario kart esque back cheat (so rocks dont get stuck at the bottom)
			var screen_spot = convert_to_2d([x, y, 125])
			if !(point_rectangle(screen_spot[0], screen_spot[1], -100, -100, 2660, 1540)) {
				//msg("hey its me " + oInfo.colours[rock_reference][0]);
				if (irandom_range(1, 600) == 1) {
					yvel += 30;
				}
			}

			//collision with boosters
			for (var i = 0; i < len(oInfo.boosters); i++) {
				var b = oInfo.boosters[i];
				var rotation = round(r/90)%2;
				var scale = 0.5;
				if (rotation == 1) {
					var x1 = b[0].x - 164*b[0].image_xscale*scale;
					var y1 = b[0].y - 104*b[0].image_yscale*scale;
					var x2 = b[0].x + 164*b[0].image_xscale*scale;
					var y2 = b[0].y + 104*b[0].image_yscale*scale;
				} else {
					var x1 = b[0].x - 104*b[0].image_yscale*scale;
					var y1 = b[0].y - 164*b[0].image_xscale*scale;
					var x2 = b[0].x + 104*b[0].image_yscale*scale;
					var y2 = b[0].y + 164*b[0].image_xscale*scale;
				}
				if (point_rectangle(x, y, x1, y1, x2, y2)) {
					if (b[0].normal) {
						var strength = b[1] - min(0, yvel)/6;
						xvel += ldx(strength, b[0].r);
						yvel -= ldy(strength, b[0].r);
					} else {
						xvel += ldx(6, b[0].r);
						yvel -= ldy(6, b[0].r);
					}
					break;
				}
			}

			//actual colliding
			for (var i = 0; i < len(oInfo.collisions); i++) { //every collidable shape
				var x1 = oInfo.collisions[i][0];
				var y1 = oInfo.collisions[i][1];
				var x2 = oInfo.collisions[i][2];
				var y2 = oInfo.collisions[i][3];
			
				if (point_rectangle(x, y+yvel, x1, y1, x2, y2)) { //vertical collision
					while (point_rectangle(x, y+yvel, x1, y1, x2, y2)) {
						y -= sign(yvel);
					}
					yvel *= -0.9;
					rvel = (rvel - 0.5*xvel)*0.7;
				}
				if (y < oInfo.point_list[5]) && (top_collision) { //vertical for end
					y = oInfo.point_list[5];
					yvel *= 0.8;
					rvel = (rvel - 0.5*xvel)*0.7;
					xvel *= 0.8;
				}
				if (point_rectangle(x+xvel, y, x1, y1, x2, y2)) { //hroizontal collision
					if !( (i == len(oInfo.collisions)-1) && (yvel <= 0) ) {
						while (point_rectangle(x+xvel, y, x1, y1, x2, y2)) {
							x -= sign(xvel);
						}
						xvel *= -0.9;
					}
				}
			}

			//free part to clouds (works i think)
			//58125, 63125
			var shift = (clamp(y, 53000, 63000)-53000)/10000; //between 0 and 1
			if (shift > 0) && (shift < 0.99) {
				x = lerp(x, random_range(-200, 200), 0.05*shift);
				xvel = lerp(xvel, 0, shift/50);
			}

			r += rvel
			x += xvel;
			y += yvel;

		}
	}
}

lifespan++;