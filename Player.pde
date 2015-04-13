class Player
{

  float x, y, vx, vy, a;
  PImage[] spaceship;
  int costume;

  Player() {
    kbd = new Keyboard();
    spaceship = new PImage[11];
    for (int i = 0; i<11; i++) {
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
  }

  void controls() {

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
      if (frameCount%18==0)
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
        println(b.isFriendly);
        
      }
      ui.rnbBCount--;
    }

    if (kbd.holdingS) {

      if (frameCount%5==0 && ui.sBCount>0) {

        Bullet b = new Bullet(x, y, 12, true);
        bulletmanager.addB(b);
        ui.sBCount--;
      }
    }
  }
}

