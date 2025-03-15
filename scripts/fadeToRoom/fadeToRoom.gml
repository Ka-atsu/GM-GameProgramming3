// Next room script
function fadeToRoom(_room, _dur, _color){
	_room = argument[0];
	_dur = argument[1];
	_color = argument[2];
	
	var _inst = instance_create_depth(0, 0,0, objFade);
	
	with(_inst) {
		targetRoom = _room;
		duration = _dur;
		color = _color;
	}
}

// room restart script
function fadeToRoomRestart(_dur, _color){
	_dur = argument[0];
	_color = argument[1];
	
	var _inst = instance_create_depth(0, 0,0, objFadeDeath);
	
	with(_inst) {
		duration = _dur;
		color = _color;
	}
}