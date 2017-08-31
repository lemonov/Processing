 //<>// //<>//
void setup() {
  size(1000, 1000);
  new EnemySpawner(1).start();
}

class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;

  PVector surge;

  int size;


  Ball(float x, float y, float vx, float vy, int size) {
    position = new PVector(x, y);
    velocity = new PVector(vx, vy);
    acceleration = new PVector(0, 0.5); // g
    surge = new PVector(-0.02, 0);
    this.size = size;
  }

  void update() {
    acceleration.add(surge);
    velocity.add(acceleration);
    position.add(velocity);
    fill(0);
    ellipse(position.x, position.y, size, size);
  }
}

class Canon {
  PVector position;
  PVector direction;
  int len;

  Canon(float x, float y, int len) {
    position = new PVector(x, y);
    direction = new PVector(mouseX, mouseY);
    this.len = len;
  }

  void update() {
    direction.x = mouseX;
    direction.y = mouseY;

    direction.sub(position);
    direction.normalize();
    direction.mult(this.len/2);
    translate(position.x, position.y);

    fill(0);
    strokeWeight(10);
    strokeCap(SQUARE);
    line(-direction.x, -direction.y, direction.x, direction.y);
    strokeWeight(1);
    translate(-position.x, -position.y);
  }
}

float normalize(float oldMin, float oldMax, float newMin, float newMax, float value) {
  return ((newMax-newMin)/(oldMax-oldMin))*(value - oldMax) + newMax;
}

float normalize0_1to10_100(float value) {
  return normalize(0, 1, 10, 100, value);
}


class Enemy {
  PVector position;
  PVector direction;  
  Enemy(float x, float y, float speed) {
    position = new PVector(x, y);
    direction = new PVector(-speed, 0);
  }

  void update() {
    fill(0);
    rect(position.x, position.y, 40, 20);
    position.add(direction);
  }
}

class EnemySpawner extends Thread {
  int seconds;
  EnemySpawner(int seconds) {
    this.seconds = seconds;
  }

  void run() {
    while (true) {
      delay(this.seconds * 1000);
      enemies.add(new Enemy(1000, normalize0_1to10_100(noise(enemies.size())), 3));
    }
  }
}

ArrayList<Enemy> enemies = new ArrayList();
ArrayList<Ball> balls = new ArrayList();

void mouseClicked() {
  balls.add(new Ball(canon.position.x, canon.position.y, canon.direction.x, canon.direction.y, 10));
}

Canon canon = new Canon(20, 1000, 70);

boolean isInBoundries(float x, float y) {
  if ((x > width) || (x < 0)) return false;
  if ((y > height) || (y < 0)) return false;

  return true;
}

void draw() {
  background(255);
  canon.update();

  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    if (isInBoundries(ball.position.x, ball.position.y)) {
      ball.update();
    }
  }

  for (int i = 0; i < enemies.size(); i++) {
    Enemy enemy = enemies.get(i);
    if (isInBoundries(enemy.position.x, enemy.position.y)) {
      enemy.update();
    }
  }
}