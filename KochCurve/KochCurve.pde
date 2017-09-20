class Line { //<>// //<>// //<>// //<>// //<>//
  PVector start, end;
  Line(PVector start, PVector end) {
    this.start = start;
    this.end = end;
  }

  PVector kochA() {
    return start.copy();
  }

  PVector kochB() {
    PVector vect = PVector.sub(end, start);
    vect.div(3);
    vect.add(start);
    return vect;
  }

  PVector kochC() {
    PVector vect = PVector.sub(end, start);
    vect.div(3);
    PVector c = vect.copy();
    c.rotate(-radians(60));
    vect.add(start);
    vect.add(c);
    return vect;
  }

  PVector kochD() {
    PVector vect = PVector.sub(end, start);
    vect.mult(2/3.0);
    vect.add(start);
    return vect;
  }

  PVector kochE() {
    return end.copy();
  }

  PVector getDiff() {
    return PVector.sub(end, start);
  }

  PVector getDiffInv() {
    return PVector.sub(start, end);
  }

  void display() {
    line(start.x, start.y, end.x, end.y);
  }
}

class Curve {
  ArrayList<Line> lines = new ArrayList();

  Curve(Line initial) {
    lines.add(initial);
  }

  void next() {
    ArrayList next = new ArrayList<Line>();
    for (Line line : lines) {
      PVector a = line.kochA();
      PVector b = line.kochB();
      PVector c = line.kochC();
      PVector d = line.kochD();
      PVector e = line.kochE();
      next.add(new Line(a, b));
      next.add(new Line(b, c));
      next.add(new Line(c, d));
      next.add(new Line(d, e));
      line.display();
    }
    lines = next;
  }
}

PVector getThird(PVector p1, PVector p2){
    PVector p3 = PVector.sub(p2,p1);
    p3.rotate(radians(60));
    return p3.add(p2);
}

Line init = new Line(new PVector(0, 250), new PVector(500, 250));
Line initL = new Line(new PVector(0, 250), getThird(new PVector(0, 250), new PVector(500, 250)));
Line initR = new Line(new PVector(500, 250), getThird(new PVector(0, 250), new PVector(500, 250)));

Curve curve = new Curve(init);
Curve curveL = new Curve(initL);
Curve curveR = new Curve(initR);

void setup() {
  size(500, 500);
  background(0);
  stroke(255);
}

void mousePressed() {
  background(0);
  stroke(255);
  curve.next();
  curveL.next();
  curveR.next();

}

void draw() {
}