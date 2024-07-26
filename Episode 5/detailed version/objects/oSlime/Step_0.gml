var count = len(boings);

for (var i = 0; i < count; i++) {
	var a = -k * boings[i] - d * boingvel[i];
	boingvel[i] += a;
	boings[i] += boingvel[i];
}

for (var i = 0; i < count; i++) {
	if (!boinglocked[(i-1+count)%count]) {
		boingdeltal[i] = spread * (boings[i] - boings[(i-1+count)%count]);
		boingvel[(i-1+count)%count] += boingdeltal[i];
	}
	
	if (!boinglocked[(i+1)%count]) {
		boingdeltar[i] = spread * (boings[i] - boings[(i+1)%count]);
		boingvel[(i+1)%count] += boingdeltar[i];
	}
}

for (var i = 0; i < count; i++) {
	if (!boinglocked[(i-1+count)%count]) {
		boings[(i-1+count)%count] += boingdeltal[i];
	}
	if (!boinglocked[(i+1)%count]) {
		boings[(i+1)%count] += boingdeltar[i];
	}
}

//shaky boingin
if (oInfo.shakex != 0) || (oInfo.shakey != 0) {
	for (var i = 0; i < len(boingvel); i++) {
		if (irandom_range(1, 100) == 100) && (boinglocked[i] == 0) {
			boingvel[i] -= max(abs(oInfo.shakex), abs(oInfo.shakey));
		}
	}
}