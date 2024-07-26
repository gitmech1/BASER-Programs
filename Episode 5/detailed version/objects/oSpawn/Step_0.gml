image_angle += 2;

var xscale = 1;
var yscale = 1;

for (var i = 0; i < len(triggered); i++) {
	if (triggered[i] != 0) {
		xscale *= 2-elastic_ease(triggered[i]/120);
		yscale *= 2-elastic_ease(triggered[i]/120);
		triggered[i] += 1;
	}
}

image_xscale = xscale;
image_yscale = yscale;