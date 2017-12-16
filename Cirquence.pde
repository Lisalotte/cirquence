/*
** Introduction to Programming - final assignment
** @author Monica Preller
** @author Lisa Pothoven
** @date 13-12-2017
** @abstract This is the main file of our application called 'Cirquence'.
*/

CreateCircle musicCircle;
Boolean draw = false;

void setup() {
  //size (1280, 1024);
  fullScreen(); // Run the code at the full dimensions of the current screen
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
