/*
** @file: createcircle.pde
** @author Monica Preller
** @author Lisa Pothoven
** @date 13-12-2017
** @abstract Class definition for class 'CreateCircle'
*/

class CreateCircle {
  float xpos, ypos, diam;
  float colour;

  CreateCircle(float x, float y, float size) {
    xpos = x;
    ypos = y;
    diam = size;
    draw = true;
  }
  void display() {
    fill(255);
    ellipse(xpos, ypos, diam, diam);
  }
}