CreateCircle musicCircle;
Boolean draw = false;

class CreateCircle {
  float xpos;
  float ypos;
  float diam;
  float colour;

  CreateCircle(float x, float y, float size) {
    xpos=x;
    ypos=y;
    diam=size;
    draw = true;
  }
  void display() {
    fill(255);
    ellipse(xpos, ypos, diam, diam);
  }
}


void setup() {
  size (1280, 1024);
}

void draw() {
  background(0);
  if (draw) {
    musicCircle.display();
  }
}

void mouseClicked() {
  musicCircle=new CreateCircle(mouseX, mouseY, 100);
  draw = true;
}