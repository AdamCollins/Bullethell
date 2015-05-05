class SFX {

  AudioPlayer laser;
  SFX() {
    laser = minim.loadFile("sfx/laser.mp3");
  }

  void playLaser() {
   laser.play();
  }
}

