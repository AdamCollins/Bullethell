Starfield starF;
Keyboard kbd;
Player player;
BulletManager bulletmanager;
EnemyManager enemymanager;
ExplosionManager explosionmanager;
UI ui;
int score;
int lives;
PFont font36;
PFont font14;
void setup()
{
  //size(displayWidth, displayHeight,P2D);
  size(800, 600, P2D);
  lives = 3;
  font36 = loadFont("font36.vlw");
  font14 = loadFont("font14.vlw");
  starF = new Starfield(50); //Creates Starfeild. Args = num of stars.
  kbd = new Keyboard();
  player = new Player();
  bulletmanager = new BulletManager();
  enemymanager = new EnemyManager();
  explosionmanager = new ExplosionManager();
  ui = new UI();
  
  
}

void draw()
{
  smooth(8);
  imageMode(CENTER);
  //background(0);

  //starF.lightSpeed();
  starF.show();
  bulletmanager.update();
  player.update();
  player.controls();
  enemymanager.create();
  enemymanager.draw();
  explosionmanager.display();
  ui.display();
  
  if(lives<0) noLoop();
}

void keyPressed(KeyEvent evt) {
  kbd.pressKey(evt.getKeyCode());
}

void keyReleased(KeyEvent evt) {
  kbd.releaseKey(evt.getKeyCode());
}


boolean rectRect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {

  // test for collision
  if (x1+w1/2 >= x2-w2/2 && x1-w1/2 <= x2+w2/2 && y1+h1/2 >= y2-h2/2 && y1-h1/2 <= y2+h2/2) {
    return true;    // if a hit, return true
  } else {            // if not, return false
    return false;
  }
}

