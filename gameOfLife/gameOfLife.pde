int sizeX = 100;
int sizeY = 100;
int sizeMultiplier = 8;

int[][] oldField = new int[sizeX][sizeY];
int[][] newField = new int[sizeX][sizeY];

void setup() {
  size(800,800);
  //initRandom();
  oscillatorInit(30,30);
  //toadInit(11,11);
  //pentadecathlonInit(70,70);
}

void pentadecathlonInit(int x, int y){
  oldField[x+1][y] = 1;
  oldField[x+1][y+1] = 1;
  
  oldField[x][y+2] = 1;
  oldField[x+2][y+2] = 1;
  
  oldField[x+1][y+3] = 1;
  oldField[x+1][y+4] = 1;
  oldField[x+1][y+5] = 1;
  oldField[x+1][y+6] = 1;
  
  oldField[x][y+7] = 1;
  oldField[x+2][y+7] = 1;
  
  oldField[x+1][y+8] = 1;
  oldField[x+1][y+9] = 1;

}

void oscillatorInit(int x, int y){
  oldField[x][y] = 1;
  oldField[x][y+1] = 1;
  oldField[x][y+2] = 1;
}


void toadInit(int x, int y){
  oldField[x][y] = 1;
  oldField[x][y+1] = 1;
  oldField[x][y+2] = 1;
  oldField[x+1][y+1] = 1;
  oldField[x+1][y+2] = 1;
  oldField[x+1][y+3] = 1;
}


void initRandom(){
  for(int x = 0; x < sizeX; x++){
    for(int y = 0; y < sizeY; y++){
      oldField[x][y] = int(random(0,100)%2);
    }
  }
}

boolean isAlive(int x, int y){
  int livingNeighbours = 0;
  if((x > 0) && (y > 0) && (x < sizeX) && (y < sizeY)){
   // middle points
     livingNeighbours = oldField[x-1][y-1] + oldField[x][y-1] + oldField[x+1][y-1] + 
                 oldField[x-1][y] + oldField[x+1][y] + 
                 oldField[x-1][y+1] + oldField[x][y+1] + oldField[x+1][y+1];
  }
  
  if( livingNeighbours == 2 || livingNeighbours == 3){
    if(oldField[x][y] == 1) {
      return true;
    }
  }
  if(oldField[x][y] == 0 && livingNeighbours == 3) {
     return true; 
  }
  
  return false;
}

void mouseClicked(){
    int x = mouseX / sizeMultiplier;
    int y = mouseY / sizeMultiplier;
    oscillatorInit(x,y); 
}

void draw() {
  for(int x = 1; x < sizeX-1; x++){
    for(int y = 1; y < sizeY-1; y++){
      if(isAlive(x,y)){
         newField[x][y] = 1;
         fill(0); // BLACK   
      }
      else {
         newField[x][y] = 0;
         fill(255); // WHITE
      }
      rect(x * sizeMultiplier, y * sizeMultiplier, sizeMultiplier, sizeMultiplier);
    }
  }
  oldField = newField;
  newField = new int[sizeX][sizeY];
}