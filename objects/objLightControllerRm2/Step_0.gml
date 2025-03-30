// Default scale is 1 so i have 3 states first the game start the s
if (scalingActive) {
    if (global.state == 1.5) {
        // Handle scaling for global.scale == 1.5 using global.oneScale
        if (global.oneScale < 1.5) {
            global.oneScale += 0.05;  // Gradually increase
			show_debug_message(global.oneScale);
        } else {
            global.oneScale = 1.5; 
            global.onePointFiveScale = 1.5; // Put the other to the same scale
        }
    }
    else if (global.state == 2) {
        // Handle scaling for global.scale == 2 using global.onePointFiveScale
        if (global.onePointFiveScale > 1) {
            global.onePointFiveScale -= 0.05;  // Gradually decrease
            show_debug_message(global.onePointFiveScale);
        } else {
            global.onePointFiveScale = 1;    
            global.oneScale = 1;  // Put the other to the same scale
        }
    }
}
