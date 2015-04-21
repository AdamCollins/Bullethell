class ScoreManager
{

  PrintWriter scoreWriters;
  ScoreManager()
  {
  }


  void saveScore() {
    if (score>0) {
      scoreWriters =  createWriter("data/scores/" + score + ".txt");
      scoreWriters.println(score);
      scoreWriters.flush();
      scoreWriters.close();
      score = 0;
    }
  }

  void getScores() {
    for(int i = 0; i<200*100; i+=100){
      
    }
  }
}

