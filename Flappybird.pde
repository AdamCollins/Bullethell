class Flappybird
{

  int costume;
  float x, y;
  float vx, vy;
  Flappybird()
  {

    x = random(50, width-50);
    y = -50;
    costume = 1;
  }

  void show()
  {
    image(enemymanager.flappybirdPI[costume], x, y);

    if (frameCount%10==0)costume++;
    if (costume>1) costume = 0;
  }


  void move() {
    vx = (player.x-x)/40;
    vy = (player.y-30-y)/40+0.5;
      y+=vy;
      x+=vx;
  }

}

