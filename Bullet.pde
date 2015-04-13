class Bullet
{

  float x, y; // pos
  float a; //speed
  float angle;
  float vx, vy ;
  float speed;
  boolean isFriendly, isAlive;
  int costume;
  Bullet(float x, float y, float speed, boolean isFriendly)
  {
    this.x = x;
    this.y = y;
    this.a = a;
    this.isFriendly = isFriendly;
    this.isAlive = isAlive;
    vx=0;
    vy=+speed;
  }

  Bullet(float x, float y, float angle, float speed, boolean isFriendly)
  {
    this.x = x;
    this.y = y;
    this.isFriendly = isFriendly;
    angle = map(angle, 0, 360, 0, TWO_PI);
    vy = -1*sin(angle)*speed;
    vx = -1*cos(angle)*speed;
  }

  void move()
  {
    if (isFriendly) {
      image(bulletmanager.bullet[costume], x, y);
      costume = (costume+1) % 2;
    } else {
      image(bulletmanager.enemyBullet, x, y);
    }

    y-=vy;
    x+=vx;
  }
}

