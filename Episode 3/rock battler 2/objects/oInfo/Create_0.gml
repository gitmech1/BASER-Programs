// red: #E73133, #431C1E
// shrimp: #F9806B, #7B3E33
// orange: #FD9B30, #774012
// tan: #EFE4B9, #6B6552
// lime: #4CF664, #23792E
// green: #277E46, #10331B
// blue: #32C2F7, #186096
// purple: #BB5CF8, #552B7B
// magenta: #F92AF0, #4B132F

health1 = 1;
health2 = 1;
name1 = "Lime";
name2 = "Magenta";
colour1 = #4CF664;
comp1 = #23792E;
colour2 = #F92AF0;
comp2 = #4B132F;
sequence1 = "3212313213123121231231231212312312323332113223132123132321322313123132123233123123231232131222131232";
sequence2 = "12322311212321232212332121232231121232123221233212";
toptext = "who gonna win  -  idk  -  ";
damage = 0.04; //0.08 normal, 0.04 finale

grv = 0.6;
spd = 1;
fighting = true;
winner = ""; //left or right

lifespan = 0;
countdown = 9999;

fx = layer_get_fx("Pixelate");
self.font = font_add("Lemonmilk.otf", 240, false, false, 32, 127);