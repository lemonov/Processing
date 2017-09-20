 //<>//
void setup() {
  background(255);
  size(500, 500);
  getNext(A, B, C, 255);
}

void draw() {
  stroke(0);
}

PVector getMidPoint(PVector a, PVector b) {
  PVector mid = PVector.sub(b, a);
  mid.div(2);
  mid.add(a);
  return mid;
}


void getNext(PVector A, PVector B, PVector C, int col) {
  if (PVector.dist(A, B) > 2) { //<>//
    PVector mAB = getMidPoint(A, B);
    PVector mBC = getMidPoint(B, C);
    PVector mCA = getMidPoint(C, A);
    col = col == 255? 0: 255;
    fill(col);
    drawTriangle(A, B, C);

    getNext(A, mAB, mCA, col);
    getNext(B, mAB, mBC, col);
    getNext(C, mBC, mCA, col);
  }
}

void drawTriangle(PVector A, PVector B, PVector C) {
  triangle(A.x, A.y, B.x, B.y, C.x, C.y);
}

PVector getC(PVector A, PVector B) {
  PVector vec = PVector.sub(B, A);
  vec.rotate(radians(-60));
  vec.add(A);
  return vec;
}

PVector A = new PVector(10, 490);
PVector B = new PVector(490, 490);
PVector C = getC(A, B);