class EnemyManager
{

  ArrayList<Flappybird> flappybird;
  PImage[] flappybirdPI;
  EnemyManager()
  {
    flappybird = new ArrayList<Flappybird>();

    flappybirdPI = new PImage[2];
    flappybirdPI[0] = loadImage("flappyBird/flappybird_1.png");
    flappybirdPI[1] = loadImage("flappyBird/flappybird_2.png");
  }


  void create()
  {
    if (frameCount%20==0 /*&&frameCount <60*30*/) {
      Flappybird f = new Flappybird();
      flappybird.add(f);
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
        
  }
}

