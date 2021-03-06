/*
** Introduction to Programming - final assignment
 ** @author Monica Preller
 ** @author Lisa Pothoven
 ** @date 11-1-2018
 ** @abstract This is the main file of our application called 'Cirquence'.
 */

import processing.sound.*;

boolean circleDrag     = true;
boolean circleClick    = false; 
boolean drag           = false;
boolean circleCreation = false;
boolean play           = false;
int     dragMe         = 0;
int     clickMe        = -1;
float   playX          = 20;
float   playY          = 30;
float   playR          = 20;
float   restartX       = 0;
float   restartY       = 30;
float   restartR       = 30;
float   backgroundHue  = random(360);
int     diamMax        = 500;
int     circlecount    = 0;
int     circlemax      = 7;
int     order          = 1;
int     playCounter    = 0;

TriOsc[] osc;
CreateCircle[] musicCircles;
int[]  oscOrd;
float[] groundTones = {440, 495, 264, 297, 330, 352, 396}; // A B C D E F G
float[] scale;

void setup() {
  fullScreen();   
  colorMode(HSB, 255);

  restartX = width - 30;

  musicCircles = new CreateCircle [circlemax];
  osc = new TriOsc[circlemax];
  oscOrd = new int[circlemax];
  scale = new float[circlemax]; //triad
}

void mouseClicked() {
  if (circlecount == circlemax) { // true if all circles have been drawn
    for (int i = 0; i<circlemax; i++) {
      if (musicCircles[i] != null) {
        // check if mouse is on circle i
        float A = pow(musicCircles[i].xpos - float(mouseX), 2f);
        float B = pow(musicCircles[i].ypos - float(mouseY), 2f);
        if (sqrt(A+B) <= musicCircles[i].diam) {
          circleClick = true; 
          clickMe = i;
          return;
        }
      }
    }
  }
}

void mousePressed() {
  for (int i = 0; i<circlemax; i++) {
    if (musicCircles[i] != null) {
      float A = pow(musicCircles[i].xpos - float(mouseX), 2f);
      float B = pow(musicCircles[i].ypos - float(mouseY), 2f);
      if (sqrt(A+B) <= musicCircles[i].diam) {
        circleDrag = true; 
        dragMe = i;
        return;
      }
    }
  }
  if ( (mouseX < playX + playR) && (mouseY < playY + playR) ) {
    println("play");
    play = true;
    return;
  } else if ( (mouseX > restartX - restartR) && (mouseY < restartY + restartR) ) {
    println("restart");
    reset();
    return;
  }
  if (circlecount < circlemax) {
    musicCircles[circlecount]=new CreateCircle(mouseX, mouseY, 10);
    musicCircles[circlecount].ellipseSat-=(circlecount*15);
    musicCircles[circlecount].ellipseBright+=(circlecount*5);

    // Create new sound oscillator
    osc[circlecount] = new TriOsc(this);
    if (circlecount == 0) {
      int rand = (int)random(groundTones.length);
      osc[circlecount].freq(groundTones[rand]);
      createScale(groundTones[rand]);
    } else {
      int rand = (int)random(scale.length);
      musicCircles[circlecount].freq = scale[rand];
      osc[circlecount].freq(scale[rand]);
    }
    osc[circlecount].play();
    musicCircles[circlecount].playing = true;

    circleCreation = true;

    circlecount++;
  }
}

void mouseDragged() {
  if (circlecount > 0 && circleDrag) {
    //float superR=dist(musicCircles[circlecount-1].xpos, musicCircles[circlecount-1].ypos, mouseX, mouseY);
    //musicCircles[circlecount-1].diam=constrain(2*superR, 0, diamMax);
    float A = pow(musicCircles[dragMe].xpos - float(mouseX), 2f);
    float B = pow(musicCircles[dragMe].ypos - float(mouseY), 2f);
    musicCircles[dragMe].diam = constrain(sqrt(A + B), 5, diamMax);
  } else if (circlecount > 0 && circleCreation) {
    int cur = circlecount - 1;

    float A = pow(musicCircles[cur].xpos - float(mouseX), 2f);
    float B = pow(musicCircles[cur].ypos - float(mouseY), 2f);
    musicCircles[cur].diam = constrain(sqrt(A + B), 5, diamMax);
  }
}

void createScale(float groundFreq) {
  float a = pow(2f, 1f/12f);
  int rand = (int)random(2);

  if (rand == 0) { // major
    scale[0] = groundFreq;
    scale[1] = groundFreq * pow(a, 4);
    scale[2] = groundFreq * pow(a, 7);
    scale[3] = groundFreq * pow(a, 12);
    scale[4] = groundFreq * pow(a, 16);
    scale[5] = groundFreq * pow(a, 19);
    scale[6] = groundFreq * pow(a, 24);
  } else { // minor
    scale[0] = groundFreq;
    scale[1] = groundFreq * pow(a, 3);
    scale[2] = groundFreq * pow(a, 6);
    scale[3] = groundFreq * pow(a, 12);
    scale[4] = groundFreq * pow(a, 15);
    scale[5] = groundFreq * pow(a, 18);
    scale[6] = groundFreq * pow(a, 24);
  }
}

void playAll(int c) {
  if (!musicCircles[c].playing) {
    osc[c].play();
    musicCircles[c].playing = true;
  }
}

void stopAll(int c) {
  if (musicCircles[c] != null && musicCircles[c].playing) {
    osc[c].stop();         
    musicCircles[c].playing = false;
  }
}

// Draw play button in left upper corner
void playButton() {
  float angle = TWO_PI / 3;
  float radius = playR;
  fill(255);
  noStroke();
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = playX + cos(a) * radius;
    float sy = playY + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

// Draw restart button in right upper corner
void restartButton() {
  pushMatrix();
  translate(restartX, restartY);
  float diam = restartR;
  noFill();
  stroke(255);
  strokeWeight(5);
  ellipse(0, 0, diam, diam);
  fill(backgroundHue, 200, 200);
  noStroke();
  rect(0, 0, diam, diam);

  translate(diam/2, 0);
  rotate(-45);
  float angle = TWO_PI / 3;
  float radius = 10;
  fill(255);
  noStroke();
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = cos(a) * radius;
    float sy = sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
  popMatrix();
}

// reset everything
void reset() {
  for (int i=0; i<circlemax; i++) {
    stopAll(i);
    musicCircles[i] = null;
  }

  circlecount = 0;
  circleDrag = true;
  circleClick = false; 
  drag = false;
  circleCreation = false;
  play = false;
  dragMe = 0;
  clickMe = -1;
  backgroundHue = random(360);
}

void draw() {
  background(backgroundHue, 200, 200);
  playButton();
  restartButton();
  if (!mousePressed) {
    if (!play && circleDrag && musicCircles[dragMe] != null) {
      musicCircles[dragMe].counter = musicCircles[dragMe].len;
      playAll(dragMe);
    } 
    circleDrag = false;
    //circleClick = false;
    circleCreation = false;
  }
  if (play) { // if play has been pressed
    if (playCounter == 0) {
      // at the start of a loop, assign all circles a random sound duration
      for (int i=0; i<circlemax; i++) {
        if (musicCircles[i] != null) {
          musicCircles[i].len = (int)random(50, 200);
        }
      }
    }
    for (int i=0; i<circlemax; i++) {
      // display all circles on screen
      if (musicCircles[i]!=null) {
        musicCircles[i].display();
      }
    }
    if (musicCircles[playCounter] != null) {
      musicCircles[playCounter].display();
      musicCircles[playCounter].count();

      if (musicCircles[playCounter].counter == 0) { 
        if (musicCircles[playCounter].playing) {
          stopAll(playCounter);
          if (playCounter < 6) {
            playCounter ++;
          } else {
            playCounter = 0;
          }
        }
      } else {
        playAll(playCounter);
        return;
      }
    }
  } else if (circleClick && musicCircles[clickMe] != null) { 
    // if a circle has been clicked on, play this circle's sound
    musicCircles[clickMe].counter = musicCircles[clickMe].len;
    playAll(clickMe);
    circleClick = false;
  }
  
  for (int i=0; i<circlemax; i++) {
    if (musicCircles[i]!=null) {
      musicCircles[i].display();
      musicCircles[i].count();

      // set the frequency and the amplitude of the oscillator
      //osc[i].freq(musicCircles[i].freq);
      osc[i].amp(musicCircles[i].diam / diamMax);

      // play in beeps instead of continuously
      if (musicCircles[i].pulse && musicCircles[i].counter == 0) { 
        // if we want to play pulses (beeps), do ...
        if (musicCircles[i].playing) {
          stopAll(i);
        }
      }
    }
  }
}