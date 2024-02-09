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
name1 = "Tan";
name2 = "Orange";
colour1 = #EFE4B9;
comp1 = #6B6552;
colour2 = #FD9B30;
comp2 = #774012;
sequence1 = "1112222333311323123321221221122211222213322213333133333222333223333233111221123221111233213332231112";
sequence2 = "122133121323121232122133122132112123121232112123122133121232121312112123122133122121122121112123122112122211121311121323112123122213122121122131121333";
toptext = "Round 13  -  Tan vs. Orange  -  Winners Winners Bracket  -  FINALE 2 -  ";
roundtext = "Round 13";
damage = 0.04; //0.08 normal, 0.04 finale

grv = 0.6;
spd = 1;
fighting = true;
winner = ""; //left or right

lifespan = 0;
countdown = 9999;

fx = layer_get_fx("Pixelate");
self.font = font_add("Lemonmilk.otf", 240, false, false, 32, 127);