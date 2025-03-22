// Before calling room_goto(MainMenu)
// reset the application surface
application_surface_draw_enable(true);
gpu_set_blendmode(bm_normal);

audio_stop_all();  // Stop all sounds

room_goto(MainMenu);