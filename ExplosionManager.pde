class ExplosionManager
{
  ArrayList<Explosion> explosions;
  PImage[] explosionImg;
  ExplosionManager()
  {
    explosions = new ArrayList<Explosion>();
    explosionImg = new PImage[81];

    for (int i = 0; i<80; i++) {
      explosionImg[i] = loadImage("explosion/images/explosion_" + nf(i+1, 2) +".png");
      println("loaded " + explosionImg.length);
    }
  }

  void display() {
      
    

    for (int i = 0; i<explosions.size ()-1; i++) {
      Explosion e = explosions.get(i);
      if(e.costume>78) explosions.remove(i);
      e.display();
      
    }
  }

  void create(float _x, float _y) {
    float x = _x;
    float y = _y;
    
    Explosion e = new Explosion(x, y);
    explosions.add(e);
  }
}

