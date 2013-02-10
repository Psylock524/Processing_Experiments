/**
  Changes background color according to framerate.
  WARNING: May cause seizures.
  
  Controls:
  Escape - Exit application
  Up Arrow - Increase Framerate
  Down Arrow - Decrease Framerate
  Spacebar - Pause
*/

boolean paused = false;
int textSize = 32;
float startingFrameRate = frameRate = 6;

void setup() {
  size(displayWidth, displayHeight);
  frameRate(startingFrameRate);
  
  textSize(textSize);
  stroke(10);
}

void draw() {
  if(frameRate < 1.0) { frameRate(++frameRate); }
  
  background(random(255), random(255), random(255));
  String textFrameRate = (frameRate % 1 > 0.5) ? str(int(frameRate)+1) : str(int(frameRate));
  text("Frames per second: " + textFrameRate, 10, textSize);
}

void keyPressed() {
  switch(key) {
    case ESC:
      exit(); break;
    case ' ':
      if(!paused) { noLoop(); paused = true; }
      else if (paused) { loop(); paused = false; }
    break;
    default:
      if(key == CODED) {
        switch(keyCode) {
          case UP:
            frameRate(++frameRate);
            break;
          case DOWN:
            if(frameRate > 1.0) { frameRate(--frameRate); }
            if(frameRate <= 2.0) { frameRate(1); }
          default:
            break;
        }
      }
      break;
  }
}

boolean sketchFullScreen() {
  return true;
}
