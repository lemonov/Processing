
void setup() {
  background(0);
  size(500, 500);
}

class Circle {
  float r = 0;
  float expansionSpeed = 1;
  PVector location;

  Circle(float x, float y) {
    location = new PVector(x, y);
  }

  void update() {
    r += expansionSpeed;
 
  }

  void display() {
    stroke(255);
    strokeWeight(2);
    fill(color(0,0,0,0));
    ellipse(location.x, location.y, r, r);
  }
}

ArrayList<Circle> circles = new ArrayList();

void mousePressed(){
   circles.add(new Circle(mouseX, mouseY)); 
}

void draw() {
  for(Circle c : circles){
     c.update();
     c.display();
  }
}