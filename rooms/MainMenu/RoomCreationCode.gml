global.music_id = 1;

if (!audio_is_playing(global.music_id)) {
    global.music_id = audio_play_sound(bgmMainMenu, 1, true);
}