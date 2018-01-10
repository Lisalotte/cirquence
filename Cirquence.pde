import processing.sound.*;
TriOsc[] osc;

CreateCircle[] musicCircles;

Boolean draw = false;
Boolean circleclick = true;
float savedX;
float savedY;
float backgroundHue=random(360);
int diamMax=500;
int circlecount=0;
int circlemax=7;

float [] groundTones = {440, 495, 264, 297, 330, 352, 396}; // A B C D E F G
float [] scale;

class CreateCircle {
  float xpos;
  float ypos;
  float mouseRx;
  float mouseRy;
  float diam;
  float ellipseSat;
  float ellipseBright;

  CreateCircle(float x, float y, float size) {
    xpos=x;
    ypos=y;
    diam=size;
    draw = true;
    ellipseSat = 200;
    ellipseBright=250;
  }

  void display() {
    colorMode(HSB,255);
    noStroke();
    fill(backgroundHue, ellipseSat, ellipseBright);
    ellipse(xpos, ypos, diam, diam);
  }
}

void setup() {
  //size (1280, 1024);
  size (600, 600);    
  colorMode(HSB,255);
  background(backgroundHue, 200, 200);

  musicCircles=new CreateCircle [circlemax];
  osc = new TriOsc[circlemax];
  scale = new float[circlemax]; //triad
}

void draw() {
  for (int i=0; i<circlemax; i++) {
    if (musicCircles[i]!=null) {
      musicCircles[i].display();
    }
  }
}

void mousePressed() {
  draw = true;
  if (circlecount < circlemax) {
    musicCircles[circlecount]=new CreateCircle(mouseX, mouseY, 10);
    musicCircles[circlecount].ellipseSat-=(circlecount*15);
    musicCircles[circlecount].ellipseBright+=(circlecount*5);
    println (musicCircles[circlecount].ellipseSat);
    println (musicCircles[circlecount].ellipseSat);
    
     // Create new sound oscillator
    osc[circlecount] = new TriOsc(this);
    if (circlecount == 0) {
      int rand = (int)random(groundTones.length);
      osc[circlecount].freq(groundTones[rand]);
      createScale(groundTones[rand]);
    } else {
      int rand = (int)random(scale.length);
      osc[circlecount].freq(scale[rand]);
    }
    osc[circlecount].play();
    
    circlecount++;
  } else {
    circleclick=false;
  }
}

void mouseDragged() {
  if (circlecount>0 && circleclick==true) {
    float superR=dist(musicCircles[circlecount-1].xpos, musicCircles[circlecount-1].ypos, mouseX, mouseY);
    musicCircles[circlecount-1].diam=constrain(2*superR, 0, diamMax);
  } else {
    circleclick=false;
  }
}

void createScale(float groundFreq) {
  //int rand = (int)random(groundTones.length);
  //float groundFreq = groundTones[rand];
  
  float a = pow(2f, 1f/12f);
  int rand = (int)random(2);
  
  if (rand == 0) {
    scale[0] = groundFreq;
    scale[1] = groundFreq * pow(a, 4);
    scale[2] = groundFreq * pow(a, 7);
    scale[3] = groundFreq * pow(a, 12);
    scale[4] = groundFreq * pow(a, 16);
    scale[5] = groundFreq * pow(a, 19);
    scale[6] = groundFreq * pow(a, 24);
  } else {
    println("mineur");
    scale[0] = groundFreq;
    scale[1] = groundFreq * pow(a, 3);
    scale[2] = groundFreq * pow(a, 6);
    scale[3] = groundFreq * pow(a, 12);
    scale[4] = groundFreq * pow(a, 15);
    scale[5] = groundFreq * pow(a, 18);
    scale[6] = groundFreq * pow(a, 24);
  }
  println(rand);
  
  for (int i=0; i<scale.length; i++) {
    println(scale[i]);
  }
}