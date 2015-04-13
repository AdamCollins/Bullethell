class EnemyManager
{

  ArrayList<Flappybird> flappybird;
  ArrayList<SecondEnemy> secondenemy;
  PImage[] flappybirdPI;
  EnemyManager()
  {
    flappybird = new ArrayList<Flappybird>();
    secondenemy = new ArrayList<SecondEnemy>();

    flappybirdPI = new PImage[2];
    flappybirdPI[0] = loadImage("flappyBird/flappybird_1.png");
    flappybirdPI[1] = loadImage("flappyBird/flappybird_2.png");
  }


  void create()
  {
    if (frameCount%20==0 && frameCount <60*30) {
      Flappybird f = new Flappybird();
      flappybird.add(f);
    }
    if (frameCount%50==0 && frameCount >60*30) {
      SecondEnemy s = new SecondEnemy();
      secondenemy.add(s);
    }
  }

  void draw()
  {
    for (int i = flappybird.size ()-1; i>=0; i--)
    {
      Flappybird f = flappybird.get(i);
      f.move();
      f.show();
    }
    for (int i = secondenemy.size ()-1; i>=0; i--)
    {
      SecondEnemy s = secondenemy.get(i);
      s.move();
      s.show();
    }
  }
}

