function playerState_Dash(){
	
	if (dashActive) {
		 xspd = lerp(xspd, targetXspd, 0.2);
		 //show_debug_message(targetXspd);
		  x += xspd;
		
		  
		with(instance_create_depth(x, y, depth + 1, objDashEffect)) {
			sprite_index = other.dashEffectSpr;
			image_xscale = other.face;
			image_alpha = c_fuchsia;
			image_alpha = 0.75;
		}
		 
		 show_debug_message(abs(x - dashStart));
		 if (abs(x - dashStart) >= 300 || place_meeting(x + xspd, y, objGround)) {
	        dashActive = false;
			state = PLAYERSTATE.FREE;
	    }
	}
}