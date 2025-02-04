if (audio_group_is_loaded(audiogroup1)) {
	audio_play_sound(sWind, 999, true, 1, 10);
	audio_group_set_gain(audiogroup1, 0, 0);
}

if (audio_group_is_loaded(audiogroup_default)) {
	other_sound_loaded = true;
}