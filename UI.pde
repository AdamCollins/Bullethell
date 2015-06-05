class UI
{
  int sBCount;
  int rnbBCount;
  float shieldTimer;
  UI()
  {
    sBCount = 45;
    rnbBCount = 5;
    shieldTimer = 250;
    paused = false;
  }

  void display() {
    noStroke();
    fill(255);


    textSize(14);
    textFont(font14);
    image(bulletmanager.bullet, 8, 12);    //Display singlebullet count;
    text(sBCount, 15, 15);

    image(bulletmanager.bullet, 8, 30);
    image(bulletmanager.bullet, 12, 30);   //Double bullet count
    text( "∞", 15, 30);

    image(bulletmanager.bullet, 8, 45);
    image(bulletmanager.bullet, 12, 45);  //Rainbow bullet count; 
    image(bulletmanager.bullet, 16, 45);
    text(rnbBCount, 20, 45);

    noFill();
    stroke(0, 200, 255);      //Shield level;
    strokeWeight(2);
    ellipse(12, 63, 10, 10);
    float w = map(shieldTimer, 0, 250, 0, 50);
    noStroke();
    fill(0, 200, 255);
    rect(20, 57, w, 10);
    textFont(font36);
    textSize(36);
    fill(255);
    text(score, width-100, 50);



    for (int i = 0; i<lives; i++) {
      pushMatrix();
      scale(0.8, 0.8);
      noStroke();
      image(player.spaceship[5], 30+i*40, height+100);
      popMatrix();
    }

    calculations();
  }

  void calculations() {
    if (score%3000==0 && score>0) {
      sBCount+=20;
      rnbBCount+=3;
    }
    if (score%6000==0 && score>0) {
      shieldTimer = 250;
      score+=100;
    }


    if (score%20000==0 && lives < 3 && score>0) {
      lives++;
      score+=100;
    }
    scoremanager.sortLocalScores();
    if (score>scoremanager.sortedLocalScores[scoremanager.sortedLocalScores.length-1]) {
      fill(102, 111, 242);
      textFont(font36);
      textSize(24);
      text("High Score!", width/2-100, 24);
    }

    if (kbd.holdingP) {
      if (mode!=PAUSED) {
        textFont(font36);
        textSize(36);
        text("PAUSED", width/2-100, height/2);
        mode = PAUSED;
        //musicPlayer.pause();
        delay(180);
      } else {
        mode = PLAYING;
        //musicPlayer.play();
        delay(180);
      }
    }
  }
  void bulletReset() {
    sBCount = 65;
    rnbBCount = 15;
    shieldTimer = 250;
  }
}

