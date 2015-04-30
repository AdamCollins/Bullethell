class UI
{
  int sBCount;
  int rnbBCount;

  UI()
  {
    sBCount = 50;
    rnbBCount = 10;
  }

  void display() {
    fill(255);


    textSize(14);
    textFont(font14);
    image(bulletmanager.bullet, 8, 12);    //Display singlebullet count;
    text(sBCount, 15, 15);

    image(bulletmanager.bullet, 8, 30);
    image(bulletmanager.bullet, 12, 30);
    text( "∞", 15, 30);

    image(bulletmanager.bullet, 8, 45);
    image(bulletmanager.bullet, 12, 45);
    image(bulletmanager.bullet, 16, 45);
    text(rnbBCount, 20, 45);

    textFont(font36);
    textSize(36);
    println(score);
    text(score, width-100, 50);
    println(score);


    for (int i = 0; i<lives; i++) {
      pushMatrix();
      scale(0.8, 0.8);
      image(player.spaceship[5], 30+i*40, height-100);
      popMatrix();
    }
    
    if(score%3000==0 && score>0){
      sBCount+=20;
      rnbBCount+=3;
      score+=100;
    }
    
    
    if(score%20000==0 && lives < 3 && score>0){
      lives++;
      score+=100;
       
    }
    
    
  }

  void bulletReset() {
    sBCount = 45;
    rnbBCount = 10;
  }


}

