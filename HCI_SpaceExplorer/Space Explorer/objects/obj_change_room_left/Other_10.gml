///@description Interact - change room left

// Check if a prev room exists before attempting to go to it
    if (room_exists(room_previous(room)) and room_previous(room) != rm_profile)
    {
        room_goto_previous();
    }
    else
    {
        // Handle the case where there is no prev room (go back to the first room)
        room_goto(rm_earth_home); 
    }