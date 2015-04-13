class Flappybird
{

  int costume;
  float x, y;
  float v;
  Flappybird()
  {

    v = 2;
    x = random(50, width-50);
    y = -50;
    costume = 1;
  }

  void show()
  {
    image(enemymanager.flappybirdPI[costume], x, y);

    if (frameCount%10==0)costume++;
    if (costume>1) costume = 0;
    y+=v;
  }

  void move()
  {
    
    if (frameCount%50+(int)random(-5,5)==0 && y>0) {
     Bullet b = new Bullet(x, y, -10, false);
     bulletmanager.addB(b);
     }
     y+=v;
  }
}

