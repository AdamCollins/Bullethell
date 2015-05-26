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
      println(1);
      b.move();
      println(2);
      if (b.y<-50 || b.y>height+50) bullets.remove(i);
      if (b.x<-50 || b.x>width+50) bullets.remove(i);
      println(3);
      if (rectRect((int)b.x, (int)b.y, 3, 11, (int)player.x, (int) player.y, 11, 31) && player.damageable && !b.isFriendly) {
        lives--;
        player.damageable = false;
        player.x = width/2;
        player.y = height*2/3;
      }
      println(4);
      if (rectRect((int)b.x, (int)b.y, 3, 11, (int)player.x, (int)player.y, 65, 65) && !b.isFriendly && shield.inUse) {
        b.vy = 2;
      }
        println(4);
      for (int k = enemymanager.enemy.size ()-1; k>=0; k--) 
      {
        println(5);
        Enemy e = enemymanager.enemy.get(k);
        if (rectRect((int)b.x, (int)b.y, 3, 11, (int)e.x, (int) e.y, 43, 47) && b.isFriendly) {
          bullets.remove(i);
          explosionmanager.create(e.x, e.y);
          enemymanager.enemy.remove(k);

          score+=100;

          break;
        }
      }
      println(5);
      for (int j = enemymanager.enemyflappybird.size ()-1; j>=0; j--) 
      {
        println(6);
        EnemyFlappybird f = enemymanager.enemyflappybird.get(j);
        if (rectRect((int)b.x, (int)b.y, 3, 11, (int)f.x, (int) f.y, 32, 24) && b.isFriendly) {
          bullets.remove(i);
          explosionmanager.create(f.x, f.y);
          enemymanager.enemyflappybird.remove(j);

          score+=100;

          break;
        }
      }
    }
  }
  void addB(Bullet b)
  {
    println(7);
    bullets.add(b);
  }

  void delete() {
    for (int i = bullets.size ()-1; i>=0; i--) 
    {
      println(8);
      Bullet b = bullets.get(i);
      bullets.remove(b);
    }
  }
}

