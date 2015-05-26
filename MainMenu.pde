class MainMenu
{
  int subMode;
  final int MAIN = 0;
  final int HIGHSCORE = 1;

  int hsMode;
  final int LOCAL = 0;
  final int GLOBAL = 1;

  boolean isTouchingLG;
  MainMenu() {
    mode = MAINMENU;
    hsMode = LOCAL;
  }

  void display() {

    fill(0, 0, 0, 150);
    rect(0, 0, width, height); //Fades out starfield for main menu.

    if (subMode == MAIN) {
      playButton();
      highscoreButton();
    } else if (subMode == HIGHSCORE)
    {
      backButton();
      highscores();
    }
  }

  void playButton() {


    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>255 && mouseX<545 && mouseY>height/3 && mouseY<height/3+70) {
      stroke(102, 111, 242);
      if (mousePressed) {
        gameReset();
        mode = PLAYING;
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
        subMode = HIGHSCORE;
      }
    }
    fill(0, 0, 0, 150);
    rect(width/2-(width/6), height/3+100, width/3, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Highscores", width/2-110, height/3+150);
  }


  void highscores() {
    if (hsMode==LOCAL)localScores();
    if (hsMode==GLOBAL)globalScores();
  }

  void localScores() {
    textSize(36);
    textFont(font36);
    if (mouseX>340 && mouseX<460 && mouseY>65 && mouseY<100) { 
      fill(102, 111, 242); 
      isTouchingLG = true;
    } else {
      isTouchingLG = false;
    }
    text("Local", width/2-40, 95);
    textSize(48);
    textFont(font48);
    fill(255);
    text("High Scores", width/2-110, 60);

    int y = 140;
    int n = 1;
    scoremanager.sortLocalScores();
    for (int i = scoremanager.sortedLocalScores.length-1; i>scoremanager.sortedLocalScores.length-8; i--) {
      int s = scoremanager.sortedLocalScores[i];
      text(n +". " + s, width/2-105, y);
      y+=48;
      n++;
    }
  }

  void globalScores() {

    textSize(36);
    textFont(font36);
    if (mouseX>340 && mouseX<460 && mouseY>65 && mouseY<100) { 
      fill(102, 111, 242); 
      isTouchingLG = true;
    } else {
      isTouchingLG = false;
    }
    text("Global", width/2-40, 95);
    textSize(48);
    textFont(font48);
    fill(255);
    text("High Scores", width/2-110, 60);
    int y = 140;
    int n = 1;
    scoremanager.sortLocalScores();
    for (int i = scoremanager.sortedLocalScores.length-1; i>scoremanager.sortedLocalScores.length-8; i--) {
      int s = scoremanager.sortedLocalScores[i];
      text(n +". " + s, width/2-105, y);
      y+=48;
      n++;
    }
  }

  void backButton() {
    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>320 && mouseX<475 && mouseY>460 && mouseY<530) {
      stroke(102, 111, 242);
      if (mousePressed) {
        subMode = MAIN;
      }
    }
    fill(0, 0, 0, 150);
    rect(width/2-width/10, height-140, width/5, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Back", width/2-55, height-90);
  }
}

