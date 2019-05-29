class Ball{
  int size;
  float x;
  float y;
  float g;
  float vy;
  float vx;
  int c;
  int c1;
  int c2;
  
  Ball(int value, float g) {
    size = value;
    x = (int)random(size/2,(float)width/3*2);
    y = 0 - size / 2;
    vy = 0;
    vx = 4;
    c = (int)random(0,255);
    c1 = (int)random(100,255);
    c2 = 255;
    this.g = g;
  }
  
  void update() {
    
    vy += g;
    y += vy;
    x += vx;
    if(y > height - size/2){
      vy *= -1;
    }
    if(x > width - size/2) {
      vx *= -1;
    }
    if(x < size/2) {
      vx *= -1;
    }
    if(y > height - size/2) {
      y = height - size /2;
    }
    if (size <= 0) bullet.remove(this);
  }
  
  void draw() {
    noStroke();
    colorMode(HSB);
    fill(c,c1,c2);
    if (size < 200)
      ellipse(x,y,size*2,size*2);
    else
      ellipse(x,y,400,400);
    stroke(255);
    fill(255);
    //text(size,x,y);
  }
}
