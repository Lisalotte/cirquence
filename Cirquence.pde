/*
** Introduction to Programming - final assignment
 ** @author Monica Preller
 ** @author Lisa Pothoven
 ** @date 13-12-2017
 ** @abstract This is the main file of our application called 'Cirquence'.
 */
MusicCircle musiccircle;

void setup() {
  fullScreen(); // Run the code at the full dimensions of the current screen
}

void mouseClicked() {
  musiccircle=new MusicCircle(mouseX, mouseY, 100, 20, 255, 10,true);
}

void draw() {
  background(0);
  if (musiccircle.draw == true) {
    musiccircle.display();
  }
}