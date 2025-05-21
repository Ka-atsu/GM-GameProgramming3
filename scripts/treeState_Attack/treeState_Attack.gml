function treeState_Attack() {
	sprite_index = walkSpr; 
	mask_index = maskSpr;
	
	// Store the previous movement direction to maintain behavior under certain conditions
	var prevMoveDir = moveDir;

	// Track whether the dummy was moving towards the player in the previous frame
	var wasMoving = false;
	
	var distanceToPlayer = objPlayer.x - x;
	var verticalDistanceToPlayer = abs(objPlayer.y - y);

	// Check if the player is within the horizontal and vertical follow distances
	if (abs(distanceToPlayer) <= followRadius && verticalDistanceToPlayer <= verticalFollowThreshold) {
	    // Check if the dummy was not moving previously, and start playing the walking sound if necessary
	    if (!wasMoving) {
	        if (sfxWalkingChannel == -1 || !audio_is_playing(sfxWalkingChannel)) {
	            sfxWalkingChannel = audio_play_sound(sfxEnemyTreeWalk, 20, false);
	        }
	        wasMoving = true;
	    }

	    // Determine the direction to move based on the player's relative horizontal position
	    if (distanceToPlayer > 0) {
	        moveDir = 1;  // Move right
	    } else {
	        moveDir = -1; // Move left
	    }

	    // Set the horizontal speed based on the direction; assumes moveSpd[0] is defined elsewhere as a speed value
	    xspd = moveDir * moveSpd[0];  

	    // Check for collisions with other enemies in the direction of movement before actually moving
	    if (place_meeting(x + moveDir * 10, y, objEnemyTree)) {
	        xspd = 0;  // Stop movement if collision is detected
	    }

	    // If the dummy is very close to the player, stop moving
	    if (place_meeting(x, y, objPlayer)) {
	        xspd = 0;
	    }
	
		var _subPixel = .5;
	    if (place_meeting(x + xspd, y, objGround)) {
	        var _pixelCheck = _subPixel * sign(xspd);
	        while (!place_meeting(x + _pixelCheck, y, objGround)) {
	            x += _pixelCheck;
	        }
	        xspd = 0;  // Stop movement if a solid ground collision occurs
	    }

	    // Apply the calculated horizontal movement
	    x += xspd;
	} else {
	    // If the player is out of the follow range, stop the dummy and its movement sound
		state = TREESTATE.MOVE;
	    //xspd = 0;
	    //wasMoving = false;
	    //if (sfxWalkingChannel != -1) {
	    //    audio_stop_sound(sfxWalkingChannel);
	    //    sfxWalkingChannel = -1;
	    //}
	}

	// Handle enemy being hit and reduce health
	if (enemyHit){
	    enemyHealth -= 50;
	    if (enemyHealth <= 0) {
	        audio_stop_sound(sfxWalkingChannel);  // Stop any sounds before destroying
			audio_play_sound(sfxHitTree, 20, false);
	        instance_destroy();  // Remove the enemy instance from the game
	    }
	    xspd = 0;
	    enemyHit = false;
	}
}