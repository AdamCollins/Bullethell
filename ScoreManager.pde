class ScoreManager
{


  String outFilename = "scores/scores.txt";
  int[] sortedScores;
  
  ScoreManager()
  {
  }


  void saveScore() {
    if (score>0) {
      appendTextToFile(outFilename, str(score));
      sortScores();
      score = 0;
    }
  }
  
  void writeToServer(){
    println("Sent:" + score);
    String sc = "" + score;
      c.write(sc);
  }

  void sortScores() {
    String scoreList[] = loadStrings("scores/scores.txt");

    sortedScores = new int[scoreList.length];
    for (int i = 0; i < scoreList.length; i++) {
      sortedScores[i] = Integer.parseInt(scoreList[i]);
    }
    sortedScores = sort(sortedScores);
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

