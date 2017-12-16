/*
** @file: createcircle.pde
 ** @author Monica Preller
 ** @author Lisa Pothoven
 ** @date 13-12-2017
 ** @abstract Class definition for class 'CreateCircle'
 */

class MusicCircle {
  float strokeWeight;
  float xpos, ypos, diam;
  float colour;
  float freq;
  boolean draw=false;

  MusicCircle(float x, float y, float size, float strokeWeightInit, float colourInit, float freqInit,boolean draw) {
    xpos = x;
    ypos = y;
    diam = size;
    strokeWeight=strokeWeightInit;
    freq=freqInit;
    draw = true;
    colour=colourInit;
  }
  void display() {
    fill(255);
    ellipse(xpos, ypos, diam, diam);
  }
}