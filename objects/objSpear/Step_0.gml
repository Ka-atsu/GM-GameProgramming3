if (startEasing == true) {
	if ( time < duration) {
		move = ease_in(time, start, destination - start, duration);
		
		time++ 
		if (time >= duration) {
			ai = "retract"; 
			startEasing = false;
			audio_play_sound(sfxSpikeR, 20, false);
		}
	}
}
	
	if (ai == "prepare attack") {
		DelayAttack_timer--;
		if(DelayAttack_timer < 0) {
			DelayAttack_timer = DelayAttack_time;
			ai = "attack";
			audio_play_sound(sfxSpikeA, 20, false);
		}
	}
	
	if (ai == "attack") {
		startEasing = true;
	}
	
	if (ai == "retract") { 
		// adjust the time
		move += 0.6;
		if(y>start_Y) {
			y = start_Y;
			ai = "reset trap"; 
			move = 0;
		}
	}
	
	if (ai == "reset trap") {
		ReloadTrap_timer--;
		if(ReloadTrap_timer < 0) {
			ReloadTrap_timer = ReloadTrap_time;
			
			start = 0;
			destination = -90;
			duration = 10;
			time = 0;
			move = 0;
			
			ai = "idle";
		}
	}

y = start_Y + move;