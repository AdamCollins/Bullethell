class SecondEnemy 
{

  int costume;
  float x, y;
  float vx, vy;
  SecondEnemy() {
    x = random(50, width-50);
    y = -50;
  }

  void move() {
    vx = (player.x-x)/40;
    vy = (player.y-y)/40;
    y+=vy;
    x+=vx;
  }
  void show()
  {
    //image(enemymanager.flappybirdPI[costume], x, y);
    fill(250, 50, 12);
    rect(x, y, 25, 25);
    if (frameCount%10==0)costume++;
    if (costume>1) costume = 0;
  }
}

