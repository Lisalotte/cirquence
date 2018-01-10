class CreateCircle {
  float xpos;
  float ypos;
  float mouseRx;
  float mouseRy;
  float diam;
  float ellipseSat;
  float ellipseBright;
  float freq;
  int   len = 50;
  int   counter = len;
  
  boolean playing = false;
  boolean pulse = true;

  CreateCircle(float x, float y, float size) {
    xpos=x;
    ypos=y;
    diam=size;
    draw = true;
    ellipseSat = 200;
    ellipseBright=250;
    //len    = int( map(x, 0, width, 0, 50) );
  }

  void display() {
    colorMode(HSB,255);
    noStroke();
    fill(backgroundHue, ellipseSat, ellipseBright);
    ellipse(xpos, ypos, 2*diam, 2*diam);
  }
  
  void count() {
    if (counter > 0) {
      counter --;
    }// else {
     // counter = len;
    //}
  }
}