draw_set_font(FontHeader);

draw_text(x, y+30, "Movement");

draw_set_font(FontBody);

draw_text(x+10, y+80, "Press A to move left");
draw_text(x+10, y+100, "Press D to move right");
draw_text(x+10, y+120, "Press Space to jump, Double tap to double jump");
draw_text(x+10, y+140, "Press Left Click to Attack");

draw_set_font(FontHeader);

draw_text(x, y+180, "Goal");

draw_set_font(FontBody);

draw_text(x+10, y+230, "Reach the Top and find the Hidden Exit");

draw_set_font(FontHeader);

draw_text(x, y+270, "Misc");

draw_set_font(FontBody);

draw_text(x+10, y+320, "Light Orb: Collect to make the light bigger");
draw_text(x+10, y + 340, "Health Orb: Collect to restore health");
draw_text(x+10, y + 360, "Checkpoint: locations where the player respawns after death.");