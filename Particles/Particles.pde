class Particle {
  PVector location, velocity, acceleration;
  float angle, angularVelocity, angularAcceleration;

  float lifespan;
  float mass;

  Particle(PVector l) {
    location = l.copy();
    acceleration = new PVector(0, 0);
    velocity = new PVector();
    lifespan = 255;
    mass = 1;
  }

  void applyForce(PVector f) {
    f.div(mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration); //<>//
    location.add(velocity);
    lifespan -= 1.0;
  }

  void run() {
    update();
  }

  boolean isDead() {
    return lifespan < 0.0;
  }
} //<>//

abstract class Repeller {
  PVector location;
  float r = 30;
  float strength = 200;

  Repeller(float x, float y) {
    location = new PVector(x, y);
  }

  abstract void onRepel(Particle p);

  PVector repel(Particle p) {
    if (PVector.dist(p.location, location) > r) return new PVector(0, 0);

    onRepel(p);

    PVector dir =
      PVector.sub(location, p.location);
    float d = dir.mag();
    d = constrain(d, 5, 100);
    dir.normalize();
    float force = -1 * strength/ (d * d);
    dir.mult(force);
    return dir;
  }
}

abstract class ParticleSystem {
  ArrayList<Particle> particles = new ArrayList();
  PVector emitter;

  ParticleSystem(PVector emLocation) {
    emitter = emLocation.copy();
  }
  abstract void initParticle(Particle p);
  abstract void applyUpdate(Particle p);
  abstract void display(Particle p);

  void applyRepeller(Repeller r) {
    for (Particle p : particles) {
      PVector force = r.repel(p);
      p.applyForce(force);
    }
  }

  void run() {  
    Particle particle = new Particle(emitter);
    initParticle(particle);
    particles.add(particle);
    for (int i = 0; i< particles.size(); i++) {
      Particle current = particles.get(i);
      if (current.isDead()) {
        particles.remove(i);
        i--;
      } else {
        applyUpdate(current);
        current.run();
        display(current);
      }
    }
  }
}

class Flame extends ParticleSystem {

  PImage texture;
  Flame(float x, float y, PImage image) {
    super(new PVector(x, y));
    texture = image;
  }

  void initParticle(Particle p) {
    p.lifespan = random(0, 200);
    p.mass = 20;
  }

  void applyWind(PVector from, Particle p) {
    PVector force = PVector.sub(p.location, from);
    force.normalize();
    force.mult(0.2);
    p.applyForce(force);
  }

  void display(Particle p) {
    imageMode(CENTER);
    tint(255, p.lifespan);
    image(texture, p.location.x, p.location.y);
  }

  void applyUpdate(Particle p) {
    p.velocity.x = random(-1, 1);
    p.velocity.y = random(-1, 1);
    p.applyForce(new PVector(0, -0.1));
    applyWind( new PVector(mouseX, mouseY), p);
    p.mass-=0.1;
  }
}

class Pot extends Repeller {
  Pot(float x, float y) {
    super(x, y);
  }

  float temperature = 0;

  void onRepel(Particle p) {
    temperature += 0.5;
  }

  void display() {
    temperature-=1;
    stroke(0, 0);
    fill(color(temperature, 0, 0));
    ellipse(location.x, location.y, r*2, r*2);
  }
}

Flame flame1, flame2, flame3;
Pot repeller = new Pot(250, 100);
PImage texture1;
PImage texture2;
PImage texture3;

void setup() {
  size(500, 500);
  background(0);
  texture1 = loadImage("fire.png");
  texture1.resize(30, 30);
  texture2 = loadImage("fire2.png");
  texture2.resize(30, 30);
  texture3 = loadImage("fire3.png");
  texture3.resize(30, 30);
  flame1  = new Flame(250, 250, texture1);
  flame2  = new Flame(240, 260, texture2);
  flame3  = new Flame(260, 260, texture3);
}

void draw() {
  background(0);
  //tint(30);
  blendMode(ADD);
  repeller.display();
  flame1.applyRepeller(repeller);
  flame1.run();
  flame2.applyRepeller(repeller);
  flame2.run();
  flame3.applyRepeller(repeller);
  flame3.run();
}