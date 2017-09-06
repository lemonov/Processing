public static final float G = 9.81; //<>//
public static final float TOP_SPEED = 5;
class Attractor {
  float mass;
  PVector location;
  
  Attractor(float mass) {
    location = new PVector(mouseX, mouseY);
    this.mass = mass;
  }
  
  void attract(Mover m) {
    PVector force = PVector.sub(this.location, m.location);
    float distance = force.mag();
    float M = (G * this.mass * m.mass) / (distance*distance);
    force.normalize();
    force.mult(M);
    m.applyForce(force);
  }
  
  void update() {
     location.x = mouseX;
     location.y = mouseY;  
  }

  void display() {
    stroke(0);
    fill(175, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}

class Mover {
  float mass;
  PVector location;
  PVector velocity = new PVector(0,0);
  PVector acceleration = new PVector(0,0);
  

  Mover(float mass, int x, int y) {
    location = new PVector(x,y);
    this.mass = mass;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update(){
      velocity.add(acceleration);
      velocity.limit(TOP_SPEED);
      location.add(velocity);
  }

  void display() {
    stroke(0);
    fill(175, 200);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}

void setup() {
  size(1900, 1000);
  background(0);
}

Attractor attractor = new Attractor(100);
Mover mover = new Mover(20, 300,200);
void draw() {
  background(0);
  attractor.update();
  attractor.display();
  attractor.attract(mover);
  mover.update();
  mover.display();
}