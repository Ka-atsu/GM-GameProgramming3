//Get inputs
getControls();

switch (state) 
{
	case PLAYERSTATE.FREE: playerState_FREE(); break;
}

	//Wall jump
	if (!onGround && (place_meeting(x + 1, y, objectWall) || place_meeting(x - 1, y, objectWall))) {
	   jumpCount = 1;
	}
	
	if place_meeting(x, y, objectSpike) {
    playerHealth -= 10; // Decrease health on collision
	    if (playerHealth <= 0) {
	        // Trigger death or restart the room
	        room_restart();
		}
	}	
	
	