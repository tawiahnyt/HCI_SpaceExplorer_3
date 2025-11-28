// Script: show_notification
// Creates a temporary notification message on the screen.

function show_notification(text, object_to_create) {
    // If a notification of this type already exists, destroy it first.
    if (instance_exists(object_to_create)) {
        instance_destroy(object_to_create);
    }
    
    // Create the new notification instance on the "Instances" layer.
    instance_create_layer(0, 0, "Instances", object_to_create, { message: text });
}
