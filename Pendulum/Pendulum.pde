PVector gravity = new PVector(0, 9.81); //<>//
float drag_coefficient = 0.5f;
float air_density = 0.5f; // Drag coefficient
float friction_coefficient = 0.1f;

class PhysicalObject {
  PVector location = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  float mass = 0.0f;

  PhysicalObject(float x, float y, float mass) {
    this.location.x = x;
    this.location.y = y;
    this.mass = mass;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  public PVector getLocation() {
    return this.location;
  }
}

class Ball extends PhysicalObject {

  Ball(float x, float y, float mass) {
    super(x, y, mass);
    this.velocity.x = 4;
  }

  void update() {
    applyAirFriction();
    applyFriction();
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    checkEdges();
  }

  void display() {
    fill(255);
    ellipse(location.x, location.y, mass, mass);
  }

  void applyFriction() {
    PVector friction = PVector.mult(velocity, -1);
    friction.normalize();
    friction.mult(friction_coefficient);
    applyForce(friction);
  }

  void applyAirFriction() {
    PVector drag = PVector.mult(acceleration, 0.5);
    drag.mult(drag_coefficient);
    drag.mult(drag_coefficient);
    drag.mult(air_density);
    drag.mult(velocity.mag() * velocity.mag());
    applyForce(drag);
  }

  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
}

class Point extends PhysicalObject {
  Point(float x, float y, float mass) {
    super(x, y, mass);
  }
}

class Rod extends Point {
  Point joint;
  float len;
  int c;

  Rod(Point joint, float x, float y, float mass, float len, int c) {
    super(x, y, mass);
    this.joint = joint;
    this.len = len;
    this.c = c;
  }

  float getFi() {
    PVector vect = PVector.sub(location, joint.getLocation());
    return PVector.angleBetween(gravity, vect);
  }

  void applyTorque() {
    float fi = getFi();
    float forceMag = - mass * gravity.mag() * sin(fi);
    
    PVector force = PVector.sub(location, joint.getLocation());
    PVector perpendicular = new PVector(force.y, -force.x);
    perpendicular.normalize();
    perpendicular.mult(forceMag);
    applyForce(perpendicular);
  }

  void fixLength() {
    PVector vect = PVector.sub(location, joint.getLocation());
    vect.normalize();
    vect.mult(len);
    location = PVector.add(joint.getLocation(), vect);
  }

  void update() {
    applyTorque();
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    fixLength();
  }

  void display() {
    stroke(c);
    strokeWeight(5);
    line(joint.getLocation().x, joint.getLocation().y, this.getLocation().x, this.getLocation().y);
  }
}

void setup() {
  size(1000, 1000);
  Rod firstRod = new Rod(
    start, 
    random(0, width), 
    random(0, height), 
    10,//random(1, 20), 
    random(1, 80), 
    int(random(100, 255)));
  list.add(firstRod);
  spawnRod(5);
}

//Ball ball = new Ball(400, 300, 15);
Point start = new Point(400, 200, 0);

ArrayList<Rod> list = new ArrayList();

void spawnRod() {
  Rod rod = new Rod(
    list.get(list.size()-1), 
    random(0, width), 
    random(0, height), 
    10,//random(1, 20), 
    random(1, 80), 
    int(random(100, 255)));

  list.add(rod);
}

void spawnRod(int a){
   while(a-- > 0){
      spawnRod(); 
   }
}

void draw() {
  background(255);
  start.getLocation().x = mouseX;
  start.getLocation().y = mouseY;

  for (Rod r : list) {
    r.update();
    r.applyForce(gravity);
    r.display();
  }

  //ball.applyForce(gravity);
  //ball.update();
  //ball.display();
}