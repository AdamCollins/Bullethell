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

