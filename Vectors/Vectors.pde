ArrayList<PVector> mesh = new ArrayList();


void setup() {
  size(640, 360);
}

int diameter = 30;

void addLine(int x, int y) {
  PVector mouse = new PVector(mouseX, mouseY);
  PVector point = new PVector(x, y);
  mouse.sub(point);
  mouse.normalize();
  mouse.mult(diameter/2);
  translate(x, y);
  strokeWeight(2);
  line(0, 0, mouse.x, mouse.y);
  translate(-x, -y);
}

// Trippy
void filter(int r){
  for(int x = r; x < width - r; x++){
     for(int y = r; y < height - r; y++){
       int count = 0;
       int sum = 0;
       for(int sx = x - r; sx <= x + r; sx++){
         for(int sy = y - r; sy <= y + r; sy++){
           sum += get(sx,sy);
           count++;
         }
       }
       int average = sum/count;
       
      for(int sx = x - r; sx <= x + r; sx++){
         for(int sy = y - r; sy <= y + r; sy++){
           set(sx,sy,color(average));
         }
       }
       
     }  
  }  
}

void draw() {
  //background(255);
  for (int x = 0; x <= width; x+= diameter) {
    for (int y = 0; y <= height; y+= diameter) {
      addLine(x, y);
    }
  }
  filter(1);
}