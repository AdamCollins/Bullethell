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
    if(ui.shieldTimer<0) inUse = false;
    if (inUse && ui.shieldTimer>0) {
      player.damageable = false;
      move();
      show();
      //ui.shieldTimer--;
    } else {
      inUse = false;
    }
  }

  void show()
  {
    noFill();
    stroke(0, 200, 255);
    ellipse(x, y, 75, 75);
  }

  void move()
  {
    x = player.x;
    y = player.y;
  }
}

