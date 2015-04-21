Starfield starF;
Keyboard kbd;
Player player;
BulletManager bulletmanager;
EnemyManager enemymanager;
ExplosionManager explosionmanager;
MainMenu mainmenu;
UI ui;
int score;
int lives;
int gameTime;
PFont font36;
PFont font14;
PFont font48;
boolean isPlaying;
void setup()
{
  //size(displayWidth, displayHeight,P2D);
  size(800, 600, P2D);
  font36 = loadFont("font36.vlw");
  font14 = loadFont("font14.vlw");
  font48 = loadFont("font48.vlw");
  mainmenu = new MainMenu();
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
  noStroke();

  if (isPlaying)
  {
    gameTime++;
    starF.show();
    bulletmanager.update();
    player.update();
    player.controls();
    enemymanager.create();
    enemymanager.draw();
    explosionmanager.display();
    ui.display();
  } 
  else 
  {

    
    starF.show();
    fill(0, 0, 0, 150);
    rect(0, 0, width, height);
    mainmenu.display();
  }

  if (lives<0) isPlaying  = false;
}

void gameReset(){
  lives = 0;
  gameTime=0;
  player.damageable=true;
  enemymanager.delete();
  bulletmanager.delete();
  ui.bulletReset();
  explosionmanager.delete();
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
  } 
  else {            // if not, return false
    return false;
  }
}

