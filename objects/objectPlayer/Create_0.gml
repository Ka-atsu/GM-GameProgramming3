

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
playerHealth = 100; 

//Sprites
maskSpr = sPlayerIdle;
idleSpr = sPlayerIdle;
walkSpr = sPlayerWalk;
runSpr = sPlayerRun;
jumpSpr = sPlayerJump;
atkSpr = sPlayerAttack;

//Moving
face = 1;
moveDir = 0;
runType = 0;
moveSpd[0] = 6
moveSpd[1] = 20
xspd = 0;
yspd = 0;

//Jumping
grav = 70;
termVel = 10;
onGround = true;
jumpMax = 2;
jumpCount = 0;
jumpHoldTimer = 0;

//Jump values for each successive jump
jumpHoldFrames[0] = 10;
jspd[0] = -19;
jumpHoldFrames[1] = 5;
jspd[1] = -10.5;

//Coyote Time
//Hang Time
coyoteHangFrames = 3;
coyoteHangTimer = 0;

//Jump buffer time
coyoteJumpFrames = 5;
coyoteJumpTimer = 0;

state = PLAYERSTATE.FREE;
hitByAttack = ds_list_create();

//Enum is like a global variable
enum PLAYERSTATE
{
	FREE,
	JUMPING
}
