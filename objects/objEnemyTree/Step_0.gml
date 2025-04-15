// Define the follow radius and vertical follow threshold
var followRadius = 500;  // Maximum horizontal distance for the dummy to start following the player
var verticalFollowThreshold = 50;  // Maximum vertical distance for the dummy to consider following the player

// Store the previous movement direction to maintain behavior under certain conditions
var prevMoveDir = moveDir;

// Calculate the horizontal and vertical distances between the dummy and the player
var distanceToPlayer = objPlayer.x - x;
var verticalDistanceToPlayer = abs(objPlayer.y - y);

// Track whether the dummy was moving towards the player in the previous frame
var wasMoving = false;

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
    xspd = 0;
    wasMoving = false;
    if (sfxWalkingChannel != -1) {
        audio_stop_sound(sfxWalkingChannel);
        sfxWalkingChannel = -1;
    }
}

// Handle enemy being hit and reduce health
if (enemyHit){
    enemyHealth -= 50;
    if (enemyHealth <= 0) {
        audio_stop_sound(sfxWalkingChannel);  // Stop any sounds before destroying
        instance_destroy();  // Remove the enemy instance from the game
    }
    xspd = 0;
    enemyHit = false;
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

// Update the sprite based on movement; idle if not moving, walking if moving
if (abs(xspd) == 0) { 
    sprite_index = idleSpr; 
} else {
    sprite_index = walkSpr; 
}

// Set the collision mask for the dummy
mask_index = maskSpr;