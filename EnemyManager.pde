class EnemyManager
{

  ArrayList<Flappybird> flappybird;
  ArrayList<SecondEnemy> secondenemy;
  PImage[] flappybirdPI;
  PImage enemyss;
  float dif;  //Difficulty 
  EnemyManager()
  {
    flappybird = new ArrayList<Flappybird>();
    secondenemy = new ArrayList<SecondEnemy>();

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
        SecondEnemy s = new SecondEnemy();
        secondenemy.add(s);
        if (dif>20)dif-=0.1;
      }
    }
    if (frameCount%(int)dif==0) {
      if ((level+1)%3==0 || (level+1)%5==0) {
        Flappybird f = new Flappybird();
        flappybird.add(f);
        if (dif>20)dif-=0.1;
      }
    }
  }

  void draw()
  {
    for (int i = flappybird.size ()-1; i>=0; i--)
    {
      Flappybird f = flappybird.get(i);
      f.move();
      f.show();
      if (rectRect((int)f.x, (int)f.y, 34, 24, (int)player.x, (int)player.y, 36, 41) && player.damageable) {
        lives--;
        player.damageable = false;
        player.x = width/2;
        player.y = height*2/3;
      }
    }
    for (int i = secondenemy.size ()-1; i>=0; i--)
    {
      SecondEnemy s = secondenemy.get(i);
      s.move();
      s.show();
    }
  }

  void delete()
  {
    for (int i = flappybird.size ()-1; i>=0; i--)
    {
      Flappybird f = flappybird.get(i);
      flappybird.remove(f);
    }

    for (int i = secondenemy.size ()-1; i>=0; i--)
    {
      SecondEnemy s = secondenemy.get(i);
      secondenemy.remove(s);
    }
  }
}

