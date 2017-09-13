float gravity = 0.4; //<>//

class Pendulum {
  PVector pivot;


  PVector location = new PVector(0, 0);

  float r = 40;
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration = 0;
  float damping = 0.995;

  Pendulum(PVector pivot) { //<>//
    this.pivot = pivot;
    angle = PI/4;
    this.location = new PVector(r*sin(angle), r*cos(angle));
  }
 //<>//

  void update() {
    //velocity.add(acceleration);
    //location.add(velocity); //<>//

    aAcceleration = (-1 * gravity/r) * sin(angle);
    aVelocity += aAcceleration;
    angle += aVelocity;
    aVelocity *= damping;
  }

  void display() {
    location.set(r*sin(angle), r*cos(angle));
    location.add(pivot);
 //<>//
    stroke(0);
    line(pivot.x, pivot.y, location.x, location.y);
    fill(155);
    ellipse(location.x, location.y, 20, 20);
  }
}


void setup() {
  size(1000, 1000);
}

Pendulum p = new Pendulum(new PVector(500, 500));

void draw() {
  background(255);
  p.update();
  p.display();
  p.pivot.x = mouseX;
}