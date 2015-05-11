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

