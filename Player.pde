class Player
{

  float x, y, vx, vy, a;
  PImage[] spaceship;
  int costume;
  boolean damageable;
  int safeTimer;
  Player() {
    kbd = new Keyboard();
    damageable = true;
    spaceship = new PImage[12];
    for (int i = 0; i<12; i++) {
      String filename = "spaceship/spaceship_" + nf(i+1, 2) + ".png";
      spaceship[i] = loadImage(filename);
    }
    x = width/2;
    y = height*2/3;
    vx = 0;
    vy = 0;
    a = 0.5;
    costume = 6;
  }

  void update()
  {
    image(spaceship[costume-1], x, y);

    x+=vx;
    y+=vy;

    vx*=0.96;
    vy*=0.96;

    controls();
    calculations();
  }

  void controls() {
    
    //if(kbd.holdingK) lives = -1;

    if (kbd.holdingRight )
    {
      vx=vx+a;
      if (costume<11 && frameCount%2==0)costume++;
    } else {
      if (vx>=0)vx=vx-a;
      if (costume>6 && frameCount%2==0) costume--;
    }

    if (kbd.holdingLeft && x>40)
    {
      if (costume>1 && frameCount%2==0) costume--;
      vx=vx-a;
    } else {
      if (costume<6 && frameCount%2==0) costume++;
      if (vx>=0)vx=vx+a;
    }

    if (kbd.holdingUp && y>0-20)
    {
      vy=vy-a;
    } else {
      if (vy>=0)vy=vy+a;
    }

    if (kbd.holdingDown && y<height+20)
    {
      vy=vy+a;
    } else {
      if (vy>=0)vy=vy-a;
    }



    if (kbd.holdingShift)
    {
      if (frameCount%22==0)
      {

        Bullet b = new Bullet(x-15, y, 10, true);
        bulletmanager.addB(b);

        Bullet b2 = new Bullet(x+12, y, 10, true);
        bulletmanager.addB(b2);
      }
    }
    if (kbd.holdingA && frameCount%20==0 && ui.rnbBCount>0) {
      for (int i = 180; i<360; i+=10) {
        Bullet b = new Bullet(x, y, i, 10, true);
        bulletmanager.addB(b);
      }
      ui.rnbBCount--;
    }

    if (kbd.holdingSpace) {
      shield.inUse = true;
    }

    if (kbd.holdingS) {

      if (frameCount%5==0 && ui.sBCount>0) {

        Bullet b = new Bullet(x, y, 12, true);
        bulletmanager.addB(b);
        ui.sBCount--;
      }
    }
  }
  void calculations() {

    if (lives<0) {
      mode  = MAINMENU;
      scoremanager.writeToServer();
      scoremanager.saveScore();
    }
    if (!damageable) {
      safeTimer++;
      if (safeTimer%5==0)image(spaceship[11], x, y);
      if (safeTimer>60*2) {
        safeTimer = 0;
        damageable = true;
      }
    }
  }
}

