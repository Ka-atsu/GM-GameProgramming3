//Get inputs
getControls();

switch (state) 
{
	case PLAYERSTATE.FREE: playerState_Free(); break;
	case PLAYERSTATE.ATTACK_SLASH: playerState_Attack_Slash(); break;
	case PLAYERSTATE.ATTACK_COMBO: playerState_Attack_Combo(); break;
}

	if place_meeting(x, y, objSpike) {
    playerHealth -= 1; // Decrease health on collision
	    if (playerHealth <= 0) {
	        // Trigger death or restart the room
	        room_restart();
		}
	}	
	
	//go to next room
	if place_meeting(x,y,objFinish)
	{
		room_goto_next();
	}
	