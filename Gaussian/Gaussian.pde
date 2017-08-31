 //<>//
void setup() {
  size(1000, 1000);
}


int[] histogram = new int[100];

int normalize(float x) {
  float val = 10 * (x-5) + 100; //<>//
  int a = int(val);

  return a;
}

void draw() {
  float x = randomGaussian();
  int bucket = normalize(x);
  histogram[bucket]++;
  for (int i = 0; i < 100; i++) {
    fill(255);
    rect(i*10, 1000, 10, -histogram[i]-10);
    fill(0);
    textSize(8);
    text(str(histogram[i]), i*10, 1000);
  }
}