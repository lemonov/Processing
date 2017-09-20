void setup() {
  size(640, 360);
}

float w = 640;
float h = 360;
float r = 200;

void draw() {
  background(255);
  drawCircle(w/2, h/2, r, 10, new PVector(w/2, h/2));

  delay(1000);
}

boolean isEnable = false;

void mousePressed(){
   isEnable = !isEnable; 
}

void drawCircle(float x, float y, float radius, float rotation, PVector parent) {
  stroke(0); 
  strokeWeight(1);
  line(parent.x, parent.y, x, y);

  if (isEnable) {
    stroke(color(255, 0, 0));
    noFill();
    ellipse(x, y, radius, radius);
  }

  PVector current = new PVector(x, y);
  if (radius > 30) {
    PVector node = new PVector((3*radius/4), 0);
    node.rotate(radians(rotation));
    node.add(new PVector(x, y));
    drawCircle(node.x, node.y, radius/2, rotation-15, current);
    drawCircle(node.x, node.y, radius/2, rotation-30, current);
    drawCircle(node.x, node.y, radius/2, rotation-45, current);
    drawCircle(node.x, node.y, radius/2, rotation-60, current);
  }
}