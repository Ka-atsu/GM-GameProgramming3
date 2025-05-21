function treeState_Move(){
	sprite_index = idleSpr;
	mask_index = maskSpr;
	
	// Calculate the distance between the tree and the player
	var horizontalDistanceToPlayer = objPlayer.x - x;  // Horizontal distance
	var verticalDistanceToPlayer = objPlayer.y - y;    // Vertical distance

	// Calculate the straight-line distance (Euclidean distance)
	var distanceToPlayer = sqrt(horizontalDistanceToPlayer * horizontalDistanceToPlayer + verticalDistanceToPlayer * verticalDistanceToPlayer);
	show_debug_message(distanceToPlayer);
	// Play walking sound only if the tree is moving and within range of the player
	if (distanceToPlayer <= radius) {
	    if (!audio_is_playing(sfxWalkingChannel)) {
	        // Play the walking sound (only if it's not already playing)
	        sfxWalkingChannel = audio_play_sound(sfxEnemyTreeWalk, 20, true); // Looping sound
	    }
	} else {
	    if (audio_is_playing(sfxWalkingChannel)) {
	        // Stop the walking sound if the player is out of range
	        audio_stop_sound(sfxWalkingChannel);
	    }
	}

	if (abs(distanceToPlayer) <= followRadius && verticalDistanceToPlayer <= verticalFollowThreshold) {
		show_debug_message("Hello");
		state = TREESTATE.ATTACK;
	}
	
	
	
	// Assuming moveDir is 1 for right and -1 for left
	// Assuming moveSpd is an array, and moveSpd[0] is the speed of movement

	xspd = moveDir * moveSpd[0];
	x += xspd;

	// Check for collision with walls, other trees, or ground
	if (place_meeting(x + xspd, y, objGround) || 
	    place_meeting(x + xspd, y, objEnemyTree) || 
	    place_meeting(x + xspd, y, objGroundNoFriction) || 
		place_meeting(x + xspd, y, objInvisibleWall)) {
    
	    moveDir = -moveDir;  // Reverse direction when collision is detected
	}

	// Additional check to detect collision with another tree moving in the opposite direction
	if (place_meeting(x + xspd, y, objEnemyTree)) {
	    // If the other tree is coming from the opposite direction, reverse their directions
	    var otherTree = instance_place(x + xspd, y, objEnemyTree);
    
	    // Check the other tree's direction
	    if (otherTree != noone && otherTree.moveDir == -moveDir) {
	        // Reverse both directions if two trees are coming toward each other
	        moveDir = -moveDir;
	        otherTree.moveDir = -otherTree.moveDir;
	    }
	}
	
	// Apply gravity if the dummy is not on the ground
	if (!onGround) {
		yspd += grav;  // Increment vertical speed by gravity
	} else {
		yspd = 0;  // Reset vertical speed if on the ground
	}

	// Check for vertical collisions and adjust vertical position to prevent passing through the ground
	var _subPixel = .5;
	if (place_meeting(x, y + yspd, objGround)) {
		var _pixelCheck = _subPixel * sign(yspd);
		while (!place_meeting(x, y + _pixelCheck, objGround)) {
		    y += _pixelCheck;
		}
		yspd = 0;  // Stop vertical movement upon collision
	}

	// Update grounded state based on collision check directly beneath the dummy
	if (yspd >= 0 && place_meeting(x, y + 1, objGround)) {
		setOnGround(true);
	} else {
		setOnGround(false);
	}

	// Apply vertical movement
	y += yspd;
	
	
	// Handle enemy being hit and reduce health
	if (enemyHit){
	    enemyHealth -= 50;
	    if (enemyHealth <= 0) {
			audio_play_sound(sfxHitTree, 20, false);
	        instance_destroy();  // Remove the enemy instance from the game
	    }
	    xspd = 0;
	    enemyHit = false;
	}
}