audio_group_load(audiogroup_default);
audio_group_load(audiogroup1);

audio_group_set_gain(audiogroup1, 1, 0);

wind_volume = 0;
other_sound_loaded = false;

if (audio_group_is_loaded(audiogroup1)) {
	audio_play_sound(sWind, 999, true, 1, 10);
	audio_group_set_gain(audiogroup1, 0, 0);
}
