class EnemyManager
{

  ArrayList<EnemyFlappybird> enemyflappybird;
  ArrayList<Enemy> enemy;
  PImage[] flappybirdPI;
  PImage enemyss;
  float dif;  //Difficulty 
  EnemyManager()
  {
    enemyflappybird = new ArrayList<EnemyFlappybird>();
    enemy = new ArrayList<Enemy>();

    flappybirdPI = new PImage[2];
    flappybirdPI[0] = loadImage("flappyBird/flappybird_1.png");
    flappybirdPI[1] = loadImage("flappyBird/flappybird_2.png");

    enemyss = loadImage("enemyss/enemyss.png");
    dif=40;
  }


  void create()
  {
    if (frameCount%(int)dif==0) {
      if ((level+1)%2==0 || (level+1)%5==0) {
        Enemy e = new Enemy();
        enemy.add(e);
        if (dif>20)dif-=0.1;
      }
    }
    if (frameCount%(int)dif==0) {
      if ((level+1)%3==0 || (level+1)%5==0) {
        EnemyFlappybird f = new EnemyFlappybird();
        enemyflappybird.add(f);
        if (dif>20)dif-=0.1;
      }
    }
  }

  void draw()
  {
    for (int i = enemyflappybird.size ()-1; i>=0; i--)
    {
      EnemyFlappybird f = enemyflappybird.get(i);
      if (shield.inUse && dist(f.x, f.y, player.x,player.y)<60) {
      } else{
        f.move();
      }
      f.show();
      if (rectRect((int)f.x, (int)f.y, 34, 24, (int)player.x, (int)player.y, 36, 41) && player.damageable) {
        lives--;
        player.damageable = false;
        player.x = width/2;
        player.y = height*2/3;
      }
    }
    for (int i = enemy.size ()-1; i>=0; i--)
    {
      Enemy e = enemy.get(i);
      e.move();
      e.show();
    }
  }

  void delete()
  {
    for (int i = enemyflappybird.size ()-1; i>=0; i--)
    {
      EnemyFlappybird f = enemyflappybird.get(i);
      enemyflappybird.remove(f);
    }

    for (int i =  enemy.size ()-1; i>=0; i--)
    {
      Enemy e = enemy.get(i);
      enemy.remove(e);
    }
  }
}

