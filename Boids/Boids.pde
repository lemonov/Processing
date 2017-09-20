float rangeOfView = 30; //<>//

boolean isCohesionEnabled = true;
boolean isSeparationEnabled = true;
boolean isAlignmentEnabled = true;

void keyPressed() {
  println("Pressed "+keyCode);
  switch(keyCode) {
  case 67: //c
    isCohesionEnabled = !isCohesionEnabled;
    println("Cohesion "+isCohesionEnabled);
    break;
  case 83: //s
    isSeparationEnabled = !isSeparationEnabled;
    println("Separation "+isSeparationEnabled);
    break;
  case 65: //a
    isAlignmentEnabled = !isAlignmentEnabled;
    println("Alignment "+isAlignmentEnabled);
    break;
  }
}


class Boid {
  PVector location, velocity, acceleration;
  //float angle, angularVelocity, angularAcceleration;
  float allignmentCoeff = 0.1;
  float cohesionCoeff = 1;
  float separationCoeff = 0.1;
  float mass;
  float TOP_VELOCITY = 3;
  Boid(PVector l) {
    location = l.copy();
    acceleration = new PVector(0, 0);
    velocity = new PVector();
    mass = 1;
  }

  void applyForce(PVector f) {
    f.div(mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(TOP_VELOCITY);
    location.add(velocity);
    acceleration.set(0, 0);
    borders();
  }

  void borders() {
    if (location.x < 0) location.x = width;
    if (location.y < 0) location.y = height;
    if (location.x > width) location.x = 0;
    if (location.y > height) location.y = 0;
  }

  void display() {
    fill(120);
    PVector dir = velocity.copy();
    dir.normalize();
    dir.mult(10);
    PVector left = new PVector(-dir.y, dir.x);
    left.normalize();
    left.mult(3);
    PVector right = new PVector(dir.y, -dir.x);
    right.normalize();
    right.mult(3);

    dir.add(location);
    left.add(location);
    right.add(location);

    triangle(dir.x, dir.y, left.x, left.y, right.x, right.y);
  }

  void applyAllignment(ArrayList<Boid> neighbours) {
    for (Boid n : neighbours) {
      PVector force = n.velocity.copy();
      force.normalize();
      force.mult(allignmentCoeff);
      applyForce(force);
    }
  }

  void applyAllignment2(ArrayList<Boid> neighbours) {
    PVector sum = new PVector(0, 0);
    for (Boid n : neighbours) {
      sum.add(n.velocity);
    }
    sum.div(neighbours.size());
    sum.normalize();
    sum.mult(allignmentCoeff);
    applyForce(sum);
  }


  void applyCohesion(ArrayList<Boid> neighbours) {
    PVector attraction = new PVector(0, 0);
    for (Boid n : neighbours) {
      attraction.add(n.location);
    }
    attraction.sub(location);

    attraction.div(neighbours.size());
    attraction.normalize();
    attraction.mult(cohesionCoeff);
    applyForce(attraction);
  }


  void applySeparation(ArrayList<Boid> neighbours) {
    for (Boid n : neighbours) {
      PVector separation = PVector.sub(location, n.location);
      separation.normalize();
      separation.mult(separationCoeff);
      applyForce(separation);
    }
  }

  void run(ArrayList<Boid> neighbours) {
    //acceleration.x = random(-0.1, 0.1);
    //acceleration.y = random(-0.1, 0.1);

    if (isSeparationEnabled)applySeparation(neighbours);
    if (isAlignmentEnabled)applyAllignment2(neighbours);
    if (isCohesionEnabled)applyCohesion(neighbours);
    display();
    update();
  }
}

class Flock {

  ArrayList<Boid> boids = new ArrayList();

  void addBoid(PVector location) {
    boids.add(new Boid(location));
  }

  ArrayList<Boid> getBoidsInRange(float range, Boid b) {
    ArrayList<Boid> neighbours = new ArrayList();
    for (Boid n : boids) {
      if (PVector.dist(b.location, n.location) < range) {
        neighbours.add(n);
      }
    }
    return neighbours;
  }

  void run() {
    for (Boid b : boids) {
      b.run(getBoidsInRange(rangeOfView, b));
    }
  }
}

Flock flock;

void mousePressed() {
  flock.addBoid(new PVector(mouseX, mouseY));
}

void addBoids(int n) {
  for (int i = 0; i < n; i++) {
    flock.addBoid(new PVector(random(0, width), random(0, height)));
  }
}

void setup() {
  size(1000, 1000);
  background(0);
  flock = new Flock();
  addBoids(1200);
}

void draw() {
  background(0);
  flock.run();
  textSize(16);
  fill(color(255, 0, 0));
  text("Alignment: " + isAlignmentEnabled, 30, 30);
  text("Cohesion: " + isCohesionEnabled, 30, 50);
  text("Separation: " + isSeparationEnabled, 30, 70);
}