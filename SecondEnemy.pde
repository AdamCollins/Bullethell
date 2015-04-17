class SecondEnemy 
{

  int costume;
  float x, y;
  float v;
  SecondEnemy() {
    x = random(50, width-50);
    y = -50;
  }

  void move()
  {
    
    if (frameCount%50+(int)random(-5,5)==0 && y>0) {
     Bullet b = new Bullet(x, y, -10, false);
     bulletmanager.addB(b);
     }
     y+=v;
  }
  void show()
  {
      
    fill(250, 50, 12);
    rect(x, y, 25, 25);
  }
}

