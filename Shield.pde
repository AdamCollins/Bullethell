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
    show();
    move();
  }

  void show()
  {
    fill(0,200,255);
    stroke(4);
    ellipse(x, y, 50, 50);
  }

  void move()
  {
    x = player.x;
    y = player.y;
  }
}

