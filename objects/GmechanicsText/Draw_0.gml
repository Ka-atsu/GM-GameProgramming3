draw_set_font(FontHeader);

draw_text(x, y+30, "Controls");

draw_set_font(FontBody);

draw_text(x+10, y+80, "Press A to move left");
draw_text(x+350, y+80, "Press ESC to pause");
draw_text(x+10, y+100, "Press D to move right");
draw_text(x+10, y+120, "Hold S to Run");
draw_text(x+10, y+140, "Press Space to jump, Double tap to double jump");
draw_text(x+10, y+160, "Press Shift to Dash");
draw_text(x+10, y+180, "Press Left Click to Attack");


draw_set_font(FontHeader);

draw_text(x, y+220, "Goal");

draw_set_font(FontBody);

draw_text(x+10, y+270, "Reach the Top and find the Hidden Exit");

draw_set_font(FontHeader);

draw_text(x, y+310, "Other things");

draw_set_font(FontBody);

draw_text(x+10, y+350, "Light Orb: Collect to make the light bigger");
draw_text(x+10, y + 370, "Health Orb: Collect to restore health");
draw_text(x+10, y + 390, "Checkpoint: locations where the player respawns after death.");