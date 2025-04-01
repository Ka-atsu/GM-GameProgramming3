function playerState_Free(){
	//X Movement (Horizontal Movement)
	moveDir = rightKey - leftKey;

	//Get my face
	if moveDir != 0 { face = moveDir};

	//Get xspd
	runType = runKey;
	xspd = moveDir * moveSpd[runType];
	
	// Wall jump detection
	// x + 1 wall on right , x - 1 wall on left
	// 1 - 0 = 1   0 - 1 = -1
	onwall = place_meeting(x + 1, y, objGround) - place_meeting(x - 1, y, objGround);
	//show_debug_message(onwall);

	// Update wasOnWall when the player is on a wall
	// it saves the onwall before it goes to 0 it saves the old one meaning if its 1 before it become 0 again it saves 1
	if (onwall != 0) {
	    wasOnWall = onwall; // Store the wall direction (1 for right, -1 for left)
	}
	
	// When the wall jump is initiated
	// for now if the right or left key is pressed against the wall it shouldnt work
	// Disabling the right/left keys if the player is on a wall
	
	if (onwall != 0 ) {
		xspd = 0;
			if (jumpKeyPressed && !onGround && rightKey == 0 && leftKey ==0) {
		    yspd = -16;
		    targetXspd = -onwall * 50;
		    wallJumpActive = true;  // Start smoothing the x speed
		    jumpStartX = x;        // Record the starting x position
        
			//show_debug_message(rightKey, leftKey);
		    //show_debug_message("Jump initiated");
		}
	}
	

	// In your Step event, continuously smooth xspd while the flag is active
	if (wallJumpActive) {
	    xspd = lerp(xspd, targetXspd, 0.1);  // Smooth the x speed toward targetXspd
	    x += xspd;                           // Update the x position
    
	    // Stop updating when the character has moved 300 units from the starting x
		// Stop if hitting a wall || pressing keys
	    if (abs(x - jumpStartX) >= 300 || place_meeting(x + xspd, y, objGround) || rightKey || leftKey) {
	        wallJumpActive = false;
	        //show_debug_message("Wall jump movement complete");
	    }
	} else 
	if (onwall != 0) { 
	    termVel = 3;
	} else { 
	    termVel = 20;
	}
	
	//X collision
	var _subPixel = .5;
	if place_meeting(x + xspd, y, objGround)
	{
		//Scoot up to wall precisely
		var _pixelCheck = _subPixel * sign(xspd);
		while !place_meeting(x + _pixelCheck, y, objGround)
		{
			x += _pixelCheck;
		}
		//Set xspd to zero
		xspd = 0;
	}
	//Move
	x += xspd
	
	//Y Movement (Vertical Movement - Gravity, Jumping)
	//Gravity
	if coyoteHangTimer > 0
	{
		//Count the timer down
		coyoteHangTimer--;
	} else {
		//apply gravity to the player
		yspd += grav;
		//We're no longer on the ground
		setOnGround(false);
	}
	
	// Handling landing and playing the sound effect
	if (!onAir && onGround) {
	    audio_play_sound(sfxLand, 20, false);  // Play landing sound
	}

	// Update wasOnGround for the next frame
	onAir = onGround;
	
	//Reset/Prepare Jumping variables
	if onGround
	{
		jumpCount = 0;
		coyoteJumpTimer  = coyoteJumpFrames;
	} else {
		//If player is in the air, make sure they can't do an extra jump
		coyoteJumpTimer--;
		if jumpCount == 0 && coyoteJumpTimer <= 0 { jumpCount = 1; };
	}
	
	//show_debug_message(jumpCount);
	
	//Initiate the Jump
	if jumpKeyBuffered && jumpCount < jumpMax
	{
		audio_play_sound(sfxJump, 20, false);
		//Reset the buffer
		jumpKeyBuffered = false;
		jumpKeyBufferTimer = 0;
		
		//Increase the number of performed jumps
		jumpCount++
		
		//Set the jump hold timer
		jumpHoldTimer = jumpHoldFrames[jumpCount-1];
		
		//Tell ourself we are no longer in the ground
		setOnGround(false);
	}
	//Cut off the jump by releasing the jump button
	if !jumpKey
	{
		jumpHoldTimer = 0;
	}
	//Jump based on the timer/holding the button
	if jumpHoldTimer > 0
	{
		//Constantly set the yspd to be the jumping speed
		yspd = jspd[jumpCount-1];
		//Count down the timer
		jumpHoldTimer--;
	}
	
	//Y Collision (Handling Vertical Collisions)
	//Cap falling speed
	if yspd > termVel { yspd = termVel; };
	
	//Collision
	_subPixel = .5;
	if place_meeting( x, y + yspd, objGround)
	{
		//Scoot up to the wall precisely
		var _pixelCheck = _subPixel * sign(yspd);
		while !place_meeting( x, y + _pixelCheck, objGround) { y += _pixelCheck };
			
		//Bonk code
		if yspd < 0
		{
			jumpHoldTimer = 0;
		}
			
		//Set yspd to 0 collide
		yspd = 0;
	}
	
	//Set if I'm on the ground
	if yspd >= 0 && place_meeting( x, y+1, objGround)
	{
		setOnGround(true);
	}

	//Move
	y += yspd


	// Sprite Control
	// Walking
	if (abs(xspd) > 0) { 
	    sprite_index = walkSpr; 
	    isRunning = false;
	    isWalking = true;
	} else { 
	    isWalking = false;
	}

	// Running
	if (abs(xspd) >= moveSpd[1]) { 
	    sprite_index = runSpr;  
	    isWalking = false;
	    isRunning = true; 
	} else { 
	    isRunning = false;
	}

	// Not Moving (Idle)
	if (xspd == 0) { 
	    sprite_index = idleSpr; 
	}

	// In the air (Jumping or Falling)
	if (!onGround) { 
	    // Wall Jump
	    if (onwall != 0) {
	        sprite_index = sprPlayerJump2;  // Wall jump sprite
	        image_xscale = onwall; // Flip direction during wall jump (1 for right, -1 for left)
	    } 
	    // Normal Jumping (Not on a wall) and come from a wall
	    else if (onwall == 0  && wasOnWall != 0) {
			//show_debug_message(face);
			face = -face;
	        sprite_index = jumpSpr;  // Normal jump sprite
	        // Use wasOnWall to keep direction from the previous wall state
	        image_xscale = (wasOnWall == 1) ? -1 : 1; // Flip based on the previous wall state
		
			if(leftKey != 0 || rightKey !=0) {
				//show_debug_message(face);
				face = -face;
				image_xscale = face; // Flip based on the previous wall state
			}
	    }
		// not on a wall and also it didnt come from a wall
		else if (onwall == 0 && wasOnWall == 0) {
		
			//show_debug_message(face);
	        sprite_index = jumpSpr;  // Normal jump sprite
	        image_xscale = face;
	    }
	} else {
		//show_debug_message(face);
	    image_xscale = face;
		// this is essential to reset the was on Wall
		wasOnWall = 0;
	}
	
		//set the collision mask
		mask_index = maskSpr
	
	//IF clicked change state
	//if (attackKey) {
	//	instance_create_layer(x - face * 100, y - 100, "Player", objAttack);
	//	show_debug_message("sda");
	//}
	//if (attackKey && onwall == 0) state = PLAYERSTATE.ATTACK_SLASH;
}