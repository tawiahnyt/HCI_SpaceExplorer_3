// --- Create Event for obj_notification ---

// The message that will be displayed. We'll set this when we create the object.
message = "Mission Complete!"; 

// How long the notification will stay on screen (in seconds)
var display_duration_seconds = 4;
alarm[0] = room_speed * display_duration_seconds; // Set an alarm to destroy the object

// Variables for a simple fade-in and fade-out effect
alpha = 0;
fade_in_time = 0.5 * room_speed; // 0.5 seconds to fade in
fade_out_time = 0.5 * room_speed; // 0.5 seconds to fade out
