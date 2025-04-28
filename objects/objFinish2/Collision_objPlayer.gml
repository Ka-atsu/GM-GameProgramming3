// delete the save file because its irrelevant to level 2
if (file_exists("checkpoint.ini")) {
	file_delete("checkpoint.ini");
}

// Reset the application surface
application_surface_draw_enable(true);
gpu_set_blendmode(bm_normal);

// stop all sounds
audio_stop_all();
fadeToRoom(GameCredits, 60, c_black);
audio_play_sound(bgmCredits, 4 , true);

	
