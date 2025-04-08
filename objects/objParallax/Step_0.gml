//Exit if theres no player
if !instance_exists(objPlayer) exit;

//Get camera size
var _camWidth = camera_get_view_width(view_camera[0]);

//Get camera target coordinates
var _camX = objPlayer.x - _camWidth/2;

//constrain cam to room borders
_camX = clamp(_camX, 0, room_width - _camWidth);

//Set cam coordinate variables
finalCamX += (_camX - finalCamX) * camTrailSpd;

layer_x("Background" , finalCamX);