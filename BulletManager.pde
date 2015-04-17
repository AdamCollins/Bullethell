class BulletManager
{
  ArrayList<Bullet> bullets;
  PImage bullet;
  PImage enemyBullet;
  BulletManager()
  {
    bullets = new ArrayList<Bullet>();
    bullet = loadImage("bullet/bullet_1.png");
    enemyBullet = loadImage("bullet/downBullet.png");
  }

  void update()
  {
    for (int i = bullets.size ()-1; i>=0; i--) 
    {
      Bullet b = bullets.get(i);
      b.move();
      if (b.y<-50 || b.y>height+50) bullets.remove(i);
      if (b.x<-50 || b.x>width+50) bullets.remove(i);

      if (rectRect((int)b.x, (int)b.y, 3, 11, (int)player.x, (int) player.y, 11, 31) && player.damageable && !b.isFriendly) {
        lives--;
        player.damageable = false;
        player.x = width/2;
        player.y = height*2/3;
      }

      for (int k = enemymanager.secondenemy.size ()-1; k>=0; k--) 
      {
        SecondEnemy s = enemymanager.secondenemy.get(k);
        if (rectRect((int)b.x, (int)b.y, 3, 11, (int)s.x, (int) s.y, 43, 47) && b.isFriendly) {
          println("HIT");
          bullets.remove(i);
          explosionmanager.create(s.x, s.y);
          enemymanager.secondenemy.remove(k);

          score+=100;

          break;
        }
      }

      for (int j = enemymanager.flappybird.size ()-1; j>=0; j--) 
      {
        Flappybird f = enemymanager.flappybird.get(j);
        if (rectRect((int)b.x, (int)b.y, 3, 11, (int)f.x, (int) f.y, 32, 24) && b.isFriendly) {
          bullets.remove(i);
          explosionmanager.create(f.x, f.y);
          enemymanager.flappybird.remove(j);

          score+=100;

          break;
        }
      }
    }
  }
  void addB(Bullet b)
  {
    bullets.add(b);
  }
}

