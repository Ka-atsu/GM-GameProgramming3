function playerState_Attack_Slash() {

	//if moveDir != 0 { face = moveDir};
	// -1 left // 1 right
	
	xspd = 0;
	yspd = 0;
	
	//Start of Attack
	if (sprite_index != atkSpr) {
		sprite_index = atkSpr;
		image_index = 0;
		ds_list_clear(hitByAttack);
	}
	
	//Use attack hitbox & check for hits // cannot do it automatically
	//show_debug_message(face);
	//idk why but when i make them face same hb it just work
	//if(face != -1){ mask_index = hb; } else { mask_index = hb;}
	// in the draw event i removed * face maybe thats why
	// just set the mask index to the normal hb
	mask_index = hb;

	var hitByAttackNow = ds_list_create();
	// x and y is the position , object Enemy is the one who will get hit , hitByAttackNow where we will store
	var hits = instance_place_list(x , y , objEnemyTree, hitByAttackNow, false);
	var hits2 = instance_place_list(x , y , objEnemySkull, hitByAttackNow, false);
	// if we hit something can be many
	var totalHits = ds_list_size(hitByAttackNow);
	if(totalHits > 0) {
		for (var i = 0; i < totalHits; i++) {
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
	mask_index = idleSpr;
	
	if (animation_end())
	{
		sprite_index = idleSpr;
		state = PLAYERSTATE.FREE;
	}
}