//health1 = 0.5 + sin(degtorad(lifespan*6))*0.3 + sin(degtorad(lifespan*8.17))*0.2 + sin(degtorad(lifespan*14.23))*0.1
//health2 = 1-health1;

lifespan++;

if !(lifespan%60) {
	spd *= 1.025;
}

if !(fighting) {
	spd = lerp(spd, 0.55, 0.02);
	countdown--;
}