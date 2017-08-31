

class Ball implements Runnable {

  int size = 20;

  Ball(PVector position, PVector movement) {
    this.position = position;
    this.movement = movement;
    Thread watcher = new Thread(this);
    watcher.start();
  }

  public void run() {
    while (true) {
      if (this.position.x >= (width - size/2) || this.position.x <= size/2) {
        this.movement.x = -this.movement.x;
      }
      if (this.position.y >= (width - size/2) || this.position.y <= size/2) {
        this.movement.y = -this.movement.y;
      }
    }
  }

  void update() {
    fill(255);
    ellipse(this.position.x, this.position.y, size, size);
    position.add(movement); 
    PVector mouse = new PVector(mouseX, mouseY);
    mouse.sub(position);
    mouse.normalize();
    mouse.mult(10);
    position.add(mouse);
  }

  PVector position;
  PVector movement;
}

ArrayList<Ball> balls = new ArrayList();

PVector randomVector() {
  int x = int(random(0, width));
  int y =int(random(0, height));
  return new PVector(x, y);
}

void spawnBall() {
  balls.add(new Ball(randomVector(), new PVector(1, 1)));
}

void setup() {
  size(800, 800);
  spawnBall();
  spawnBall();
  spawnBall();
  spawnBall();
  spawnBall();
  spawnBall();
  spawnBall();
}

void draw() {
  clear();
  for (Ball b : balls) {
    b.update();
  }
}