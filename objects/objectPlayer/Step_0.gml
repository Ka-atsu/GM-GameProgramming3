//Get inputs
getControls();

switch (state) 
{
	case PLAYERSTATE.FREE: playerState_FREE(); break;
}

	//Wall jump
	if (!onGround && (place_meeting(x + 5, y, obj_ground) || place_meeting(x - 5, y, obj_ground))) {
	   jumpCount = 1;
	}
	
	if place_meeting(x, y, objectSpike) {
    playerHealth -= 10; // Decrease health on collision
	    if (playerHealth <= 0) {
	        // Trigger death or restart the room
	        room_restart();
		}
	}	
	
	