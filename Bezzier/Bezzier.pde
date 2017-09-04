void setup() { //<>// //<>// //<>// //<>//
  size(1000, 1000);  
  background(255);
}


ArrayList<PVector> points = new ArrayList();

// n - degree
float bern(float t, int i, int n) { // bernstein polynominal
  float result = 0;
  if (i == 0 && n == 0) return 1;
  if (i < 0) return 0;
  if (i > n) return 0;

  result = (1-t) * bern(t, i, n-1);
  result+=t*(bern(t, i-1, n-1));
  return result;
}

void control(ArrayList<PVector> points) {
  float x = 0, y = 0;
  float px = 0, py = 0;
  for (int i = 0; i < points.size(); i++) {
    x = ((PVector)points.get(i)).x;
    y = ((PVector)points.get(i)).y;
    ellipse(x, y, 8, 8);
    if (i != 0) {
      line(px, py, x, y);
    }
    px = x;
    py = y;
  }
}

ArrayList<PVector> bezier(ArrayList<PVector> points, float step) {

  if (points.size() == 0) return new ArrayList<PVector>();

  int n = points.size()-1;
  float x = 0, y = 0;
  float px = ((PVector)points.get(0)).x, py = ((PVector)points.get(0)).y;
  ArrayList<PVector> result = new ArrayList();

  for (float t = 0; t <= 1; t+= step) {
    for (int i = 0; i <= n; i++) {
      x += ((PVector)points.get(i)).x * bern(t, i, n);
      y += ((PVector)points.get(i)).y * bern(t, i, n);
    }
    line(px, py, x, y);
    px = x;
    py = y;
    result.add(new PVector(x, y));
    x = 0;
    y = 0;
  }
  return result;
}

boolean isControlEnabled = true;

void keyPressed() {
  print(keyCode);
  if (keyCode == 67) {
    isControlEnabled = !isControlEnabled;
  }
}

boolean locked = false;

PVector mouseStart = new PVector();
PVector mouseEnd = new PVector();

PVector draggedPoint;

PVector getClosestPoint(PVector mouse) {
  PVector closest = null;
  float dist = Float.MAX_VALUE;
  for (PVector p : points) {
    float currentDist = PVector.dist(p, mouse);
    if (currentDist < dist) {
      closest = p;
      dist = currentDist;
    }
  }
  return closest;
}

void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2) { // double click
    points.add(new PVector(mouseX, mouseY));
  }
  if (evt.getCount() == 1) {
    locked = true;
    mouseStart.x = mouseX;
    mouseStart.y = mouseY;
    if (points.size() != 0) {
      draggedPoint = getClosestPoint(mouseStart);
    }
  }
}

void mouseDragged() {
  if (locked) {
    draggedPoint.x = mouseX;
    draggedPoint.y = mouseY;
  }
}

void mouseReleased() {
  locked = false;
}

PVector getClosestToList(PVector point, ArrayList<PVector> list) {
  if (list.size() == 0) return point;
  PVector closest = null;
  float distance = Float.MAX_VALUE;
  for (PVector elem : list) {
    float current = PVector.dist(point, elem);

    if (current < distance) {
      closest = elem;
      distance = current;
    }
  }
  return closest;
}

PVector mouse = new PVector(mouseX, mouseY);

void draw() {
  mouse.x = mouseX;
  mouse.y = mouseY;
  background(255);
  fill(color(255, 0, 0));
  stroke(color(255, 0, 0));
  if (isControlEnabled) control(points);
  stroke(color(0, 0, 0));
  ArrayList<PVector> bezierPoints = bezier(points, 0.01); //<>//
  stroke(color(0, 255, 0));
  control(bezierPoints); //<>//
  stroke(color(0, 0, 255));
  PVector closest = getClosestToList(mouse, bezierPoints); //<>//
  line(mouseX, mouseY, closest.x, closest.y);
}