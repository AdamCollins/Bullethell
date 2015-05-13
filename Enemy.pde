class Enemy 
{

  int costume;
  float x, y;
  float v;
  Enemy() {
    x = random(50, width-50);
    y = -50;
    v =2;
  }

  void move()
  {
    if (frameCount%50+(int)random(-5, 5)==0 && y>0) {
      Bullet b = new Bullet(x, y, -9, false);
      bulletmanager.addB(b);
    }
    y+=v;
  }
  void show()
  {

    fill(250, 50, 12);
    image(enemymanager.enemyss, x, y);
  }
}

