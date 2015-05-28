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
      score = 0;
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
    if (c.available() > 0) {
      String input = c.readString();
        //BLAH
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
