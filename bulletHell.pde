/* Written by Adam Collins Alpha version.
 *-----Special Features-----
 * -Two types of enemies that spawn in waves.
 * -Indicates when higscore is achived.
 * -Highscores save and are sorted in order.
 * -Menu and pause.
 * -3 diffrent types of bullets with bullet counter.
 * -Replenishes bullets and lives when certian scores are reached.
 * -Enemies that follow player.
 * -Invncible for 3 seconds after losing life. + invincible animation.
 *cats singing as they attack the ships 
 *-----Controls-----
 *Basic bullets(unlimited): SHIFT
 *Fast bullets: S
 *Rainbow bullets: A
 *Movement: Arrow keys
 *Pause: P
 */
import java.io.BufferedWriter;
import java.io.FileWriter;
import ddf.minim.*;
import de.voidplus.soundcloud.*;
import processing.net.*;

Minim minim;
SoundCloud soundcloud;
AudioPlayer musicPlayer;
AudioMetaData meta;

Starfield starF;
Keyboard kbd;
Player player;
BulletManager bulletmanager;
EnemyManager enemymanager;
ExplosionManager explosionmanager;
MainMenu mainmenu;
ScoreManager scoremanager;
Shield shield;
Music music;
SFX sfx; //Not working. WIP
UI ui;
Client c;
int score;
int lives;
int level;
int gameTime;    //Time game has been playing.
PFont font36;
PFont font14;
PFont font48;
int mode;

final int MAINMENU = 0;
final int PLAYING = 1;
final int PAUSED = 2;


void setup()
{
  //size(displayWidth, displayHeight,P2D);
  size(800, 600, P2D);
  
  background(0);
  println("Loading", width/2, height/2);
  
  font36 = loadFont("font36.vlw");
  font14 = loadFont("font14.vlw");
  font48 = loadFont("font48.vlw");
  smooth(8);
  imageMode(CENTER);
  mode = MAINMENU;
  mainmenu = new MainMenu();
  c = new Client(this, "10.32.36.116", 12345);
  println("Loading.", width/2, height/2);
  starF = new Starfield(50); //Creates Starfeild. Args = num of stars.
  kbd = new Keyboard();
  println("Loading..", width/2, height/2);
  player = new Player();
  shield = new Shield();
  bulletmanager = new BulletManager();
  println("Loading...", width/2, height/2);
  enemymanager = new EnemyManager();
  explosionmanager = new ExplosionManager();
  scoremanager = new ScoreManager();
  minim = new Minim(this);
  println("Loading.", width/2, height/2);
  sfx = new SFX();
  ui = new UI();
  music = new Music();
  println("Loading..", width/2, height/2);
  music.chooseSong();
}

void draw()
{
  

  noStroke();

  if (mode == MAINMENU) 
  {
    isMainMenu();
  } else if (mode == PLAYING)
  {
    isPlaying();
  } else if (mode == PAUSED)
  {
    isPaused();
  }
}

void isPlaying() {
  gameTime++;
  starF.show();
  bulletmanager.update();
  player.update();
  enemymanager.create();
  enemymanager.draw();
  explosionmanager.display();
  //shield.update();
  if (gameTime%1800==0) level++;
  ui.display();
}

void isMainMenu() {
  starF.show();
  mainmenu.display();
}
void isPaused() {
  ui.display();
}

void gameReset() {
  lives = 3;
  gameTime=0;
  level = 1;
  score = 0;
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
  } else {            // if not, return false
    return false;
  }
}

