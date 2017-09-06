void rotatePoint(PVector point, PVector pivot, float angle) {
  float s = sin(angle);
  float c = cos(angle);

  // translate point back to origin:
  point.x -= pivot.x;
  point.y -= pivot.y;

  // rotate point
  float xnew = point.x * c - point.y * s;
  float ynew = point.x * s + point.y * c;

  // translate point back:
  point.x = xnew + pivot.x;
  point.y = ynew + pivot.y;
}

void setup() {
  size(1000, 1000);  
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
  if (centrifugalForce.mag() <= constrain) {
    centrifugalForce.normalize();
    centrifugalForce.mult(force);
    point.add(centrifugalForce);
  }
}

void addSpringResistance(PVector point, PVector pivot, float force) {
  PVector forceVect = PVector.sub(point, pivot);
  if (forceVect.mag() > 0) {
    forceVect.normalize();
    forceVect.mult(-1);
    forceVect.mult(force);
    point.add(forceVect);
  }
}

float cForce = 0;
boolean isPressed = false;

void mousePressed() {
  isPressed = true;
}

void mouseReleased() {
  isPressed = false;
}


void draw() {
  background(255);
  drawPoint(mid);
  drawPoint(end);
  if (isPressed) {
    cForce+=0.1;
  } else {
    cForce = 0;
  }
  fill(color(255, 0, 0));
  line(mid.x, mid.y, end.x, end.y);
  rotatePoint(end, mid, 0.1);
  addCentrifugalForce(end, mid, cForce, 200);
  addSpringResistance(end, mid, 2);
}