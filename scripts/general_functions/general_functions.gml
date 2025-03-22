function controlsSetup()
{
	bufferTime = 3;
	
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
}

function getControls() 
{
	// Directions Inputs
	rightKey = keyboard_check(ord("D"));  // Use 'D' key instead of right arrow
	leftKey = keyboard_check(ord("A"));   // Use 'A' key instead of left arrow
	
	//Action Inputs
	jumpKeyPressed = keyboard_check_pressed(vk_space);  // Keep spacebar for 
	jumpKey = keyboard_check(vk_space);  // Keep spacebar for jumping
	
	// Run Input
	runKey =  keyboard_check(vk_shift);
	
	// Mouse Left Clicked
	attackKey = mouse_check_button_pressed(mb_left);
	
	//Jump Key buffering 
	if jumpKeyPressed
	{
		jumpKeyBufferTimer = bufferTime;
	}
	
	if jumpKeyBufferTimer > 0
	{
		jumpKeyBuffered = 1;
		jumpKeyBufferTimer--;
	} else {
		jumpKeyBuffered = 0;
	}
};