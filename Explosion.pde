class Explosion
{
  float x, y;
  int costume;
  AudioPlayer explosion;
  Explosion(float x, float y)
  {
    this.x = x;
    this.y = y;
    costume = 0;
    explosion = sfx.explosion;

//    explosion.play();   //TODO: fix sound.
//    explosion.rewind();
  }

  void display() {
    image(explosionmanager.explosionImg[costume], x, y);
    costume++;
  }
}


