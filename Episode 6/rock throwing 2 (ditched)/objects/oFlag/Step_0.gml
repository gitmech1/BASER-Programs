lifespan++;
lifespanner++;

yy = 0.025*power(min(80, lifespanner)-80, 2)+1739;
yoffset = sin(degtorad(lifespan*2))*8;

y = yy + yoffset;