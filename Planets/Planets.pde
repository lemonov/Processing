 //<>//
class Planet {
  PVector position;    
  PVector velocity;
  PVector acceleration;
  float mass;
  int size;

  Planet(float x, float y, float vx, float vy, float mass, int size) {
    this.position = new PVector(x, y);
    this.velocity = new PVector(vx, vy);
    this.acceleration = new PVector(0, 0);
    this.mass = mass;
    this.size = size;
  }

  void update() {
    fill(255);
    ellipse(position.x, position.y, size, size);
    velocity.add(acceleration);
    position.add(velocity);
    keepOnScreen();
  }

  void attract(Planet other) {
    PVector thisTempPosition = new PVector(this.position.x, this.position.y);
    PVector otherTempPosition = new PVector(other.position.x, other.position.y);

    thisTempPosition.sub(otherTempPosition);
    float r = thisTempPosition.mag();
    float F = this.mass/(r*r);

    thisTempPosition.normalize();
    thisTempPosition.mult(F);
    other.acceleration.add(thisTempPosition);
  }

  void keepOnScreen() {
    if (position.x - size > width) position.x = 0 + size;
    if (position.y - size > height) position.y = 0 + size;
    if (position.x + size < 0) position.x = width - size;
    if (position.y + size < 0) position.y = height - size;
  }
}


ArrayList<Planet> planets = new ArrayList();

void setup() {
  size(1900, 1000);
  background(0);
  planets.add(new Planet(random(0, 1000), random(0, 1000), 0, 0, 1000, 40));
  planets.add(new Planet(random(0, 1000), random(0, 1000), random(-3, 3), random(-3, 3), 0.1, 4));
  planets.add(new Planet(random(0, 1000), random(0, 1000), random(-3, 3), random(-3, 3), 1.1, 8));
  planets.add(new Planet(random(0, 1000), random(0, 1000), random(-3, 3), random(-3, 3), 2.1, 10));
  planets.add(new Planet(random(0, 1000), random(0, 1000), random(-3, 3), random(-3, 3), 3.1, 12));

}



void draw() {
  for (int i = 0; i < planets.size(); i++) {
    Planet current = planets.get(i);
    for (int j = 0; j < planets.size(); j++) {
      Planet other = planets.get(j);
      if (!other.equals(current)) {
        current.attract(other);
      }
    }
    current.update();
  }
  delay(100);
}