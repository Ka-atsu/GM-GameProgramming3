// check if the sprCheckPoint image is the second one in the frame
// if its the second one it means its activated so just do nothing
if (image_index == 1 ) {
	exit;
}

if (global.sound_played == 0) {
    audio_play_sound(sfxSpawnPoint, 20, false); // Play the sound
}

// else activate it 
image_index = 1;
image_speed = 0;


//create a file where the value will be saved
ini_open("checkpoint.ini");

//save all you want for now just the position of player and its health
ini_write_real("player", "x", other.x -150);
ini_write_real("player", "y", other.y);
ini_write_real("player", "hp", other.playerHealth);
ini_write_real("checkpiont", "cp", self.image_index);

show_debug_message(self.image_index);

ini_close();