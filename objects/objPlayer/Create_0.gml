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

//control setup
controlsSetup();

//Health 
//Watch HeartBeast Game maker Health bar
maxHealth = 100;
playerHealth = maxHealth; 

//Sprites
maskSpr = sprPlayerIdle;
idleSpr = sprPlayerIdle;
walkSpr = sprPlayerWalk;
runSpr = sprPlayerRun;
jumpSpr = sprPlayerJump;
atkSpr = sprPlayerAttack;

//Moving
face = 1;
moveDir = 0;
runType = 0;
moveSpd[0] = 5;
moveSpd[1] = 7.5;
xspd = 0;
yspd = 0;

//Jumping
grav = .275;
termVel = 10;
onGround = true;
jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;

//Jump values for each successive jump
jumpHoldFrames[0] = 18;
jspd[0] = -7;
jumpHoldFrames[1] = 10;
jspd[1] = -6.15;

//Coyote Time
//Hang Time
coyoteHangFrames = 3;
coyoteHangTimer = 0;

//Jump buffer time
coyoteJumpFrames = 5;
coyoteJumpTimer = 0;

//Call the state
state = PLAYERSTATE.FREE;
//Things that had been hit by the player like a array
hitByAttack = ds_list_create();

//Enum is like a global variable
enum PLAYERSTATE
{
	FREE,
	ATTACK_SLASH,
	ATTACK_COMBO
}
