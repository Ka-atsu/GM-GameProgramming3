//DRAW GUI SO it follow the camera insted and I added layer Just look at room

draw_self();

//Draw if the player is IN or There is a player
if !instance_exists(objPlayer) exit;

//Set to red
draw_set_color(c_red);
//draw rectangle in the coordinates 4,4 and 123,11 you can check in the sprite
draw_rectangle(x+12, y+5, x+131*(objPlayer.playerHealth/objPlayer.maxHealth), y+12, false);
//Set it back because it will just be red all the time
draw_set_color(c_white);