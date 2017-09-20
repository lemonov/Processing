void setup() {
  size(640, 360);
}

void draw() {
  background(255);
  drawCircle(width/2, height/2, 500);
}

void drawCircle(float x, float y, float r) {
  stroke(0);
  noFill();
  ellipse(x, y, r, r);
  if (r > 10) {
    r = r/2;
    drawCircle(x+r, y, r);
    drawCircle(x-r, y, r);
    drawCircle(x, y+r, r);
    drawCircle(x, y-r, r);

  }
}