/*
** Introduction to Programming - final assignment
** @author Monica Preller
** @author Lisa Pothoven
** @date 11-1-2018
** @abstract definition of class CreateCircle.
*/

class CreateCircle {
  float xpos;
  float ypos;
  float mouseRx;
  float mouseRy;
  float diam;
  float ellipseSat;
  float ellipseBright;
  float freq;
  int   len = 100;
  int   counter = len;  
  boolean playing = false;
  boolean pulse = true;

  CreateCircle(float x, float y, float size) {
    xpos=x;
    ypos=y;
    diam=size;
    ellipseSat = 200;
    ellipseBright = 250;
  }

  void display() {
    colorMode(HSB, 255, 255, 255);
    noStroke();
    if (playing) {
      fill(255, 0  , 255);
      ellipse(xpos, ypos, 2.2 * diam, 2.2 * diam);
    }
    fill(backgroundHue, ellipseSat, ellipseBright);
    ellipse(xpos, ypos, 2*diam, 2*diam); 
  }
  
  void count() {
    if (counter > 0) {
      counter --;
    } else {
      counter = len;
    }
  }
}