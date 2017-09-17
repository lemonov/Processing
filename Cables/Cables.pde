 //<>//

int cablesCount = 3;

// 2.3 * 9 + 1.5    2.45 // times 4
void setup() {
  size(2220, 245);
  background(255);

  cable = new Cable(color(255, 0, 0), new PVector(100, 240), new PVector(100, 230), l1);
  cable2 = new Cable(color(0, 255, 0), new PVector(400, 240), new PVector(400, 230), l2);
  cable3 = new Cable(color(0, 0, 255), new PVector(800, 240), new PVector(800, 230), l3);
}

class Cable {
  int stepLength = 10; // cm
  int cablesMaxLength = 11600; // cm

  ArrayList<PVector> steps;
  int mColor = 0;

  Cable(int mColor, PVector start, PVector direction, ArrayList<PVector> steps) {
    this.steps = steps;
    steps.add(start);
    steps.add(direction);
    this.mColor = mColor;
  }

  PVector pointForward(PVector prev, PVector current) {
    PVector next = PVector.sub(current, prev);
    next.add(current);
    return next;
  }

  PVector getNextRandom(PVector current) {

    ArrayList<PVector> neighbours = new ArrayList();
    neighbours.add(new PVector(current.x + stepLength, current.y));
    neighbours.add(new PVector(current.x - stepLength, current.y));
    neighbours.add(new PVector(current.x, current.y + stepLength));
    neighbours.add(new PVector(current.x, current.y - stepLength));

    for (int i = 0; i < neighbours.size() || neighbours.size() == 0; i++) {
      if (!isFree2Go(neighbours.get(i))) {
        neighbours.remove(i);
        i = 0;
      }
    }
    return neighbours.get(int(random(0, neighbours.size())));
  }

  boolean isFree2Go(PVector p) {
    if (p.x > width || p.x < 0 || p.y > height || p.y < 0) { //<>//
      return false;
    }

    for (PVector s : l1) {
      if (s.x == p.x && s.y == p.y) {
        return false;
      }
    }

    for (PVector s : l2) {
      if (s.x == p.x && s.y == p.y) {
        return false;
      }
    }

    for (PVector s : l3) {
      if (s.x == p.x && s.y == p.y) {
        return false;
      }
    }
    return true;
  }

  void step() {
    if (cablesMaxLength <= 0) {
      return;
    }
    PVector forward = pointForward(steps.get(steps.size()-2), steps.get(steps.size()-1));
    if (isFree2Go(forward)) {
      steps.add(forward);
    } else {
      steps.add(getNextRandom(steps.get(steps.size()-1)));
    }
    println(cablesMaxLength);
    cablesMaxLength -= stepLength;
  }

  void display() {
    strokeWeight(1);
    stroke(mColor);
    for (int i = 1; i < steps.size(); i++) {
      PVector prev = steps.get(i-1);
      PVector current = steps.get(i);
      fill(mColor);
      ellipse(current.x, current.y, 3,3);
      line(prev.x, prev.y, current.x, current.y);
    }
  }
}


ArrayList<PVector> l1 = new ArrayList<PVector>();
ArrayList<PVector> l2 = new ArrayList<PVector>();
ArrayList<PVector> l3 = new ArrayList<PVector>();

Cable cable;
Cable cable2;
Cable cable3;

void draw() {
  background(255);
  cable.step();
  cable.display();  
  cable2.step();
  cable2.display();
  cable3.step();
  cable3.display();
}