/*for (var s = 0; s < len(slimes); s++) {
	
	var count = len(slimes[s].point.boings);

	for (var i = 0; i < count; i++) {
		var a = -k * slimes[s].point.boings[i] - d * slimes[s].point.boingvel[i];
		slimes[s].point.boingvel[i] += a;
		slimes[s].point.boings[i] += slimes[s].point.boingvel[i];
	}

	for (var i = 0; i < count; i++) {
		if (!slimes[s].point.boinglocked[(i-1+count)%count]) {
			slimes[s].point.boingdeltal[i] = spread * (slimes[s].point.boings[i] - slimes[s].point.boings[(i-1+count)%count]);
			slimes[s].point.boingvel[(i-1+count)%count] += slimes[s].point.boingdeltal[i];
		}
	
		if (!slimes[s].point.boinglocked[(i+1)%count]) {
			slimes[s].point.boingdeltar[i] = spread * (slimes[s].point.boings[i] - slimes[s].point.boings[(i+1)%count]);
			slimes[s].point.boingvel[(i+1)%count] += slimes[s].point.boingdeltar[i];
		}
	}

	for (var i = 0; i < count; i++) {
		if (!slimes[s].point.boinglocked[(i-1+count)%count]) {
			slimes[s].point.boings[(i-1+count)%count] += slimes[s].point.boingdeltal[i];
		}
		if (!slimes[s].point.boinglocked[(i+1)%count]) {
			slimes[s].point.boings[(i+1)%count] += slimes[s].point.boingdeltar[i];
		}
	}
}*/