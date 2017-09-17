class Bob {
  PVector location; 
  float mass;
  float len;
  float angle;
  float dAngle = 0;
  float d2Angle = 0;
  float slow = 1;
  float cl = 0;

  Bob(float mass, float len, float startAngle) {
    this.mass = mass;
    this.len = len;
    this.angle = startAngle;
  }

  void update(float d2Angle, PVector pivot) {
    this.d2Angle = d2Angle;
    dAngle += d2Angle;
    angle += dAngle;
    angle *= slow;
    location = PVector.add(pivot, new PVector(len * sin(angle), len * cos(angle)));
  }

  void display() {
    fill(cl);
    ellipse(location.x, location.y, mass*10, mass*10);
  }
}

class DPendulum {
  float timeAroundUpperStability = 0.0; // ms
  float distanceToStability = 0.0; // ms
  float gravity = 0.4;
  float stabilityDistanceThreshold = 30;
  
  Bob bob1;
  Bob bob2;
  PVector pivot = new PVector(250, 250);
  PVector stabilityPoint; 
  
  DPendulum() {
    bob1 = new Bob(1, 120, PI);
    bob2 = new Bob(1, 120, PI*0.999);
    stabilityPoint = new PVector(pivot.x, pivot.y - bob1.len - bob2.len);
  }

  void update() {
    bob1.update(calcAngle1(), pivot);
    bob2.update(calcAngle2(), bob1.location);
    distanceToStability = PVector.dist(stabilityPoint, bob2.location);
    if(distanceToStability < stabilityDistanceThreshold){
       timeAroundUpperStability +=0.1; 
    }
  }

  void display() {
    stroke(0);
    fill(120);
    //line(pivot.x, pivot.y, bob1.location.x, bob1.location.y);
    //line(bob1.location.x, bob1.location.y, bob2.location.x, bob2.location.y);

    //bob1.display();
    bob2.display();
  }

  float calcAngle1() {
    float top = -1*gravity*(2*bob1.mass*bob2.mass)*sin(bob1.angle) - bob2.mass*gravity*sin(bob1.angle-(2*bob2.angle)) - 
      2*(sin(bob1.angle-bob2.angle)*bob2.mass*(bob2.dAngle*bob2.dAngle*bob1.len +bob1.dAngle*bob1.dAngle* bob1.len *cos(bob1.angle-bob2.angle)));
    float bot = bob1.len*(2*bob1.mass+bob2.mass-bob2.mass*cos(2*bob1.angle-2*bob2.angle));

    return top / bot;
  }

  float calcAngle2() {
    float top = 2*sin(bob1.angle-bob2.angle)*(bob1.dAngle*bob1.dAngle* bob1.len *(bob1.mass+bob2.mass)+ gravity *(bob1.mass + bob2.mass)*cos(bob1.angle)+bob2.dAngle*bob2.dAngle* bob2.len *bob2.mass*cos(bob1.angle-bob2.angle));
    float bot = bob2.len*(2*bob1.mass+bob2.mass-bob2.mass*cos(2*bob1.angle-2*bob2.angle));

    return top / bot;
  }
}

DPendulum pendulum = new DPendulum();

void setup() {
  size(500, 500);
  background(255);
}


void draw() {
  //background(255);
  frameRate(60);
  pendulum.update();
  pendulum.display();
  textSize(12);
  //text("timeAroundUpperStability " + pendulum.timeAroundUpperStability + " ms", 20, 20);
  //text("distanceToStability " + pendulum.distanceToStability + " px", 20, 40);
}