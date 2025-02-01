//Fullscreen toogle
if keyboard_check_pressed(vk_f8)
{
	window_set_fullscreen( !window_get_fullscreen() );
}

//Exit if theres no player
if !instance_exists(objectPlayer) exit;

//Get camera size
var _camWidth = camera_get_view_width(view_camera[0]);
var _camHeight = camera_get_view_height(view_camera[0]);

//Get camera target coordinates
var _camX = objectPlayer.x - _camWidth/2;
var _camY = objectPlayer.y - _camHeight/2;

//constrain cam to room borders
_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

//Set cam coordinate variables
finalCamX += (_camX - finalCamX) * camTrailSpd;
finalCamY += (_camY - finalCamY) * camTrailSpd;

//set camera coordinates
camera_set_view_pos(view_camera[0], _camX, _camY);