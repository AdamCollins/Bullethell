class Explosion
{
  float x, y;
  int costume;
  Explosion(float x, float y)
  {
    this.x = x;
    this.y = y;
    costume = 0;
  }

  void display() {
    image(explosionmanager.explosionImg[costume],x,y);
    costume++;
    
  }
}



