//why use the alarm of object player
//because after colliding i am destroying the object so if its 
//here the timer wont start
with (objPlayer) {
	global.scale = 1.5;  // Increase scale when the player collides with the orb
	alarm[0] = global.collision_duration; 
}
	
instance_destroy();
