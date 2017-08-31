
void setup() {
  size(1000, 200);
}


int normalize(float x){
  return int(200 * (x - 1) +200);
}

PVector previous = new PVector(0,100);

void draw() {
  previous.x = 0;
  previous.y = 100;
  
  for (int x = 0; x < 1000; x++) {
    fill(255);
    float a  = (noise(x)); //<>//
    println(a);
    int y = normalize(noise(x));
    line(previous.x, previous.y ,x, y);
    previous.x = x;
    previous.y = y;
  }
}