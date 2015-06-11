/* Written by Adam Collins Alpha version.
 *-----Special Features-----
 * -Two types of enemies that spawn in waves.
 * -Indicates when higscore is achived.
 * -Highscores save and are sorted in order.
 * -Menu and pause.
 * -3 diffrent types of bullets with bullet counter.
 * -Replenishes bullets and lives when certian scores are reached.
 * -Enemies that follow player.
 * -Shield reflects bullets and saves player.
 * -Invncible for 3 seconds after losing life. + invincible animation.
 * -Server support.
 *    -Connects and writes score to server.
 *    -Game request scores and list them as highscore. (Under global highscore.)
 *
 * -After the game the highscore menu lights your score up in green if you achieved a highscore.
 *
 *-----Controls-----
 *Basic bullets(unlimited): SHIFT
 *Fast bullets: S
 *Rainbow bullets: A
 *Movement: Arrow keys
 *Pause: P
 *Spacebar: Toggles shield on and off.
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
  println("Loading");

  font36 = loadFont("font36.vlw");
  font14 = loadFont("font14.vlw");
  font48 = loadFont("font48.vlw");
  smooth(8);
  imageMode(CENTER);
  mode = MAINMENU;
  mainmenu = new MainMenu();
  //c = new Client(this, "10.32.38.28", 12345);
  c = new Client(this, "127.0.0.1", 12345);
  c.write("connection");
  println("Loading.");
  starF = new Starfield(50); //Creates Starfeild. Args = num of stars.
  kbd = new Keyboard();
  println("Loading..");
  player = new Player();
  shield = new Shield();
  bulletmanager = new BulletManager();
  println("Loading...");
  enemymanager = new EnemyManager();
  explosionmanager = new ExplosionManager();
  scoremanager = new ScoreManager();
  minim = new Minim(this);
  println("Loading.");
  sfx = new SFX();
  ui = new UI();
  music = new Music();
  println("Loading..");
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
  music.playSong();
  enemymanager.create();
  enemymanager.draw();
  explosionmanager.display();
  shield.update();
  if (gameTime%1800==0) level++;
  ui.display();
}

void isMainMenu() {
  starF.show();
  mainmenu.display();
  music.playSong();
}
void isPaused() {
  ui.display();
  music.playSong();
}

void gameReset() {
  lives = 3;
  gameTime=0;
  level = 1;
  score = 0;
  player = new Player();
  bulletmanager = new BulletManager();
  player.damageable=true;
  enemymanager = new EnemyManager();
  explosionmanager = new ExplosionManager();
 // enemymanager.delete();
  //bulletmanager.delete();
  ui.bulletReset();
  //explosionmanager.delete();
}

void keyPressed(KeyEvent evt) {
  kbd.pressKey(evt.getKeyCode());
}

void keyReleased(KeyEvent evt) {
  kbd.releaseKey(evt.getKeyCode());
}

void mouseReleased() {
  if (mainmenu.isTouchingLG) {
    if (mainmenu.hsMode == mainmenu.LOCAL) {
      scoremanager.sortGlobalScores();
      mainmenu.hsMode = mainmenu.GLOBAL;
    } else {
      mainmenu.hsMode = mainmenu.LOCAL;
    }
  }

  if (music.isTouchingNext) {
    music.nextSong();
  }
}


boolean rectRect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {

  // test for collision
  if (x1+w1/2 >= x2-w2/2 && x1-w1/2 <= x2+w2/2 && y1+h1/2 >= y2-h2/2 && y1-h1/2 <= y2+h2/2) {
    return true;    // if a hit, return true
  } else {            // if not, return false
    return false;
  }
}

class Bullet
{

  float x, y; // pos
  float a; //speed
  float angle;
  float vx, vy ;
  float speed;
  boolean isFriendly, isAlive;
  int costume;
  Bullet(float x, float y, float speed, boolean isFriendly)
  {
    this.x = x;
    this.y = y;
    this.a = a;
    this.isFriendly = isFriendly;
    this.isAlive = isAlive;
    vx=0;
    vy=+speed;
  }

  Bullet(float x, float y, float angle, float speed, boolean isFriendly)
  {
    this.x = x;
    this.y = y;
    this.isFriendly = isFriendly;
    angle = map(angle, 0, 360, 0, TWO_PI);
    vy = -1*sin(angle)*speed;
    vx = -1*cos(angle)*speed;
  }

  void move()
  {
    if (isFriendly) {
      image(bulletmanager.bullet, x, y);
      costume = (costume+1) % 2;
    } else {
      image(bulletmanager.enemyBullet, x, y);
    }

    y-=vy;
    x+=vx;
  }
}

class BulletManager
{
  ArrayList<Bullet> bullets;
  PImage bullet;
  PImage enemyBullet;
  BulletManager()
  {
    bullets = new ArrayList<Bullet>();
    bullet = loadImage("bullet/bullet_1.png");
    enemyBullet = loadImage("bullet/downBullet.png");
  }

  void update()
  {
    for (int i = bullets.size ()-1; i>=0; i--) 
    {
      Bullet b = bullets.get(i);
      b.move();
      if (b.y<-50 || b.y>height+50 || b.x<-50 || b.x>width+50) bullets.remove(i);
      if (rectRect((int)b.x, (int)b.y, 3, 11, (int)player.x, (int) player.y, 11, 31) && player.damageable && !b.isFriendly) {
        lives--;
        player.damageable = false;
        player.x = width/2;
        player.y = height*2/3;
      }
      if (rectRect((int)b.x, (int)b.y, 3, 11, (int)player.x, (int)player.y, 75, 75) && !b.isFriendly && shield.inUse) {
        b.vy = 2;
        b.isFriendly = true;
      }
      for (int k = enemymanager.enemy.size ()-1; k>=0; k--) 
      {
        Enemy e = enemymanager.enemy.get(k);
        if (rectRect((int)b.x, (int)b.y, 3, 11, (int)e.x, (int) e.y, 43, 47) && b.isFriendly) {
          bullets.remove(i);
          explosionmanager.create(e.x, e.y);
          enemymanager.enemy.remove(k);
          score+=100;

          break;
        }
      }
      for (int j = enemymanager.enemyflappybird.size ()-1; j>=0; j--) 
      {
        EnemyFlappybird f = enemymanager.enemyflappybird.get(j);
        if (rectRect((int)b.x, (int)b.y, 3, 11, (int)f.x, (int) f.y, 32, 24) && b.isFriendly) {
          bullets.remove(i);
          explosionmanager.create(f.x, f.y);
          enemymanager.enemyflappybird.remove(j);

          score+=100;

          break;
        }
      }
    }
  }
  void addB(Bullet b)
  {
    bullets.add(b);
  }

  void delete() {
    for (int i = bullets.size ()-1; i>=0; i--) 
    {
      Bullet b = bullets.get(i);
      bullets.remove(b);
    }
  }
}

class Enemy 
{

  int costume;
  float x, y;
  float v;
  Enemy() {
    x = random(50, width-50);
    y = -50;
    v =2;
  }

  void move()
  {
    if (frameCount%50+(int)random(-5, 5)==0 && y>0) {
      Bullet b = new Bullet(x, y, -9, false);
      bulletmanager.addB(b);
    }
    y+=v;
  }
  void show()
  {

    fill(250, 50, 12);
    image(enemymanager.enemyss, x, y);
  }
}

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

class EnemyManager
{

  ArrayList<EnemyFlappybird> enemyflappybird;
  ArrayList<Enemy> enemy;
  PImage[] flappybirdPI;
  PImage enemyss;
  float dif;  //Difficulty 
  EnemyManager()
  {
    enemyflappybird = new ArrayList<EnemyFlappybird>();
    enemy = new ArrayList<Enemy>();

    flappybirdPI = new PImage[2];
    flappybirdPI[0] = loadImage("flappyBird/flappybird_1.png");
    flappybirdPI[1] = loadImage("flappyBird/flappybird_2.png");

    enemyss = loadImage("enemyss/enemyss.png");
    dif=40;
  }


  void create()
  {
    if (frameCount%(int)dif==0) {
      if ((level+1)%2==0 || (level+1)%5==0) {
        Enemy e = new Enemy();
        enemy.add(e);
        if (dif>20)dif-=0.1;
      }
    }
    if (frameCount%(int)dif==0) {
      if ((level+1)%3==0 || (level+1)%5==0) {
        EnemyFlappybird f = new EnemyFlappybird();
        enemyflappybird.add(f);
        if (dif>20)dif-=0.1;
      }
    }
  }

  void draw()
  {
    for (int i = enemyflappybird.size ()-1; i>=0; i--)
    {
      EnemyFlappybird f = enemyflappybird.get(i);
      if (shield.inUse && dist(f.x, f.y, player.x,player.y)<60) {
      } else{
        f.move();
      }
      f.show();
      if (rectRect((int)f.x, (int)f.y, 34, 24, (int)player.x, (int)player.y, 36, 41) && player.damageable) {
        lives--;
        player.damageable = false;
        player.x = width/2;
        player.y = height*2/3;
      }
    }
    for (int i = enemy.size ()-1; i>=0; i--)
    {
      Enemy e = enemy.get(i);
      e.move();
      e.show();
    }
  }

  void delete()
  {
    for (int i = enemyflappybird.size ()-1; i>=0; i--)
    {
      EnemyFlappybird f = enemyflappybird.get(i);
      enemyflappybird.remove(f);
    }

    for (int i =  enemy.size ()-1; i>=0; i--)
    {
      Enemy e = enemy.get(i);
      enemy.remove(e);
    }
  }
}

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
    }
  }


  void create(float _x, float _y) {
    float x = _x;
    float y = _y;
    Explosion e = new Explosion(x, y);
    explosions.add(e);
  }

  void display() {

    for (int i = 0; i<explosions.size (); i++) {
      Explosion e = explosions.get(i);

      if (e.costume>78) explosions.remove(i);
      e.display();
    }
  }

  void delete() {
    for (int i = 0; i<explosions.size (); i++) {
      Explosion e = explosions.get(i);
      explosions.remove(e);
    }
  }
}

/* Example Code for Platformer
 * By Chris DeLeon
 * 
 * For more free resources about hobby videogame development, check out:
 * http://www.hobbygamedev.com/
 * 
 * Project compiles in Processing - see Processing.org for more information!
 */

import java.awt.event.KeyEvent;

class Keyboard {
  // used to track keyboard input
  Boolean holdingUp, holdingDown, holdingRight, holdingLeft, holdingSpace, holdingShift, holdingA, holdingS, holdingP, holdingK;

  Keyboard() {
    holdingUp=holdingDown=holdingRight=holdingLeft=holdingSpace=holdingShift=holdingA=holdingS=holdingP=false;
  }

  /* The way that Processing, and many programming languages/environments, deals with keys is
   * treating them like events (something can happen the moment it goes down, or when it goes up).
   * Because we want to treat them like buttons - checking "is it held down right now?" - we need to
   * use those pressed and released events to update some true/false values that we can check elsewhere.
   */

  void pressKey(int key) {
    if (key == KeyEvent.VK_UP) {
      holdingUp = true;
    }
    if (key == KeyEvent.VK_K) {
      holdingK = true;
    }
    if (key == KeyEvent.VK_DOWN) {
      holdingDown = true;
    }
    if (key == KeyEvent.VK_LEFT) {
      holdingLeft = true;
    }
    if (key == KeyEvent.VK_RIGHT) {
      holdingRight = true;
    }
    if (key == KeyEvent.VK_SPACE) {
      if (shield.inUse) {
        shield.inUse = false;
      } else {
        shield.inUse = true;
      }
    }

    if (key == KeyEvent.VK_SHIFT) {
      holdingShift = true;
    }

    if (key == KeyEvent.VK_A) {
      holdingA = true;
    }
    if (key == KeyEvent.VK_S) {
      holdingS = true;
    }
    if (key == KeyEvent.VK_P) {
      holdingP = true;
    }
  }
  void releaseKey(int key) {
    if (key == KeyEvent.VK_UP) {
      holdingUp = false;
    }
    if (key == KeyEvent.VK_DOWN) {
      holdingDown = false;
    }
    if (key == KeyEvent.VK_LEFT) {
      holdingLeft = false;
    }
    if (key == KeyEvent.VK_RIGHT) {
      holdingRight = false;
    }
    if (key == KeyEvent.VK_SPACE) {
      holdingSpace = false;
    }
    if (key == KeyEvent.VK_SHIFT) {
      holdingShift = false;
    }
    if (key == KeyEvent.VK_A) {
      holdingA = false;
    }
    if (key == KeyEvent.VK_S) {
      holdingS = false;
    }
    if (key == KeyEvent.VK_P) {
      holdingP = false;
    }
    if (key == KeyEvent.VK_K) {
      holdingK = false;
    }
  }
}

class MainMenu
{
  int subMode;
  final int MAIN = 0;
  final int HIGHSCORE = 1;

  int hsMode;
  final int LOCAL = 0;
  final int GLOBAL = 1;


  boolean isTouchingLG;
  MainMenu() {
    mode = MAINMENU;
    hsMode = LOCAL;
  }

  void display() {

    fill(0, 0, 0, 150);
    rect(0, 0, width, height); //Fades out starfield for main menu.

    if (subMode == MAIN) {
      playButton();
      highscoreButton();
    } else if (subMode == HIGHSCORE)
    {
      backButton();
      highscores();
    }
  }

  void playButton() {


    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>255 && mouseX<545 && mouseY>height/3 && mouseY<height/3+70) {
      stroke(102, 111, 242);
      if (mousePressed) {
        gameReset();
        mode = PLAYING;
      }
    }
    fill(0, 0, 0, 150);
    rect(width/2-(width/6)-15, height/3, width/2.7, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Play", width/2-50, height/3+50);
  }

  void highscoreButton() {
    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>270 && mouseX<530 && mouseY>300 && mouseY<370) {
      stroke(102, 111, 242);
      if (mousePressed) {
        //Show Highscore
        subMode = HIGHSCORE;
        hsMode = LOCAL;
      }
    }
    fill(0, 0, 0, 150);
    rect(width/2-(width/6), height/3+100, width/3, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Highscores", width/2-110, height/3+150);
  }


  void highscores() {
    if (hsMode==LOCAL)localScores();
    if (hsMode==GLOBAL)globalScores();
  }

  void localScores() {
    textSize(24);
    textFont(font36);
    if (mouseX>340 && mouseX<460 && mouseY>65 && mouseY<100) { 
      fill(102, 111, 242); 
      isTouchingLG = true;
    } else {
      isTouchingLG = false;
    }
    text("Local", width/2-40, 95);
    textSize(48);
    textFont(font48);
    fill(255);
    text("High Scores", width/2-110, 60);

    int y = 140;
    int n = 1;
    textSize(28);
    scoremanager.sortLocalScores();
    for (int i = scoremanager.sortedLocalScores.length-1; i>scoremanager.sortedLocalScores.length-8; i--) {
      int s = scoremanager.sortedLocalScores[i];
      println("Score: " + score + "S: " + s);
      if (s==score) {
        fill(10, 255, 10);
      } else{
        fill(255);
      }
      text(n +". " + s, width/2-105, y);
      y+=48;
      n++;
    }
  }

  void globalScores() {
    textSize(36);
    textFont(font36);
    if (mouseX>340 && mouseX<460 && mouseY>65 && mouseY<100) { 
      fill(102, 111, 242); 
      isTouchingLG = true;
    } else {
      isTouchingLG = false;
    }
    text("Global", width/2-40, 95);
    textSize(48);
    textFont(font48);
    fill(255);
    text("High Scores", width/2-110, 60);
    int y = 140;

    if (scoremanager.sortedGlobalScores==null) {      //If server isnt avalible.
      textSize(28);
      text( "No Connection", width/2-110, 140);
      y+=48;
      for (int i = 6; i>0; i--) {
        text( ". Loading", width/2-105, y);
        y+=48;
      }
    } else {
      y = 140;
      int n = 1;
      textSize(28);
      //
      for (int i = 0; i<7; i++) {
        int s = scoremanager.sortedGlobalScores[i];
        if (s==score) {
          fill(10, 255, 10);
        } else {
          fill(255);
        }
        text(n +". " + s, width/2-105, y);
        y+=48;
        n++;
      }
    }


    //    int y = 140;
    //    int n = 1;
    //    scoremanager.sortLocalScores();
    //    for (int i = scoremanager.sortedLocalScores.length-1; i>scoremanager.sortedLocalScores.length-8; i--) {
    //      int s = scoremanager.sortedLocalScores[i];
    //      text(n +". " + s, width/2-105, y);
    //      y+=48;
    //      n++;
    //    }
  }

  void backButton() {
    strokeWeight(3);
    stroke(112, 148, 186);
    if (mouseX>320 && mouseX<475 && mouseY>460 && mouseY<530) {
      stroke(102, 111, 242);
      if (mousePressed) {
        subMode = MAIN;
      }
    }
    fill(0, 0, 0, 150);
    rect(width/2-width/10, height-140, width/5, 70);
    fill(255);
    textSize(48);
    textFont(font48);
    text("Back", width/2-55, height-90);
  }
}

class Music
{
  ArrayList<String> previousSongs;
  boolean isTouchingNext;
  PImage[] nextBtn;
  int nBtnCost;
  Music() {
    
    nextBtn = new PImage[2];
    nextBtn[0] = loadImage("ui/nextSong_0.png");
    nextBtn[1] = loadImage("ui/nextSong_2.png");
    

    // http://soundcloud.com/you/apps for APP_CLIENT_ID and APP_CLIENT_SECRET
    soundcloud = new SoundCloud("b621b2881156bfed30a37cca386e12ea", "64492c3dca2d0ef2f86de9346c0b89b1");

    soundcloud.login("notabotanon", "password");
    previousSongs = new ArrayList<String>();
    // show user details
    User me = soundcloud.get("me");
  }

  void nextButton() {
    image(nextBtn[nBtnCost], width-40, 15);
    if (mouseY<45 && mouseX>width-60) {
      nBtnCost = 1;
      isTouchingNext = true;
    } else {
      nBtnCost = 0;
      isTouchingNext = false;
    }
  }

  void playSong() {
    nextButton();
    if (!musicPlayer.isPlaying()) chooseSong();
  }
  void nextSong() {
    musicPlayer.close();
    if (mode!=PAUSED)chooseSong();
  }

  void chooseSong() {
    String randString = "";
    for (int i = 0; i < 2; i++)
    {
      char c = (char) int(random(97, 122));
      randString += c+"";
    }

    ArrayList<Track> result = soundcloud.findTrack("edm" + " " + randString);
    if (result!=null && result.size()>3) {
      println("Tracks: "+result.size());

      minim = new Minim(this);
      musicPlayer = minim.loadFile(result.get(0).getStreamUrl());
      meta = musicPlayer.getMetaData();
      String song = meta.fileName();
      String ss = song.substring(27, 47);
      println("File name:" + ss);

      for (int i = 0; i<previousSongs.size (); i++) {
        String p = previousSongs.get(i);
        if (ss .equals(p)) {
          println("Same song, repicking ");
          chooseSong();
        }
      }

      previousSongs.add(ss);
      musicPlayer.play();
    } else {
      println("Not enough songs; retrying.");
      chooseSong();
    }
  }
}

class Player
{

  float x, y, vx, vy, a;
  PImage[] spaceship;
  int costume;
  boolean damageable;
  int safeTimer;
  Player() {
    kbd = new Keyboard();
    damageable = true;
    spaceship = new PImage[12];
    for (int i = 0; i<12; i++) {
      String filename = "spaceship/spaceship_" + nf(i+1, 2) + ".png";
      spaceship[i] = loadImage(filename);
    }
    x = width/2;
    y = height*2/3;
    vx = 0;
    vy = 0;
    a = 0.5;
    costume = 6;
  }

  void update()
  {
    image(spaceship[costume-1], x, y);

    x+=vx;
    y+=vy;

    vx*=0.96;
    vy*=0.96;

    controls();
    calculations();
  }

  void controls() {

    //if(kbd.holdingK) lives = -1;

    if (kbd.holdingRight )
    {
      vx=vx+a;
      if (costume<11 && frameCount%2==0)costume++;
    } else {
      if (vx>=0)vx=vx-a;
      if (costume>6 && frameCount%2==0) costume--;
    }

    if (kbd.holdingLeft && x>40)
    {
      if (costume>1 && frameCount%2==0) costume--;
      vx=vx-a;
    } else {
      if (costume<6 && frameCount%2==0) costume++;
      if (vx>=0)vx=vx+a;
    }

    if (kbd.holdingUp && y>0-20)
    {
      vy=vy-a;
    } else {
      if (vy>=0)vy=vy+a;
    }

    if (kbd.holdingDown && y<height+20)
    {
      vy=vy+a;
    } else {
      if (vy>=0)vy=vy-a;
    }



    if (kbd.holdingShift)
    {
      if (frameCount%22==0)
      {

        Bullet b = new Bullet(x-15, y, 10, true);
        bulletmanager.addB(b);

        Bullet b2 = new Bullet(x+12, y, 10, true);
        bulletmanager.addB(b2);
      }
    }
    if (kbd.holdingA && frameCount%20==0 && ui.rnbBCount>0) {
      for (int i = 180; i<360; i+=10) {
        Bullet b = new Bullet(x, y, i, 10, true);
        bulletmanager.addB(b);
      }
      ui.rnbBCount--;
    }

    if (kbd.holdingSpace) {
    }

    if (kbd.holdingS) {

      if (frameCount%5==0 && ui.sBCount>0) {

        Bullet b = new Bullet(x, y, 12, true);
        bulletmanager.addB(b);
        ui.sBCount--;
      }
    }
  }
  void calculations() {

    if (lives<0) {
      mode = MAINMENU;
      mainmenu.subMode = mainmenu.HIGHSCORE;
      mainmenu.hsMode = mainmenu.LOCAL;
      scoremanager.writeToServer();
      scoremanager.saveScore();
    }
    if (!damageable) {
      safeTimer++;
      if (safeTimer%5==0) {
        if (!shield.inUse)image(spaceship[11], x, y);
      }
      if (safeTimer>60*2) {
        safeTimer = 0;
        damageable = true;
      }
    }
  }
}

class SFX {

  AudioPlayer laser;
  AudioPlayer explosion;
  SFX() {
    laser = minim.loadFile("sfx/laser.mp3");
    explosion = minim.loadFile("sfx/explosion.mp3");
  }

  void playLaser() {
   laser.play();
  }
}

class ScoreManager
{


  String outFilename = "scores/scores.txt";
  int[] sortedLocalScores;
  int[] sortedGlobalScores;
  ScoreManager()
  {
  }


  void saveScore() {
    if (score>0) {
      appendTextToFile(outFilename, str(score));
      sortLocalScores();
      //score = 0;
    }
  }

  void writeToServer() {
    println("Sent:" + score);
    String sc = "" + score;
    c.write(sc);
  }

  void sortLocalScores() {
    String scoreList[] = loadStrings("scores/scores.txt");

    sortedLocalScores = new int[scoreList.length];
    for (int i = 0; i < scoreList.length; i++) {
      sortedLocalScores[i] = Integer.parseInt(scoreList[i]);
    }
    sortedLocalScores = sort(sortedLocalScores);
  }

  void sortGlobalScores() {

    c.write("scorerequest");
    delay(120);
    if (c.available() > 0) {
      //println("second");
      String input = c.readString();
      //input = input.substring(0, input.indexOf("\n")); // Only up to the newline
      sortedGlobalScores = int(split(input, ' ')); // Split values into an array
    }
  }




  void appendTextToFile(String filename, String text) {
    File f = new File(dataPath(filename));
    if (!f.exists()) {
      createFile(f);
    }
    try {
      PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
      out.println(text);
      out.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  /**
   * Creates a new file including all subfolders
   */
  void createFile(File f) {
    File parentDir = f.getParentFile();
    try {
      parentDir.mkdirs(); 
      f.createNewFile();
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }
}

class Shield
{
  float x, y;
  boolean inUse;
  Shield()
  {
    x = player.x;
    y = player.y;
  }

  void update()
  {
    if(ui.shieldTimer<0) inUse = false;
    if (inUse && ui.shieldTimer>0) {
      player.damageable = false;
      move();
      show();
      ui.shieldTimer--;
    } else {
      inUse = false;
    }
  }

  void show()
  {
    noFill();
    stroke(0, 200, 255);
    ellipse(x, y, 75, 75);
  }

  void move()
  {
    x = player.x;
    y = player.y;
  }
}

class Star
{
  float x, y; //pos
  float speed;
  
  Star()
  {
    x = random(width);
    y = random(height);
    speed = random(2, 8);
  }

  void move()
  {
    fill(255);
    rect(x, y, speed/2, speed/2);

    y+=speed;
    if (y>height+speed) y = -1*speed;
    
    
  }


}

class Starfield
{
  Star[] stars;
  int n;
  Starfield(int _n) {
    n = _n;
    stars = new Star[n];
    for (int i = 0; i<n; i++)
    {
      stars[i] = new Star();
    }
  } 
  void show()
  {
    fill(0, 255);
    rect(0, 0, width, height);
    for (int i = 0; i<n; i++)
    {
      stars[i].move();
    }
  }

}

class UI
{
  int sBCount;
  int rnbBCount;
  float shieldTimer;
  UI()
  {
    sBCount = 65;
    rnbBCount = 5;
    shieldTimer = 250;
    paused = false;
  }

  void display() {
    noStroke();
    fill(255);


    textSize(14);
    textFont(font14);
    image(bulletmanager.bullet, 8, 12);    //Display singlebullet count;
    text(sBCount, 15, 15);

    image(bulletmanager.bullet, 8, 30);
    image(bulletmanager.bullet, 12, 30);   //Double bullet count
    text( "∞", 15, 30);

    image(bulletmanager.bullet, 8, 45);
    image(bulletmanager.bullet, 12, 45);  //Rainbow bullet count; 
    image(bulletmanager.bullet, 16, 45);
    text(rnbBCount, 20, 45);

    noFill();
    stroke(0, 200, 255);      //Shield level;
    strokeWeight(2);
    ellipse(12, 63, 10, 10);
    float w = map(shieldTimer, 0, 250, 0, 50);
    noStroke();
    fill(0, 200, 255);
    rect(20, 57, w, 10);
    textFont(font36);
    textSize(36);
    fill(255);
    text(score, width-100, 50);



    for (int i = 0; i<lives; i++) {
      pushMatrix();
      scale(0.8, 0.8);
      noStroke();
      image(player.spaceship[5], 30+i*40, height+100);
      popMatrix();
    }

    calculations();
  }

  void calculations() {
    if (score%3000==0 && score>0) {
      sBCount+=20;
      rnbBCount+=3;
      score+=100;
    }
    if (score%6100==0 && score>0) {
      shieldTimer = 250;
      score+=100;
    }


    if (score%20000==0 && lives < 3 && score>0) {
      lives++;
      score+=100;
    }
    scoremanager.sortLocalScores();
    if (score>scoremanager.sortedLocalScores[scoremanager.sortedLocalScores.length-1]) {
      fill(102, 111, 242);
      textFont(font36);
      textSize(24);
      text("High Score!", width/2-100, 24);
    }

    if (kbd.holdingP) {
      if (mode!=PAUSED) {
        textFont(font36);
        textSize(36);
        text("PAUSED", width/2-100, height/2);
        mode = PAUSED;
        //musicPlayer.pause();
        delay(180);
      } else {
        mode = PLAYING;
        //musicPlayer.play();
        delay(180);
      }
    }
  }
  void bulletReset() {
    sBCount = 65;
    rnbBCount = 15;
    shieldTimer = 250;
  }
}


