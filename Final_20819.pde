import java.util.*;

int gameState = 0;
int x;
int y;
int genTime;
int ballSize;
int health = 50;
int power = 1;
int gameTime = 0;

String finalTime = "";

final float gravity = 0.7;

List<Ball> ball = new ArrayList<Ball>();
List<Bullet> bullet = new ArrayList<Bullet>();

boolean leftP = false;
boolean rightP = false;
boolean spaceP = false;


void setup() {
  size(1280,720,FX2D);
  background(0);
  x = width/2;
  y = height;
  ballSize = 50;
  health = 100;
  smooth(4);
}


void keyPressed() {
  if (gameState == 0 && (key == ENTER | key == RETURN)) {
    gameState+=1;
    genTime = millis();
    gameTime = millis();
  }
  if (gameState == 1) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        x -= 1;
        leftP = true;
      }
      if (keyCode == RIGHT) {
        x += 1;
        rightP = true;
      }
      if (keyCode == UP) {
        spaceP = true;
      }
    }
  } else if (gameState == 2) {
    if (key == CODED) {
      if (key == ENTER | key == RETURN) {
        gameState = 1;
        println("Back");
        x = width/2;
        y = height;
        ballSize = 50;
        health = 100;
      }
    }
  }
}

void keyReleased() {
  if (gameState == 1) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        x -= 1;
        leftP = false;
      }
      if (keyCode == RIGHT) {
        x += 1;
        rightP = false;
      }
      if (keyCode == UP) {
        spaceP = false;
      }
    }
  }
}

void draw() {
  background(0);
  if (gameState == 0) {
    stroke(255);
    textSize(130);
    text("POP",width/5*2,height/5*2);
    
    textSize(26);
    text("Press ENTER to play",width/5*2,height/3*2);
  } else if (gameState == 1) {
    //println(bullet.size());
    rectMode(CENTER);
    fill(255);
    noStroke();
    if (leftP) x -= 15;
    if (rightP) x += 15;
    if (x > width - 20) x = width - 20;
    if (x < 20) x = 20;
    
    if ((millis()/1000) - genTime/1000 > (int)random(2,4)) {
      ball.add(new Ball(ballSize,gravity));
      ballSize += 10;
      genTime = millis();
    }
    if (spaceP) bullet.add(new Bullet(x,power));
    for (Ball b : ball) {
      b.update();
      b.draw();
      if (dist(b.x,b.y,x,y) <= 20 + b.size) {
        health -= 1;
      }
    }
    for (Bullet b : bullet) {
      b.update();
      b.draw();
      for (Ball bb : ball) {
        if (dist(bb.x,bb.y,b.x,b.y) <= (bb.size)/2 + 4) {
          bb.size -= 1;
          bullet.remove(bb);
        }
        if (bb.size == 0) {
          health += 50;
          bb.size -= 1;
        }
      }
      if (b.y <= 0) ball.remove(b);
    }
    fill(255);
    ellipse(x,y,40,40);
    if (health <= 0) {
      gameState = 2;
      finalTime = str((millis()-gameTime)/1000);
    }
    fill(255);
    stroke(255);
    text("Health: "+health,40,40);
    text("Time  : "+str((millis()-gameTime)/1000),40,70);
  } else if (gameState == 2) {
    // println("gameState == 2");
    textSize(100);
    text("Game Over",width/2-250,height/2);
    text("Time   : "+finalTime,width/2-200,height/2+100);
  }
}
