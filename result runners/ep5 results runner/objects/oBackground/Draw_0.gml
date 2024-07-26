var tween = ease_in(clamp(oManager.time_elapsed-1000, 0, 1200)/200, 2.5);
var xmove = -tween * 3000;
var ymove = tween * 800;
var smove = tween*3 + 1;

//backround
var distance = 1500;
draw_triangle_color((padding-10+xmove)*smove, (padding-10+ymove)*smove, (padding-10+xmove)*smove, (1440+10-padding+ymove)*smove, -distance, 1440+distance, #070612, #070612, #070612, false); //left
draw_triangle_color((padding-10+xmove)*smove, (1440+10-padding+ymove)*smove, (2560+10-padding+xmove)*smove, (1440+10-padding+ymove)*smove, -distance, 1440+distance, #051823, #051823, #051823, false); //bottom
draw_rectangle_color((padding-10+xmove)*smove, (padding-10+ymove)*smove, (2560+10-padding+xmove)*smove, (1440+10-padding+ymove)*smove, #0C2738, #0C2738, #0C2738, #0C2738, false);