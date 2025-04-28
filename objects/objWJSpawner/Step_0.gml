// In the object controlling the textbox creation:

// Declare a local variable to store the instance
if (place_meeting(x, y, objPlayer)) {
    if (!instance_exists(textbox_instance)) {
        textbox_instance = instance_create_layer(200, 30, "Text", objWallJumpText);
    }
} else {
    if (instance_exists(textbox_instance)) {
        instance_destroy(textbox_instance);
        textbox_instance = undefined;
    }
}
