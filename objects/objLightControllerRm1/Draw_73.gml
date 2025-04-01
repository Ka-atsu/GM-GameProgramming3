part_system_drawit(global._part_system);
	var camera = view_get_camera(0);
if (!surface_exists(self.light_surface)) {
	camera = view_get_camera(0);
	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);

	self.light_surface = surface_create(cam_width,cam_height);
}

surface_set_target(self.light_surface);
draw_clear_alpha(c_black, 0.5)
camera_apply(camera);

gpu_set_blendmode(bm_subtract);

var targetScale = 2; // Adjust this value as necessary

// Example part of your Draw event:
if (global.state == 1) {
    with (objCheckPoint) {
        if (image_index == 1) {
            draw_sprite(sprLightSmall, 0, self.x, self.y);  
        }
    }
    with (objLightOrb) {
        draw_sprite(sprLightSmall, 0, self.x, self.y);  
    }
    with (objPlayer) {
        draw_sprite_ext(sprLight, 0, self.x, self.y - 25, global.state, global.state, 0, c_white, 1);
    }
} else if (global.state == 1.5) {
    with (objCheckPoint) {
        if (image_index == 1) {
            draw_sprite(sprLightSmall, 0, self.x, self.y);  
        }
    }
    with (objLightOrb) {
        draw_sprite(sprLightSmall, 0, self.x, self.y);  
    }
    with (objPlayer) {
        // Draw the sprite using the gradually updated currentScale
        draw_sprite_ext(sprLight, 0, self.x, self.y - 50, global.oneScale, global.oneScale, 0, c_white, 1);
    }
} else if (global.state == 2) {
    with (objCheckPoint) {
        if (image_index == 1) {
            draw_sprite(sprLightSmall, 0, self.x, self.y);  
        }
    }
    with (objLightOrb) {
        draw_sprite(sprLightSmall, 0, self.x, self.y);  
    }
    with (objPlayer) {
        // Draw the sprite using the gradually updated currentScale
        draw_sprite_ext(sprLight, 0, self.x, self.y - 25, global.onePointFiveScale, global.onePointFiveScale, 0, c_white, 1);
    }
}


gpu_set_blendmode(bm_normal);

surface_reset_target();