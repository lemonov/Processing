void rotatePoint(PVector point, PVector pivot, float angle) {
  float s = sin(angle);
  float c = cos(angle);

  // translate point back to origin:
  point.x -= pivot.x;
  point.y -= pivot.y;

  // rotate point
  float xnew = point.x * c - point.y * s;
  float ynew = point.x * s + point.y * c;
  PVector start = new PVector(point.x, point.y);
  PVector end = new PVector(point.x, point.y);
  // translate point back:
  point.x = xnew + pivot.x;
  point.y = ynew + pivot.y;
  PVector rot = new PVector(xnew, ynew);
  rot.mult(10);
  end.add(PVector.mult(rot, 10));
  stroke(color(0, 0, 255));
  arrow(start.x, start.y, end.x, end.y);
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
    PVector start = new PVector(point.x, point.y);
    PVector end = new PVector(point.x, point.y);
    end.add(PVector.mult(centrifugalForce, 10));
    point.add(centrifugalForce);
    stroke(color(255, 0, 0));
    arrow(start.x, start.y, end.x, end.y);
  }
}

void addSpringResistance(PVector point, PVector pivot, float elasticity) {
  PVector forceVect = PVector.sub(point, pivot);
  if (forceVect.mag() > 0) {
    float force = forceVect.mag()*elasticity;
    
    forceVect.normalize();
    forceVect.mult(-1);
    forceVect.mult(force);
    PVector start = new PVector(point.x, point.y);
    PVector end = new PVector(point.x, point.y);
    end.add(PVector.mult(forceVect, 10));
    point.add(forceVect);
    stroke(color(0, 255, 0));
    arrow(start.x, start.y, end.x, end.y);
  }
}

void arrow(float x1, float y1, float x2, float y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
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
  rotatePoint(end, mid, 0.001);
  addCentrifugalForce(end, mid, cForce, 200);
  addSpringResistance(end, mid, 0.1);
}