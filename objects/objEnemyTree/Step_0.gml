// Define the follow radius (this is the maximum distance the player can be for the dummy to follow)
var followRadius = 500;  // You can adjust this to any value you prefer

// Store the previous move direction when checking the player's position
var prevMoveDir = moveDir;

// Calculate the horizontal distance between the dummy and the player
var distanceToPlayer = objPlayer.x - x;

// Check if the player is within the follow radius
if (abs(distanceToPlayer) <= followRadius) {
    // Player is within radius, make the dummy move towards the player

    // Set movement direction based on player's position
    if (distanceToPlayer > 0) {
        moveDir = 1;  // Move right towards the player
		dynamicNum = 10;
    } else {
        moveDir = -1; // Move left towards the player
		dynamicNum = -10;
    }

    // Retain the movement direction when the player is directly above
    if (objPlayer.y < y - 16) {
        moveDir = prevMoveDir;  // Keep the previous direction
    }

    // Set the face direction based on the move direction
    face = moveDir;

    // Set the horizontal speed (xspd) based on the move direction and walking speed
    xspd = moveDir * moveSpd[0];  // This makes the dummy move towards the player
	
	// Check for collision with other enemies before moving
    if (place_meeting(x + dynamicNum, y, objEnemyTree)) {
       xspd = 0;
    }
	
	// idle when near player
	 if (place_meeting(x, y, objPlayer)) {
       xspd = 0;
    }

    // X collision handling
    var _subPixel = .5;
    if (place_meeting(x + xspd, y, objGround)) {
        // Scoot up to the wall precisely
        var _pixelCheck = _subPixel * sign(xspd);
        while (!place_meeting(x + _pixelCheck, y, objGround)) {
            x += _pixelCheck;
        }
        // Set xspd to zero if colliding
        xspd = 0;
    }
    // Move horizontally
    x += xspd;
} else {
    // Player is outside of the follow radius, do not move
    xspd = 0;  // Stop the dummy from moving
}

if (enemyHit){
	enemyHealth -= 50;
	if (enemyHealth <= 0) {
		instance_destroy(); 
	}
	xspd = 0;
	enemyHit = false;
}

// Y Movement (Gravity)
if (!onGround) {
    yspd += grav;  // Apply gravity to the vertical speed
} else {
    // Reset vertical speed when on the ground
    yspd = 0;
}

// Y Collision handling
var _subPixel = .5;
if (place_meeting(x, y + yspd, objGround)) {
    // Scoot up to the wall precisely
    var _pixelCheck = _subPixel * sign(yspd);
    while (!place_meeting(x, y + _pixelCheck, objGround)) {
        y += _pixelCheck;
    }
    // Stop vertical movement if colliding
    yspd = 0;
}

// Set if the dummy is on the ground
if (yspd >= 0 && place_meeting(x, y + 1, objGround)) {
    setOnGround(true);
} else {
    setOnGround(false);
}

// Move vertically
y += yspd;

// Sprite Control
if (abs(xspd) = 0) { sprite_index = idleSpr; }
// If moving horizontally, set the sprite to walking
if (abs(xspd) > 0) { sprite_index = walkSpr; }

// Set the collision mask
mask_index = maskSpr;

//// Check if the player collides with the enemy from above
//if (place_meeting(x, y, objPlayer)) {
//    // If the player is above the enemy (you can adjust this offset for the player's sprite height)
//    if (objPlayer.y < y - 100) {
//        with (objPlayer) {
//            // Only apply jump force if the player is not already falling or jumping
//            if (yspd == 0) {  // Ensure the player isn't already in the air
//                yspd = -jspd[0];  // Apply jump force when colliding from above
//            }
//        }
//        instance_destroy();  // Destroy the enemy instance
//    } else {
//         // Restart the game if colliding from the side or below
//    }
//}
