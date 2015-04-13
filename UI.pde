class UI
{
  int sBCount;
  int rnbBCount;

  UI()
  {
    sBCount = 500;
    rnbBCount = 10;
  }

  void display() {
    fill(255);


    textSize(14);
    textFont(font14);
    image(bulletmanager.bullet[0], 8, 12);    //Display singlebullet count;
    text(sBCount, 15, 15);

    image(bulletmanager.bullet[0], 8, 30);
    image(bulletmanager.bullet[0], 12, 30);
    text( "∞", 15, 30);

    image(bulletmanager.bullet[0], 8, 45);
    image(bulletmanager.bullet[0], 12, 45);
    image(bulletmanager.bullet[0], 16, 45);
    text(rnbBCount, 20, 45);

    textFont(font36);
    textSize(36);
    text(score, width-100, 50);


    for (int i = 0; i<lives; i++) {
      pushMatrix();
      scale(0.8, 0.8);
      image(player.spaceship[5], 30+i*40, height-100);
      popMatrix();
    }
  }
}

