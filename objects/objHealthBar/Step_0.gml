drawHealth = lerp(drawHealth, objPlayer.playerHealth, .25);

// Calculate the health bar width based on the player's health
healthBarWidth = 131 * (drawHealth / objPlayer.maxHealth);

// Clamp the width to ensure it's between 0 and 131
healthBarWidth = clamp(healthBarWidth, 0, 131);