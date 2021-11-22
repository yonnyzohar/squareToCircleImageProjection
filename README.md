# squareToCircleImageProjection
code snippet on projecting a square image on to a circle
The last post about the solar system model led me to a little experiment in image projection. I wanted to see if i could take an image of a planet surface and project it onto a sphere. All i am using is a pixel canvas without any 3d rendering...
The idea was to draw a circle out of arcs that have their cos value multiplied by some percentage as you get closer to the center of the circle. This gives a nice "globe" effect and also provides yow with "rows" and "columns" to use as an anchor for interpolating the corresponding pixels from the square image.
I added an incrementing start column in an update loop for the rotation effect.


https://www.facebook.com/yonnyzohargamedev/videos/608207040227250/
