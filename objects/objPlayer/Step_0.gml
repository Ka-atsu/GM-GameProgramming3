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
		fadeToRoomRestart(60, c_black);
	}	
	
	if (place_meeting(x, y, objEnemyTree)) {
	    if (!invincible) {
	        playerHealth -= 12.5 // 60 - 12.5 per iteration eventually it will reach 5.5 and the rectangle sweet spot
	        invincible = true;       // Make the player temporarily invincible
	        invincibleTimer = 60;    // Set the duration (e.g., 30 frames)
	        if (playerHealth <= 5.5) {
	           fadeToRoomRestart(60, c_black);
	        }
	    }
	}
	
	if place_meeting(x, y, objDeathWall) || place_meeting(x, y, objWater) {
		fadeToRoomRestart(60, c_black);
	}
	
	// SFX for walking sound
	if (isWalking && onGround && state == PLAYERSTATE.FREE) {
	    // Only start the sound if it's not already playing
	    if (sfxWalkingChannel == -1 || !audio_is_playing(sfxWalkingChannel)) {
	        sfxWalkingChannel = audio_play_sound(sfxWalk, 20, false);
	    }
	} else {
	    // Stop the walking sound if the player is not moving
	    if (sfxWalkingChannel != -1) {
	        audio_stop_sound(sfxWalkingChannel);
	        sfxWalkingChannel = -1;
	    }
	}
	
	// SFX for walking sound
	// state == PLAYERSTATE.FREE is just to make sure the sound will work if its in idle state
	if (isRunning && onGround && state == PLAYERSTATE.FREE) {
	    // Only start the sound if it's not already playing
	    if (sfxRunningChannel == -1 || !audio_is_playing(sfxRunningChannel)) {
	        sfxRunningChannel = audio_play_sound(sfxRun, 20, false);
	    }
	} else {
	    // Stop the walking sound if the player is not moving
	    if (sfxRunningChannel != -1) {
	        audio_stop_sound(sfxRunningChannel);
	        sfxRunningChannel = -1;
	    }
	}
