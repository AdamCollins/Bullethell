class MainMenu
{

  MainMenu() {
  }

  void display() {
    playButton();
  }

  void playButton() {


    strokeWeight(3);
    stroke(7, 3, 15);
    if (mouseX>width/2-(width/6) && mouseX<width/2+(width/6)) stroke(102, 111, 242);
    rect(width/2-(width/6), height/3, width/3, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Play", width/2-50,height/3+50);
  }
}

