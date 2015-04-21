class MainMenu
{

  MainMenu() {
  }

  void display() {
    playButton();
  }

  void playButton() {


    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>width/2-(width/6) && mouseX<width/2+(width/6) && mouseY>height/3 && mouseY<height/3+70) {
      stroke(102, 111, 242);
      if (mousePressed) {
        gameReset();
        isPlaying = true;
      }
    }
    rect(width/2-(width/6), height/3, width/3, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Play", width/2-50, height/3+50);
  }
}

