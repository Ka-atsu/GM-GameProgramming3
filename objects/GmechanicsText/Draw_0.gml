draw_set_font(FontHeader);

draw_text(x, y, "Game Mechanics");

draw_text(x, y+30, "Movement");

draw_set_font(FontBody);

draw_text(x+10, y+80, "Press A to move left");
draw_text(x+10, y+100, "Press B to move right");
draw_text(x+10, y+120, "Press Space to jump, Double tap to double jump");
draw_text(x+10, y+140, "Press Left Click to Attack");

draw_set_font(FontHeader);

draw_text(x, y+180, "Goal");

draw_set_font(FontBody);

draw_text(x+10, y+230, "Find the end it is at the very top");

draw_set_font(FontHeader);

draw_text(x, y+270, "Mechanics");

draw_set_font(FontBody);

draw_text(x+10, y+320, "Get the light orb to light up the game");