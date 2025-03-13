if (file_exists("checkpoint.ini"))
{
	ini_open("checkpoint.ini");
	
	// if the value doesnt exist then the same will be loaded as a default
	x = ini_read_real("player", "x", x);
	y = ini_read_real("player", "y", y);
	playerHealth = ini_read_real("player", "hp", playerHealth);
	
	ini_close();
}