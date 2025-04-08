// Step Event of obj_on_top

// Reference to the player object
var player = objPlayer;  

// Make the object follow the player with a delay (slower speed)
x = lerp(x, player.x, follow_speed);
y = lerp(y, player.y - 32, follow_speed);  // Keep it on top by adjusting Y offset
