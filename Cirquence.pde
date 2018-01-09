CreateCircle[] musicCircles;

Boolean draw = false;
Boolean circleclick = true;
float savedX;
float savedY;
float backgroundHue=random(360);
int diamMax=500;
int circlecount=0;
int circlemax=8;

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
  background(255);
  musicCircles=new CreateCircle [circlemax];
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
  if (circlecount<circlemax) {
    musicCircles[circlecount]=new CreateCircle(mouseX, mouseY, 10);
    colorMode(HSB,255);
    background(backgroundHue, 200, 200);
    println (backgroundHue);
    musicCircles[circlecount].ellipseSat-=(circlecount*15);
    musicCircles[circlecount].ellipseBright+=(circlecount*5);
    println (musicCircles[circlecount].ellipseSat);
    println (musicCircles[circlecount].ellipseSat);
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