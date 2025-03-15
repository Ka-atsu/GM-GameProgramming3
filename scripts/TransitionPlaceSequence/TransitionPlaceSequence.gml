global.midTransition = false;
global.roomTarget = -1;

// places the sequence in the room
function TransitionPlaceSequence(_type){
    if(layer_exists("transition")) layer_destroy("transition");
    var _lay = layer_create(-9999, "transition");
    layer_sequence_create(_lay, 0, 0, _type);
}

// Called whenever you want to go from one room to another, using any combination of in/out sequences
function TransitionStart(_roomTarget, _typeOut, _typeIn){
    if(!global.midTransition){
        global.midTransition = true;
        global.roomTarget = _roomTarget;
        TransitionPlaceSequence(_typeOut);  // Start the out transition
        // After out transition finishes, change the room
        alarm[0] = 1;  // Set an alarm to change the room after the transition finishes
        TransitionPlaceSequence(_typeIn);   // Start the in transition
        return true;
    }
    else return false;
}

// Called as a moment at the end of an "Out" transition sequence
function TransitionChangeRoom(){
    room_goto(global.roomTarget);  // This is where the room change happens
}

// Called as a moment at the end of an "In" transition sequence
function TransitionFinished(){
    layer_sequence_destroy(self.elementID);  // Clean up the transition layer
    global.midTransition = false;  // Allow new transitions
}

// Alarm[0] triggers when the fade-out is finished
alarm[0] = function(){
    // Change the room after the fade-out
    TransitionChangeRoom();
    alarm[0] = -1;  // Disable the alarm after the room change
};
