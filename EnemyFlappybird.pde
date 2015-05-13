class EnemyFlappybird extends Enemy
{
  
  float vx, vy;
  EnemyFlappybird() {
    super();
  }




  void show()
  {
    image(enemymanager.flappybirdPI[costume], x, y);

    if (frameCount%10==0)costume++;
    if (costume>1) costume = 0;
  }

  void move() {
    vx = (player.x-x)/90;
    vy = (player.y-30-y)/90+(20/enemymanager.dif);
    y+=vy;
    x+=vx;
  }
}

