/*
** Introduction to Programming - final assignment
 ** @author Monica Preller
 ** @author Lisa Pothoven
 ** @date 7-1-2018
 ** @abstract This is the main file of our application called 'Cirquence'.
 */

import processing.sound.*;
TriOsc[] osc;

/* First things first, let's create the global variables that we are going to need: */
MusicCircle[] musiccircle; // An array for storing our MusicCircles
int cirCount; // A counter to keep track of the number of circles activated by the user
int cirMax = 8;
int diamMax = 500; // Maximum circle diameter
boolean drag = false;
int dragMe = 0;
int[] vlines, hlines;
int n = 8;

void setup() {
  //fullScreen(); // Run the code at the full dimensions of the current screen
  size(512, 512);
  musiccircle = new MusicCircle[cirMax];
  osc = new TriOsc[cirMax];
  cirCount = 0; // Set cirCount to zero
  grid();
}

void mousePressed() {
  for (int i = 0; i<cirMax; i++) {
    if (musiccircle[i] != null && musiccircle[i].active) {
      float A = pow(musiccircle[i].xpos - float(mouseX), 2f);
      float B = pow(musiccircle[i].ypos - float(mouseY), 2f);
      if (sqrt(A+B) <= musiccircle[i].diam) {
        drag = true; 
        dragMe = i;
        return;
      }
    }
  }
  
  // if number of circle exeeds cirCount
  if (cirCount < cirMax) {    
    // TODO: don't create circles on top of each other
    musiccircle[cirCount] = new MusicCircle(mouseX, mouseY, 5, color(255, 255, 255));
    musiccircle[cirCount].activate();
    
    // Create new sound oscillator
    osc[cirCount] = new TriOsc(this);
    osc[cirCount].freq(musiccircle[cirCount].freq);
    osc[cirCount].play();
    musiccircle[cirCount].playing = true;
    
    cirCount++;    
  } else {
    cirCount = 0;
  }
}

void mouseDragged() {
  int cur = cirCount - 1;
  if (cirCount > 0 && drag) {
    if (mouseButton == LEFT) {
      musiccircle[dragMe].xpos = mouseX;
      musiccircle[dragMe].ypos = mouseY;
    } else if (mouseButton == RIGHT) {
      float A = pow(musiccircle[dragMe].xpos - float(mouseX), 2f);
      float B = pow(musiccircle[dragMe].ypos - float(mouseY), 2f);
      musiccircle[dragMe].diam = constrain(sqrt(A + B), 5, diamMax);
    }
    musiccircle[dragMe].reset();
  }
  else if (cirCount > 0) {    
    float A = pow(musiccircle[cur].xpos - float(mouseX), 2f);
    float B = pow(musiccircle[cur].ypos - float(mouseY), 2f);
    
    musiccircle[cur].diam = constrain(sqrt(A + B), 5, diamMax);
  }
}

void draw() {
  background(0);
  if (!mousePressed) {
    drag = false;
  }
  for (int i = 0; i < cirMax; i++) {
    if (musiccircle[i] != null && musiccircle[i].active) {
      musiccircle[i].count();
      musiccircle[i].display();
      
      // snap to grid
      for (int x = 0; x < n; x++) {
        if ( abs(musiccircle[i].ypos - hlines[x]) <= width/(2*n) ) {
          musiccircle[i].ypos = hlines[x];          
        }
        if ( abs(musiccircle[i].xpos - vlines[x]) <= height/(2*n)) {
          musiccircle[i].xpos = vlines[x];
        }
      }  
      // draw the lines on the screen
      stroke(255);
      line(musiccircle[i].xpos, 0, musiccircle[i].xpos, height);
      line(0, musiccircle[i].ypos, width, musiccircle[i].ypos);
      
      // set the frequency and the amplitude of the oscillator
      osc[i].freq(musiccircle[i].freq);
      osc[i].amp(musiccircle[i].diam / diamMax);
      
      // play in beeps instead of continuously
      if (musiccircle[i].pulse && musiccircle[i].counter == 0) { 
        // if we want to play pulses (beeps), do ...
        if (musiccircle[i].playing) {
          osc[i].stop();
          musiccircle[i].playing = false;
        } else {
          osc[i].play();
          musiccircle[i].playing = true;
        }
      }
    }
  }
}

/* void grid()
** creates a grid to snap the musiccircles to */
void grid() {
  hlines = new int[n];
  for (int x = 1; x <= n; x++) {
    hlines[x-1] = x * height/n;  
  }
  n = 8;
  vlines = new int[n];
  for (int y = 1; y <= n; y++) {
    vlines[y-1] = y * width/n;  
  }
}