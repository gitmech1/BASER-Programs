var camx = clamp(oCamera.x, 1366/2, 20000-1366/2);
var camy = clamp(oCamera.y, 768/2, 2000-768/2);

x = camx - (camx-10000)/(10000/700)     +30;
y = camy + 400 - (camy-2000)/(2000/200) +10;