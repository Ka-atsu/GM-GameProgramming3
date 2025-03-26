// delete the save file because its irrelevant to level 2
if (file_exists("checkpoint.ini")) {
	file_delete("checkpoint.ini");
}
	// stop all sounds
	audio_stop_all();
	fadeToRoom(Level2, 60, c_black);
	audio_play_sound(bgmRoom2, 4, true);
