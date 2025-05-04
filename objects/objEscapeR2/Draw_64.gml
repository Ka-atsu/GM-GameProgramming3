// Create event
if (!surface_exists(pauseSurf)) {
    instance_deactivate_all(true);
    pauseSurf = surface_create(room_width, room_height);
    surface_set_target(pauseSurf);
    draw_surface(application_surface, 0, 0);
    surface_reset_target();
    
    fadeAlpha = 0;  // Start fade alpha at 0 (invisible)
    fadeSpeed = 0.05;  // Speed of fade effect
} 

// Step event
if (pause == true) {
    // Increase fadeAlpha gradually to create fade-in effect
    fadeAlpha += fadeSpeed;
    fadeAlpha = clamp(fadeAlpha, 0.6, 0.9);  // Clamp fadeAlpha between 0 (invisible) and 1 (fully visible)
    
    // Draw the game surface (paused background)
    draw_surface(pauseSurf, 0, 0);
    
    // Draw the black semi-transparent overlay with fade effect
    draw_set_alpha(fadeAlpha);  // Apply fadeAlpha to the background
    draw_rectangle_color(0, 0, 5000, 5000, c_black, c_black, c_black, c_black, 0);  // Draw the overlay
    draw_set_alpha(1);  // Reset alpha to 1 (fully opaque) for text
    
    // Draw the pause menu text
    draw_set_font(GameFontSmall);
    draw_set_color(c_white);
    draw_text(450, 200, "Pause Menu");
    draw_text(400, 250, "Press ESC to Resume");
    draw_text(400, 300, "Press Q to Quit");
} 
else {
    // Fade-out effect when the game is unpaused
    fadeAlpha -= fadeSpeed;
    fadeAlpha = clamp(fadeAlpha, 0.9, 0);  // Ensure fadeAlpha stays between 0 and 1
    
    // If the pause screen has completely faded out, free the surface and reactivate objects
    if (fadeAlpha == 0) {
        instance_activate_all();
        surface_free(pauseSurf);
        pauseSurf = -1;
    }
    
    // Draw the game surface if fadeAlpha is greater than 0 (when not fully transparent)
    if (fadeAlpha > 0) {
        draw_surface(pauseSurf, 0, 0);
    }
}
