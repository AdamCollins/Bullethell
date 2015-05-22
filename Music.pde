class Music
{
  ArrayList<String> previousSongs;
  Music() {
    // http://soundcloud.com/you/apps for APP_CLIENT_ID and APP_CLIENT_SECRET
    soundcloud = new SoundCloud("b621b2881156bfed30a37cca386e12ea", "64492c3dca2d0ef2f86de9346c0b89b1");

    soundcloud.login("notabotanon", "password");
    previousSongs = new ArrayList<String>();
    // show user details
    User me = soundcloud.get("me");
  }

  void playSong() {
    if (!musicPlayer.isPlaying()) chooseSong();
  }
  void nextSong() {
    musicPlayer.close();
    chooseSong();
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

      for (int i = 0; i<previousSongs.size(); i++) {
        String p = previousSongs.get(i);
        if (ss .equals(p)) {
          println("Same song, repicking ");
          chooseSong();
        }
      }

      previousSongs.add(ss);
      musicPlayer.play();
    } 
    else {
      println("Not enough songs; retrying.");
      chooseSong();
    }
  }
}




