if (ypos >= -3000) && (ypos <= 10000) {
	points = update_2d(shape);
	draw_rectangle_color(0, 720, 2560, 1440, #449251, #449251, #449251, #449251, false);
}

ground_check = false;
water_check = false;
back_drawn = 0;

var i = 0;
for (var j = 0; j < len(points)-2; j++) {
	
	if (ypos >= -3000) && (ypos <= 10000) {
		if (max(shape[j][0][0][2], shape[j][0][1][2], shape[j][0][2][2]) < zpos) { //behidn eye cutting
			if !((shape[j][4] == "ground" || shape[j][4] == "water") && ypos > 10000) { //cancel out ground and water to ocean can be seen
				var aveg = average_3d(shape[j][0][0], shape[j][0][1], shape[j][0][2]);
				var distance = pythag_3d(xpos, aveg[0]/5, ypos, aveg[1], zpos, aveg[2]);
				width = 700/distance+1;
				draw_trongle(points[i], points[i][1], points[i][2]);
			}
		}
	}
	
	//doubkle up for ground and water, as it is 1 shape but 2 points
	if (shape[j][4] == "ground") && !(ground_check) {
		j--;
		ground_check = true;
	}
	if (shape[j][4] == "water") && !(water_check) {
		j--;
		water_check = true;
	}
	i++;
	
	if (ground_check) && (water_check) && (back_drawn == 1) {
		//clouds
		var tl = convert_to_2d([1500*43, -300+1500*43, -16000]);
		var br = convert_to_2d([-1500*43, -300, -16000]);
		draw_sprite_stretched_ext(sClouds, 0, tl[0], tl[1], br[0]-tl[0], br[1]-tl[1], -1, 1);
		
		var tl = convert_to_2d([1500*24, -300+1500*24, -10000]);
		var br = convert_to_2d([-1500*24, -300, -10000]);
		draw_sprite_stretched_ext(sClouds, 0, tl[0], tl[1], br[0]-tl[0], br[1]-tl[1], -1, 1);
		
		var tl = convert_to_2d([1500*12, -300+1500*12, -6000]);
		var br = convert_to_2d([-1500*12, -300, -6000]);
		draw_sprite_stretched_ext(sClouds, 0, tl[0], tl[1], br[0]-tl[0], br[1]-tl[1], -1, 1);
		
		//mountain
		//left
		var tl = convert_to_2d([3000*7, -300+1500*7, -4750]);
		var br = convert_to_2d([0*7, -300, -4750]);
		draw_sprite_stretched_ext(sMountain, 0, tl[0], tl[1], br[0]-tl[0], br[1]-tl[1], -1, 1);
		//right
		var tl = convert_to_2d([0*7, -300+1500*7, -4750]);
		var br = convert_to_2d([-3000*7, -300, -4750]);
		draw_sprite_stretched_ext(sMountain, 1, tl[0], tl[1], br[0]-tl[0], br[1]-tl[1], -1, 1);
		
		//trees
		//left
		var tl = convert_to_2d([3000*7, -300+1500*7, -4500]);
		var br = convert_to_2d([0*7, -300, -4500]);
		draw_sprite_stretched_ext(sTrees, 0, tl[0], tl[1], br[0]-tl[0], br[1]-tl[1], -1, 1);
		//right
		var tl = convert_to_2d([0*7, -300+1500*7, -4500]);
		var br = convert_to_2d([-3000*7, -300, -4500]);
		draw_sprite_stretched_ext(sTrees, 1, tl[0], tl[1], br[0]-tl[0], br[1]-tl[1], -1, 1);
		
		back_drawn++;
	} else if !(back_drawn) && (ground_check) && (water_check) {
		back_drawn++;
	}
}

if (ypos <= -3000) {
	draw_rectangle_color(0, 0, 2560, 1440, #545454, #545454, #545454, #545454, false);
}

var s = 0.35; //scale
var sprites = [sSnowy, sDirt, sGlassBack, sCloud]; //sprites for mauin stuff
var top_sprites = [sBase, sBack, sFront, sBackGlass, sFrontGlass]; //sprites for top part only

var tl = convert_to_2d([2560*s, 20000*s, 125]);
var br = convert_to_2d([-2560*s, 0, 125]);

var tl2 = convert_to_2d([3000*s, 20000*s, 125]);
var br2 = convert_to_2d([-3000*s, 0, 125]);

var tl3 = convert_to_2d([6000*s, 20000*s, 125]);
var br3 = convert_to_2d([-6000*s, 0, 125]);

for (var k = 0; k < 5; k++) {

	var difference = abs(tl[1]-br[1])/10;
	var differencex = abs(tl2[0]-br2[0]);
	var differencey = abs(tl2[1]-br2[1])*0.3;
	if (k == 2) {
		for (var j = 0; j < 6; j++) {
			for (var i = 0; i < 10; i++) {
				draw_sprite_stretched(sprites[k], 9-i, tl[0], br[1]-difference*(i+1)-difference*j*9.65, abs(tl[0]-br[0]), difference);
			}
		}
	} else if (k == 3) {
		//nothing here, sorry if code a massive mess
	} else if (k == 4) {
		for (var j = 0; j < 4; j++) { //base
			draw_sprite_stretched(top_sprites[0], j, tl3[0], br3[1]-difference*5*(1-j)-differencey*9.73*(k), abs(tl3[0]-br3[0]), difference*5);
		}
		for (var j = 0; j < 2; j++) { //back of first area
			draw_sprite_stretched_ext(top_sprites[1], j, tl3[0], br3[1]-difference*5*(1-j)-differencey*9.73*(k), abs(tl3[0]-br3[0]), difference*5, -1, visibility);
		}
		for (var j = 0; j < 2; j++) { //back of glass area
			draw_sprite_stretched_ext(top_sprites[3], j, tl3[0], br3[1]-difference*5*(1-j)-differencey*9.73*(k), abs(tl3[0]-br3[0]), difference*5, -1, visibility);
		}
	} else if (k == 1) {
		for (var i = 0; i < 10; i++) {
			draw_sprite_stretched(sprites[k], 9-i, tl[0], br[1]-difference*(i+1)-difference*9.855*(k-2), abs(tl[0]-br[0]), difference);
		}
	} else {
		for (var i = 0; i < 11; i++) {
			draw_sprite_stretched(sprites[k], 10-i, tl[0], br[1]-difference*(i)-difference*9.855*(k-2), abs(tl[0]-br[0]), difference);
		}
	}

}


//drawing of finish lines
for (var i = 1; i < len(oInfo.point_list); i++) { 
	var point = convert_to_2d([0, oInfo.point_list[i], 135]);
	draw_set_alpha(0.4);
	draw_line_width_color(0, point[1], 2560, point[1], 5, c_red, c_red);
	draw_set_alpha(1);
}


//drawing of the rockys
for (var i = 0; i < len(oInfo.colours); i++) {
	var rock = oInfo.colours[i][6];
	var amount_dead = 1-round(oInfo.colours[i][7]/8);
	
	var tl = convert_to_2d([-rock.x+16, rock.y-16, 125]);
	var br = convert_to_2d([-rock.x-16, rock.y+16, 125]);
	
	var sizing = abs(tl[0]-br[0]);
	
	draw_sprite_ext(sRock, 0, avg([tl[0], br[0]]), avg([tl[1], br[1]]), sizing/32*1.6, sizing/32*1.6, rock.r, rock.rock_colour, amount_dead);
}

//val usto vos arrol punto upwardo
if (oInfo.lifespan < 360) {
	for (var i = 0; i < len(oInfo.colours); i++) {
		var rock = oInfo.colours[i][6];
		var point = convert_to_2d([-rock.x, rock.y, 125]);
		var reference = convert_to_2d([-rock.x+100, rock.y, 125]);
		
		var sizing = abs(point[0]-reference[0])/200 * rock.arrow_size;
		
		draw_sprite_ext(sArrow, 0, point[0], point[1], sizing, sizing, rock.arrow_rot, -1, 1);
	}
}

//el drawing obstaculos
for (var i = 0; i < len(oInfo.obstacles); i++) {
	var obstacle = oInfo.obstacles[i];
	
	var tl = convert_to_2d([-obstacle.x+800, obstacle.y-800, 125]);
	var br = convert_to_2d([-obstacle.x-800, obstacle.y+800, 125]);
	
	var sizing = abs(tl[0]-br[0])/1600;
	
	draw_sprite_ext(sObstacles, obstacle.image_index, avg([tl[0], br[0]]), avg([tl[1], br[1]]), sizing*obstacle.xscale, sizing*obstacle.yscale, 0, -1, obstacle.image_alpha);
}

//drawing of the boosters
for (var i = 0; i < len(oInfo.boosters); i++) {
	var booster = oInfo.boosters[i][0];
	
	var tl = convert_to_2d([-booster.x+82, booster.y-52, 128]);
	var br = convert_to_2d([-booster.x-82, booster.y+52, 128]);
	
	var sizing = abs(tl[0]-br[0]);
	
	draw_sprite_ext(sBoosta, round(booster.lifespan/30)%2+(1-booster.normal)*2, avg([tl[0], br[0]]), avg([tl[1], br[1]]), sizing/164*booster.image_xscale, sizing/164*booster.image_yscale, booster.r, -1, 0.7*booster.image_alpha);
}

//the extra front glass
var tl = convert_to_2d([2560*s, 20000*s, 125]);
var br = convert_to_2d([-2560*s, 0, 125]);
var difference = abs(tl[1]-br[1])/10;
for (var j = 0; j < 6; j++) {
	for (var i = 0; i < 10; i++) {
		draw_sprite_stretched(sGlassFront, 9-i, tl[0], br[1]-difference*(i+1)-difference*j*9.65, abs(tl[0]-br[0]), difference);
	}
}


//extra layer on top part
draw_sprite_stretched_ext(top_sprites[2], j, tl3[0], br3[1]-difference*5*(0)-differencey*9.73*4, abs(tl3[0]-br3[0]), difference*5, -1, visibility);
for (var j = 0; j < 2; j++) { //front of glass area
	draw_sprite_stretched_ext(top_sprites[4], j, tl3[0], br3[1]-difference*5*(1-j)-differencey*9.73*4, abs(tl3[0]-br3[0]), difference*5, -1, visibility);
}


//clouds
var differencex = abs(tl2[0]-br2[0]);
var differencey = abs(tl2[1]-br2[1])*0.3;
for (var i = 0; i < 5; i++) {
	for (var j = 0; j < 2; j++) {
		var shift = -(j*2-1);
		draw_sprite_stretched(sprites[3], 9-i*2-j, tl2[0]+differencex/2*shift, br2[1]-differencey*(i+1)-differencey*9.67*3, abs(tl2[0]-br2[0]), differencey);
	}
}


//drawing of the splosions
for (var i = 0; i < len(oInfo.colours); i++) {
	var rock = oInfo.colours[i][6];
	var amount_dead = round(oInfo.colours[i][7]);
	
	if (amount_dead >= 0) {
		var tl = convert_to_2d([-rock.x+16, rock.y-16, 125]);
		var br = convert_to_2d([-rock.x-16, rock.y+16, 125]);
	
		var sizing = abs(tl[0]-br[0]);
	
		draw_sprite_ext(sExplosion, min(17, amount_dead), avg([tl[0], br[0]]), avg([tl[1], br[1]]), sizing/8, sizing/8, 0, -1, 1);
		
		oInfo.colours[i][7] += 0.5;
	}
}


//the suck
if (oInfo.sucking) {
	var tl = convert_to_2d([500, 71200-1500, 128]);
	var br = convert_to_2d([-500, 71200+1500, 128]);
	
	var sizing = abs(tl[0]-br[0])/1000;
	var one = clamp(oInfo.sucking, 0, 20)/20;
	var two = (1-clamp(oInfo.sucking-340, 0, 100)/100);
	var alpha = one * two;
	
	draw_sprite_ext(sSuck, 0, avg([tl[0], br[0]]), avg([tl[1], br[1]]), sizing, sizing, 0, -1, alpha);
}


/*draw_text(100, 100, xpos);
draw_text(100, 115, ypos);
draw_text(100, 130, zpos);*/



/*drawing of the borders
for (var i = 0; i < len(oInfo.collisions); i++) {
	var border = oInfo.collisions[i];
	
	var tl = convert_to_2d([-border[0], border[1], 125]);
	var br = convert_to_2d([-border[2], border[3], 125]);
	
	var sizing = min(abs(tl[0]-br[0]), abs(tl[1]-br[1]));
	
	draw_border_rectangle(tl[0], tl[1], br[0], br[1], sizing/20, #00A651, #42CE85);
}*/



/*for (var i = 0; i < len(oInfo.colours); i++) {
	var rockle = oInfo.colours[i][6];
	
	var point = convert_to_2d([-rockle.x, rockle.y, 125]);
	
	draw_circle_color(point[0], point[1], 10, oInfo.colours[i][1], oInfo.colours[i][1], false);
}*/





