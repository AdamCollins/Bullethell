class Shield
{
  float x, y;
  boolean inUse;
  Shield()
  {
    x = player.x;
    y = player.y;
  }

  void update()
  {
    if(inUse)show();
    move();
  }

  void show()
  {
    noFill();
    stroke(0,200,255);
    ellipse(x, y, 50, 50);
  }

  void move()
  {
    x = player.x;
    y = player.y;
  }
}

