import processing.sound.*;
SinOsc[] osc;

CreateCircle[] musicCircles;

Boolean draw = false;
Boolean circleClick = true;
boolean drag = false;
boolean circleCreation = false;
int dragMe = 0;
float savedX;
float savedY;
float backgroundHue=random(360);
int diamMax=500;
int circlecount;
int circlemax=7;

float [] groundTones = {440, 495, 264, 297, 330, 352, 396}; // A B C D E F G
float [] scale;

void setup() {
  size (600, 600);    
  colorMode(HSB,255);

  musicCircles = new CreateCircle [circlemax];
  osc = new SinOsc[circlemax];
  scale = new float[circlemax]; //triad
  circlecount = 0;
}

void mousePressed() {
  draw = true;
  for (int i = 0; i<circlemax; i++) {
    if (musicCircles[i] != null) {
      float A = pow(musicCircles[i].xpos - float(mouseX), 2f);
      float B = pow(musicCircles[i].ypos - float(mouseY), 2f);
      if (sqrt(A+B) <= musicCircles[i].diam) {
        circleClick = true; 
        dragMe = i;
        return;
      }
    }
  }
  if (circlecount < circlemax) {
    musicCircles[circlecount]=new CreateCircle(mouseX, mouseY, 10);
    musicCircles[circlecount].ellipseSat-=(circlecount*15);
    musicCircles[circlecount].ellipseBright+=(circlecount*5);
        
     // Create new sound oscillator
    osc[circlecount] = new SinOsc(this);
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
  if (circlecount > 0 && circleClick) {
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
  //int rand = (int)random(groundTones.length);
  //float groundFreq = groundTones[rand];
  
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

void draw() {
  background(backgroundHue, 200, 200);
  if (!mousePressed) {
    if (circleClick && musicCircles[dragMe] != null) {
      musicCircles[dragMe].counter = musicCircles[dragMe].len;
      osc[dragMe].play();
      musicCircles[dragMe].playing = true;
    }
    circleClick = false;
    circleCreation = false;
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
          osc[i].stop();
          musicCircles[i].playing = false;
        } //else {
        //  osc[i].play();
        //  musicCircles[i].playing = true;
       // }
      }
    }
  }
}