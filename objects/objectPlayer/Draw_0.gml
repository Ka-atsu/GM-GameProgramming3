// Step 1: Draw the black vignette (dark overlay) on the whole screen
draw_set_color(c_black);
draw_set_alpha(1); // Full opacity for the vignette (to cover everything)
draw_rectangle(0, 0, room_width, room_height, false); // Draw a black rectangle over the entire screen

// Step 2: Use transparency to create a cut-out for the player’s area
draw_set_alpha(0.1); // Set full transparency for the cut-out area
draw_set_color(c_white); // The cut-out is still black, but transparent (to hide it)

// Create a smooth circular mask around the player (the area around the player remains clear)
var vignette_radius = 50; // The radius of the clear area around the player
draw_circle(x, y, vignette_radius, false); // Draw a transparent circle to "erase" the vignette

// Step 3: Draw the player sprite on top (without the vignette)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * face, image_yscale, image_angle, image_blend, image_alpha);

// Step 4: Draw all objects that should be visible (such as walls, platforms, etc.) inside the vignette area
for (var i = 0; i < instance_number(objectSpike); i++) {
    var inst = instance_find(objectSpike, i);
    var dist_to_player = point_distance(inst.x, inst.y, x, y);
	if (dist_to_player <= vignette_radius) {
	    // Draw the object only if it's inside the vignette area
	    draw_sprite(inst.sprite_index, inst.image_index, inst.x, inst.y);
	}
}

