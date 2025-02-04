volume = 0; //permamnent setting
volume2 = 1; //changed temporarily

//what is playing / trying to play
song_instance = noone; //instance
song_asset = noone; //which song instance should be created
target_song_asset = noone; //compare current and to (affirms what should be swapped to)

fade_out_time = 0; //hopw many frames to fade out'
fade_in_time = 0; //how many frames fade in
fade_in_instance_vol = 1; //volume of song instance

//for fading music out (and in?)
fade_out_instances = []; //audio instances to fade out (array_creae?)
fade_out_instance_vol = []; //volume of all
fade_out_instance_time = []; //how fast the fade out should be


function music(song, fade_out_current_song=0, fade_in=0) {
	target_song_asset = song;
	fade_out_time = fade_out_current_song;
	fade_in_time = fade_in;
}