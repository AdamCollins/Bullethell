class ScoreManager
{


  String outFilename = "scores/scores.txt";
  ScoreManager()
  {
  }


  void saveScore() {
    if (score>0) {
      appendTextToFile(outFilename, str(score));

      score = 0;
    }
  }

  void readScores() {
    String scoreList[] = loadStrings("scores/scores.txt");
    int[] sortedScores;
    sortedScores = new int[scoreList.length];
    for (int i = 0; i < scoreList.length; i++) {
      //println(scoreList[i]);
      sortedScores[i] = Integer.parseInt(scoreList[i]);
    }
    sortedScores = sort(sortedScores);
    println("sorted");
    //println(sortedScores);

    for (int i = 0; i < scoreList.length; i++) {
      println(sortedScores[i]);
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

