// Step event
if (pause == true) {
    if (keyboard_check_pressed(ord("Q"))) {
		application_surface_draw_enable(true);
		gpu_set_blendmode(bm_normal);
		audio_stop_all();
        room_goto(MainMenu);
    }
}
