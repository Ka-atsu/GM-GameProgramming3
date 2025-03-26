with(objPlayer) {
	playerHealth = min(playerHealth + 12, 68);
}
audio_play_sound(sfxPickup, 20, false);
instance_destroy();