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

