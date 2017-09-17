void rotatePoint(PVector point, PVector pivot, float angle) {
  float s = sin(angle);
  float c = cos(angle);
  point.sub(pivot);
  PVector rot = new PVector(point.x * c - point.y * s, point.x * s + point.y * c);
  PVector transRot = PVector.add(pivot, rot);
  point.x = transRot.x;
  point.y = transRot.y;
}

float angle(PVector v1, PVector v2) {
  float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
  if (a < 0) a += TWO_PI;
  return a;
}

void setup() {
  //size(1000, 1000);
  fullScreen();
  background(255);
}

PVector mid = new PVector(500, 500);
PVector end = new PVector(500, 550);

void drawPoint(PVector p) {
  fill(0);
  ellipse(p.x, p.y, 20, 20);
}

void addCentrifugalForce(PVector point, PVector pivot, float force, float constrain) {
  PVector centrifugalForce = PVector.sub(point, pivot);
  centrifugalForce.normalize();
  centrifugalForce.mult(force);
  if (centrifugalForce.mag() <= constrain) {
    PVector end = new PVector(point.x, point.y);
    end.add(PVector.mult(centrifugalForce, 10));
    point.add(centrifugalForce);
  }
}

void addSpringResistance(PVector point, PVector pivot, float elasticity) {
  PVector forceVect = PVector.sub(point, pivot);
  if (forceVect.mag() > 0) {
    float force = forceVect.mag()*elasticity ;
    forceVect.normalize();
    forceVect.mult(-1);
    forceVect.mult(force);
    point.add(forceVect);
  }
}

PVector polar2Cartesian(float r, float theta) {
   return new PVector(r * cos(theta), r * sin(theta)); 
}

float cForce = 0;
boolean isPressed = false;

void mousePressed() {
  isPressed = true;
}

void mouseReleased() {
  isPressed = false;
}

float angle = 0;
float r = 0;

void draw() {
  
  translate(500,500);
  drawPoint(polar2Cartesian(100, angle));
  if(isPressed) {angle+=0.1; r++}
  
  //drawPoint(mid);
  //drawPoint(end);
  //if (isPressed) {
  //  cForce+=0.1;
  //} else {
  //  cForce = 0;
  //}
  //fill(color(255, 0, 0));
  //line(mid.x, mid.y, end.x, end.y);
  //rotatePoint(end, mid, radians(15));
  //addCentrifugalForce(end, mid, cForce, 10);
  //addSpringResistance(end, mid, 0.01);
}