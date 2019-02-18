# VWorld
A proof of concept augment reality app for iOS.  It uses GPS, compass and accelerometer data to localize the device in space and render 3D objects on screen which appear to be hovering in air.

This proof of concept application was inspired by my son.  At the time he, like many other children his age, loved playing video games.   Remembering how playing video games a child myself, didn't help me engage socially, get excericise or do anything product (unless you count eating many Lil Debby Snack Cakes, Swedish Fish, and Hostess Vanilla Pudding Pies productive), I thought it would be really great if there were a video game that would be fun to play, but would also get kids out of the house, interacting with others their age.  

I came up with the VWorld concept.  A video game allowing players to hunt for virtual objects using clues along the way.  The system would use OpenGL ES to render 3D objects in a view overlaid on top of a view of a live video feed from the phone's camera.  The player would use their phone like a window into a virtual world, to see and interact with 3D objects and characters.  

At the time, Google Glass hadn't been released, nor Oculus Rift, Meta 2 Spaceglasses nor any other prolific AR or AG device.  After shelving this project for a few years, and seeing how popular Pokemon Go has been, it made me think I might have been on to something!  

I'm adding it here with the hope maybe someone will pick it up and at least learn something to help them make the next killer app.  Or perhaps pick it up and run with it, please contact me if you do, I'll help!!  :-)

In it's current state, it renders 3D objects on the screen, fully integrated with the video stream from the camera.  Objects are inserted into a 3 dimensional coordinate system using GPS coordinates, in the same format the Google's Map API provides.

![3D objects rotating in a Geographic Coordinate System](https://github.com/mellertson/VWorld/blob/master/assets/3-screens-3d-shapes-rotating.jpg)

**One key technical challenge remains:** finding a way to calculate the device's localized, and precise, GPS coordinates and altitude above ground level (AGL).  I've investigated using a few different localization methods, including fltering noisy GPS and telemetry data, visual SLAM and SLAM based on GPS and Wi-Fi data.  The filtering methods I implemented didn't seem to eliminate the noise sufficiently.  

It's my understanding SLAM has now been implemented by several companies, one was purchased by Apple and integrated into iOS.  It should now be a fairly trivial matter to get a precise localized vector without introducing the noise when accessing GPS and telemetry devices directly.  

This application was developed using XCode on Mac OS X.  And you'll need an Apple phone or iPad to test it in field.  

Best regards,

Mike
