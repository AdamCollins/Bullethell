class Flappybird
{

  int costume;
  float x, y;
  float vx, vy;
  Flappybird()
  {

    x = random(50, width-50);
    y = -50;
    costume = 1;
  }

  void show()
  {
    image(enemymanager.flappybirdPI[costume], x, y);

    if (frameCount%10==0)costume++;
    if (costume>1) costume = 0;
  }


  void move() {
    vx = (player.x-x)/40;
    vy = (player.y-y)/40;
    println(touching());
    //if (!touching()) {
      y+=vy;
      x+=vx;
    //}
  }

  boolean touching() {
    for (int i = 0; i<enemymanager.flappybird.size (); i++) {
      Flappybird f = enemymanager.flappybird.get(i);
      if (dist(x, y, f.x, f.y)<40){
        return true;
        
      }
    }
    return false;
  }
}

