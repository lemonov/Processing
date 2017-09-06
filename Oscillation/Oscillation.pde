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
PVector end = new PVector(500, 510);

void drawPoint(PVector p) {
  fill(0);
  ellipse(p.x, p.y, 20, 20);
}

void addCentrifugalForce(PVector point, PVector pivot, float force) {
  PVector centrifugalForce = PVector.sub(point, pivot);
  centrifugalForce.normalize();
  centrifugalForce.mult(force);
  point.add(centrifugalForce);
}

void draw() {
  //background(255);
  drawPoint(mid);
  drawPoint(end);
  rotatePoint(end, mid, 0.1);
  addCentrifugalForce(end, mid, 1);
}