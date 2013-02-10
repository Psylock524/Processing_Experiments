/**
  Changes background color according to framerate.
  WARNING: May cause seizures.
  
  Controls:
  Escape - Exit application
  Up Arrow - Increase Framerate
  Down Arrow - Decrease Framerate
  Spacebar - Pause
*/

float startingFrameRate = frameRate = 2; // Starting frameRate set to 2 FPS
float pausedFrameRate;
boolean paused = false; // Application does not start paused

boolean sketchFullScreen() {
  return true; // Window starts in fullScreen mode (note: fullScreen mode does not change render size, it must still be set separately)
}

void setup() {
  size(displayWidth, displayHeight); // Fit render window to screen size
  
  if(frameRate >= 1.0) frameRate(startingFrameRate); // If starting frameRate is more than 1, use defined starting frameRate
  else frameRate(++frameRate); // If frame rate is less than 1, increase by 1 FPS - this prevents the application from being set to 0 FPS and freezing
  
  textSize(72); // set text size to 72
  textAlign(CENTER); // center all text
}

void draw() {
  if (frameRate < 0) frameRate(1);// If frame rate is less than 1, set to 1 FPS - this prevents the application from being set to 0 FPS and freezing
  else frameRate(round(frameRate)); // Otherwise, try to make the fps as accurate as possible
  
  background(random(255), random(255), random(255)); // Make a random RGB background color
  
  String textFrameRate = str(round(frameRate)); // Round the frameRate, convert to text for display
  fill(0); // Fill color (in this case, text) set to black
  text("Frames per second: " + textFrameRate, width/2, (height/2) - 3); // Draw black text with rounded frameRate speed, slightly above center line
  text("Frames per second: " + textFrameRate, width/2, (height/2) + 3); // Draw another, but lower down
  fill(255); // Fill color set to white
  text("Frames per second: " + textFrameRate, width/2, height/2); // Draw white text on top of black text, partially above (pixels start at top-left corner of window at 0,0 - negative coordinates means off-screen)
}

void keyPressed() { // If key is pressed...
  switch(key) { // Check which key it is...
    case ESC: // If it's the Escape key...
      exit(); // Quit program
      break; // End Escape case (Note: Will never be reached by the program, is there to keep the compiler happy)
    case ' ': // If it's the Spacebar...
      // Toggle  - program stops drawing, but frameRate cap is not normally affected (this is why "paused" programs still consume processing power; they're still processing, just waiting for input)
      if(!paused) { // If not paused, we should pause
        pausedFrameRate = frameRate; // Save frameRate when paused (this would save memory)
        noLoop(); // Stop drawing
        frameRate(16); // Sets frameRate to 16, which would save memory on a 60 FPS game
        paused = true; // Flag paused boolean variable
      }
      else if (paused) { // If paused, we should unpause
        frameRate(pausedFrameRate); // Reset frameRate 
        loop(); // Start drawing again
        paused = false; // Reset flagged pause variable
      }
    break; // End Spacebar case
    default: // Otherwise
      if(key == CODED) { // If pressed key is a special key...
        switch(keyCode) { // Check which key...
          case UP: // If key is Up Arrow...
            frameRate(++frameRate); // Increase FPS by 1
            break; // End Up Arrow case
          case DOWN: // If key is Down Arrow...
            if(frameRate > 1.0) { frameRate(--frameRate); } // If frameRate is greater than 1, decrease by 1
            if(frameRate < 1.0) { frameRate(1); } // If frameRate is less than 2, sit it to 1
          default: // Otherwise
            break; // End down arrow case
        }
      }
      break; // End default case
  }
}
