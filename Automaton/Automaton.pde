int rule = 0; // http://mathworld.wolfram.com/ElementaryCellularAutomaton.html //<>//

int[][] cell = new int[100][100];


void setState(int i2, int i1, int i0, int x, int y) {
  int parent = 0;
  parent |= (i2 & 0x01) << 2;
  parent |= (i1 & 0x01) << 1;
  parent |= (i0 & 0x01) << 0;

  if ((rule >> parent & 0x01) == 0x01) {
    cell[x][y] = 1;
  }
}

void init() {
  cell[cell.length/2][0] = 1;
}

void calculate() {
  int columns = 1; 
  for (int row = 1; row < cell.length-1; row++) {
    for (int column = cell.length/2 - columns; column < cell.length/2 + columns; column++) {
      if(column >= cell.length/2) break;
      
      setState(cell[column-1][row-1], cell[column][row-1], cell[column+1][row-1], column, row);
      if (cell[column][row] == 0x01)
      {
        fill(0);
        rect(column*5, row*5, 5, 5);
      }
    }
    columns++;
  }
}


void mouseClicked() {
  rule++;
  cell = new int[100][100];
  background(255);
  init();
  calculate();
}

void setup() {
  size(500, 500); 
  background(255);
  init();
  calculate();
}

void draw() {
}