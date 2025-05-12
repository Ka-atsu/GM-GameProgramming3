//Custom functions for player
function setOnGround(_val = true)
{
	if _val == true
	{
		onGround = true;
		coyoteHangTimer = coyoteHangFrames
	} else {
		onGround = false;
		coyoteHangTimer = 0;
	}
}

//Exit if theres no player
if !instance_exists(objPlayerFollower) {
	instance_create_layer(x, y, "Managers", objPlayerFollower);
}

//control setup
controlsSetup();

//Health 
//Watch HeartBeast Game maker Health bar
maxHealth = 68;
playerHealth = maxHealth; 

//Sprites
maskSpr = sprPlayerIdle;
idleSpr = sprPlayerIdle;
walkSpr = sprPlayerWalk;
runSpr = sprPlayerRun;
jumpSpr = sprPlayerJump;
jumpSpr2 = sprPlayerJump2;
atkSpr = sprPlayerAttack;
hb = sprPlayerHb;
hb_left = sprPlayerHb_Left;
dashEffectSpr = sprDash;
dashSpr = sprPlayerDash;

//Moving
face = 1;
moveDir = 0;
runType = 0;
moveSpd[0] = 10;
moveSpd[1] = 12.5;
moveSpdNotArray = 10;
xspd = 0;
yspd = 0;

//Jumping
grav = .5;
termVel = 0; // inside the free state i am changing the termvel
onGround = true;
onAir = false;
jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;
lastDirection = 0;
temp = 0;

//Jump values for each successive jump
jumpHoldFrames[0] = 6;
jspd[0] = -13.15
jumpHoldFrames[1] = 3;
jspd[1] = -12.85;
jspdNotArray = -12;

//Coyote Time
//Hang Time
coyoteHangFrames = 3;
coyoteHangTimer = 0;

//Jump buffer time
coyoteJumpFrames = 5;
coyoteJumpTimer = 0;

//InvincibleTimer
invincible = false;
invincibleTimer = 0;

//Moving
isWalking = false;
isRunning = false;
wallJumpActive = false;
dashActive = false;

//Wall
wasOnWall = 0;

//Dash
dashSpd = 30;
dashTimer = 0;

//SFX
sfxWalkingChannel = -1; // -1 means no channel is currently used
sfxRunningChannel = -1;

//Call the state
state = PLAYERSTATE.FREE;
//Things that had been hit by the player like a array
hitByAttack = ds_list_create();

//Enum is like a global variable
enum PLAYERSTATE
{
	FREE,
	DASH,
	ATTACK_SLASH,
	ATTACK_COMBO
}


//Death
death = false;