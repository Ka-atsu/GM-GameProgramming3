function playerState_Attack_Slash() {
	//Get my face
	if moveDir != 0 { face = moveDir};
	
	xspd = 0;
	yspd = 0;
	
	//Start of Attack
	if (sprite_index != sprPlayerAttack) {
		sprite_index = sprPlayerAttack;
		image_index = 0;
		ds_list_clear(hitByAttack);
	}
	
	//Use attack hitbox & check for hits
	mask_index = sprPlayerHB
	var hitByAttackNow = ds_list_create();
	// x and y is the position , onject Enemy is the one who will get hit , hitByAttackNow where we will store
	var hits = instance_place_list(x , y , objEnemy, hitByAttackNow, false);
	// if we hit something can be many
	if(hits > 0) {
		for (var i = 0; i < hits; i++) {
			//if this instance has not yet been hit by this attack 
			var hitID = hitByAttackNow [| i]; // same As ds_list_find_value(hitByAttackNow, i);
			if (ds_list_find_index(hitByAttack, hitID) == -1) {
				ds_list_add(hitByAttack, hitID);
				with (hitID)
				{
					EnemyHit(true);
				}
			}
		}
	}
	ds_list_destroy(hitByAttackNow);
	mask_index = sprPlayerIdle;
	
	if (animation_end())
	{
		sprite_index = sprPlayerIdle;
		state = PLAYERSTATE.FREE;
	}
}