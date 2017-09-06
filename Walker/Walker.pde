DotWalker walker = new DotWalker(new PVector(random(0, 800), random(0, 600)));

void setup() {
  size(800, 600);
}

class DotWalker {
  DotWalker(PVector position) {
    this.position = position; 
    this.movement = new PVector(random(-1, 1), random(-1, 1));
  }

  PVector position;
  PVector movement; 

  void update() {
    position.add(movement);
    this.movement.x = randomGaussian();
    this.movement.y = randomGaussian();
  }

  PVector get() {
    return position;
  }
}




void draw() {
  PVector pos = walker.get();
  fill(0);
  rect(pos.x, pos.y,4,4);
  walker.update();
}