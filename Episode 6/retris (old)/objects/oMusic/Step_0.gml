//play target song
if (song_asset != target_song_asset) {
	//tell old song to fade out
	if (audio_is_playing(song_instance)) {
		//add song ionstance to array
		array_push(fade_out_instances, song_instance);
		//add song instance startign olunme
		array_push(fade_out_instance_vol, fade_in_instance_vol);
		//add fade out instances fade out time
		array_push(fade_out_instance_time, fade_out_time);
		
		//reset song instance and stuff
		song_instance = noone;
		song_asset = noone;
	}
	
	
	//play song if old song has faded out
	if (len(fade_out_instances) == 0) {
		
		if (audio_exists(target_song_asset)) {
			//play song, store instance
			song_instance = audio_play_sound(target_song_asset, 100, true);
			//start volume
			audio_sound_gain(song_instance, 0, 0); //immediately 0 volume
			fade_in_instance_vol = 0;
		}
	
		//set song asset to target song asset
		song_asset = target_song_asset;
	}
}




//volume control================================================

//main song volume
if (audio_is_playing(song_instance)) {
	//fade song in
	if (fade_in_time > 0) {
		if (fade_in_instance_vol < 1) {
			fade_in_instance_vol += 1/fade_in_time; //appropriate fade in speed
		} else {
			fade_in_instance_vol = 1; //haha just in case
		}
	//immediayely start if 0 frames
	} else {
		fade_in_instance_vol = 1;
	}
	
	//actually set gain
	audio_sound_gain(song_instance, fade_in_instance_vol*volume, 0); //0 means per step
}


//fading songs out
for (var i = 0; i < len(fade_out_instances); i++) {
	//fade the volume
	if (fade_out_instance_time[i] > 0) {
		if (fade_out_instance_vol[i] > 0) {
			fade_out_instance_vol[i] -= 1/fade_out_instance_time[i];
		}
	} else {
		fade_out_instance_vol[i] = 0;
	}
	
	//automatically set gain
	audio_sound_gain(fade_out_instances[i], fade_out_instance_vol[i]*volume, 0);
	//stop song when silent
	if (fade_out_instance_vol[i] <= 0) {
		//stop song
		if (audio_is_playing(fade_out_instances[i])) {
			audio_stop_sound(fade_out_instances[i]);
		}
		//remove from array
		array_delete(fade_out_instances, i, 1);
		array_delete(fade_out_instance_vol, i, 1);
		array_delete(fade_out_instance_time, i, 1);
		//set loop back 1 as i just deleted
		i--;
	}
}
























