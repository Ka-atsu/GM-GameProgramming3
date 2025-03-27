application_surface_draw_enable(false);

var camera = view_get_camera(0);
var cam_width = camera_get_view_width(camera);
var cam_height = camera_get_view_height(camera);

light_surface = surface_create(cam_width,cam_height);

global.state = 1; // Make state global so it's accessible from anywhere

//Watch simple 2D lighting tutorial - from Dragonite spam

global.onePointFiveScale = 1.5; 
global.oneScale = 1;// Starting scale value
scalingActive = true;   // Flag to control whether scaling is active
