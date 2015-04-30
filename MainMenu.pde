class MainMenu
{

  MainMenu() {
  }

  void display() {

    fill(0, 0, 0, 150);
    rect(0, 0, width, height); //Fades out starfield for main menu.
    playButton();
    highscoreButton();
  }

  void playButton() {


    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>255 && mouseX<545 && mouseY>height/3 && mouseY<height/3+70) {
      stroke(102, 111, 242);
      if (mousePressed) {
        gameReset();
        isPlaying = true;
      }
    }
    fill(0, 0, 0, 150);
    rect(width/2-(width/6)-15, height/3, width/2.7, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Play", width/2-50, height/3+50);
  }

  void highscoreButton() {
    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>270 && mouseX<530 && mouseY>300 && mouseY<370) {
      stroke(102, 111, 242);
      if (mousePressed) {
        //Show Highscore
        scoremanager.readScores();
      }
    }
    fill(0, 0, 0, 150);
    rect(width/2-(width/6), height/3+100, width/3, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Highscores", width/2-110, height/3+150);
  }
}

