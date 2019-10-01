class Bullet {
  
  float x;
  float y;
  float p;
  float vy;
  
  Bullet(int xPos, int Power) {
    // println("new bullet");
    x = xPos;
    p = Power;
    y = height - 20;
    vy = -30;
  }
  
  void update() {
    y += vy;
  }
  
  void draw() {
    if (y < -4)
    colorMode(RGB);
    fill(255);
    ellipse(x,y,8,8);
  }
}
