function playerState_Free(){
	//X Movement (Horizontal Movement)
	moveDir = rightKey - leftkey;

	//Get my face
	if moveDir != 0 { face = moveDir};

	//Get xspd
	runType = runKey;
	xspd = moveDir * moveSpd[runType];
	
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
	
	//Initiate the Jump
	if jumpKeyBuffered && jumpCount < jumpMax
	{
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
	
	
	//Wall jump
	var touchingRightWall = place_meeting(x + 5, y, objGround);
	var touchingLeftWall = place_meeting(x - 5, y, objGround);

	if (!onGround && (touchingRightWall || touchingLeftWall)) {
	    jumpCount = 1;
	    termVel = 1;
		
	    // Determine which way to face based on which wall is touched
	    //if (touchingRightWall) {
	        //face = -1; // Face left if on the right wall
	    //} else if (touchingLeftWall) {
	       // face = 1; // Face right if on the left wall
	    //}
		// = false; // Reset the jump key buffer
	   // image_xscale = face;
	} else { 
	    // Reset the character direction based on face when not touching walls
	   // image_xscale = face; // update here insted in draw cuz of some bug
	    termVel = 10;
	}
	
	//Sprite Control
	//walking
	if abs(xspd) > 0 { 
		sprite_index = walkSpr; 
		isWalking = true;
	} else { isWalking = false; }
	//Running
	if abs(xspd) >= moveSpd[1] { sprite_index = runSpr; };
	//not Moving
	if xspd == 0 { sprite_index = idleSpr; };
	//in the air
	if !onGround { sprite_index = jumpSpr; };
	
	//set the collision mask
	mask_index = maskSpr
	
	//IF clicked change state
	if (attackKey) state = PLAYERSTATE.ATTACK_SLASH;
}