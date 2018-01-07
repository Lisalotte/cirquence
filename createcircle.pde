/*
** @file: createcircle.pde
 ** @author Monica Preller
 ** @author Lisa Pothoven
 ** @date 5-1-2018
 ** @abstract Class definition for class 'CreateCircle'
*/

class MusicCircle {

  /* variables */
  float   xpos, ypos, diam, freq;
  int     len;
  int     counter = 0;
  color   colour;
  boolean active = false;
  boolean playing = false;
  boolean pulse = true;
  
  /* functions */

  /* constructor */
  MusicCircle(float x, float y, float size, color colourIn) {
    xpos   = x;
    ypos   = y;
    diam   = size;
    freq   = map((1 - y / height), 0, 1, 0, 1000);
    len    = int( map(x, 0, width, 0, 50) );
    colour = colourIn;
  }

  /* void display()
   ** this function will be called when the circle has to be drawn on the screen */
  void display() {
    fill(colour);
    ellipse(xpos, ypos, diam, diam);
  }
  
  void reset() {
    freq = map((1 - ypos / height), 0, 1, 0, 1000);
    len  = int( map(xpos, 0, width, 0, 50) );
    if (width - xpos <= 50) {
      pulse = false;
    } else {
      pulse = true;
    }
  }
  
  void count() {
    if (counter > 0) {
      counter --;
    } else {
      counter = len;
    }
  }
  /* void activate() 
  ** activate circle */
  void activate() {
    // set active to true
    active = true;
  }
  
  /* void deactivate()
  ** deactivate circle */
  void deactivate() {
    // set active to false
    active = false;
  }

  /* Now we are going to define a child class called ChildCircle.
   ** This circle will create a complementary sound to its parent, 
   ** and influence the 'colour' of the sound. */
  class ChildCircle {
    // Offset - distance from MusicCircle (parent)
    // Radius - size will determine volume
    // Frequency - has to be a fixed multiplier of the parent's frequency

    // ChildCircle()

    // void activate()
  }
}