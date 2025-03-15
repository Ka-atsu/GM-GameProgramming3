//Get inputs
getControls();

switch (state) 
{
	case PLAYERSTATE.FREE: playerState_Free(); break;
	case PLAYERSTATE.ATTACK_SLASH: playerState_Attack_Slash(); break;
	case PLAYERSTATE.ATTACK_COMBO: playerState_Attack_Combo(); break;
}
	
	// timer so the dmg is not continous
	if (invincible) {
	 invincibleTimer -= 1;
	    if (invincibleTimer <= 0) {
	        invincible = false;
	    }
	}
	
	if place_meeting(x, y, objSpike) || place_meeting(x, y, objSpear) {
		playerHealth -= 100
		if (playerHealth <= 0) {
			fadeToRoomRestart(60, c_black);
		}
	}	
	
	if (place_meeting(x, y, objEnemyTree)) {
	    if (!invincible) {
	        playerHealth -= 20;
	        invincible = true;       // Make the player temporarily invincible
	        invincibleTimer = 30;    // Set the duration (e.g., 30 frames)
	        if (playerHealth <= 0) {
	            room_restart();
	        }
	    }
	}
	
	if place_meeting(x, y, objDeathWall) {
		room_restart();
	}
	
	// SFX for walking sound
	if (isWalking && onGround) {
	    // Only start the sound if it's not already playing
	    if (sfxWalkingChannel == -1 || !audio_is_playing(sfxWalkingChannel)) {
	        sfxWalkingChannel = audio_play_sound(sfxWalking, 20, false);
	    }
	} else {
	    // Stop the walking sound if the player is not moving
	    if (sfxWalkingChannel != -1) {
	        audio_stop_sound(sfxWalkingChannel);
	        sfxWalkingChannel = -1;
	    }
	}