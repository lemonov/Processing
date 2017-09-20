PVector root = new PVector(500, 1000);
PVector top = new PVector(500, 700);
float div = 0.5;
float angle = radians(90);
float wid = 5;
float widthDiv = 0.5;
int levels = 4;
float spawningChance = 50; // %
float spawningChanceDiv = 1.2; 
float maxBranchesPerLevel = 7;

void setup() {
  background(255);
  size(1000, 1000);

  //drawBranchesRandom(root, top, div, angle, wid, widthDiv, levels, spawningChance);
  //drawBranches(root, top, div, angle, wid, widthDiv, levels);
}

void draw() {
  //drawBranchesRandom2(root, top, div, angle, wid, widthDiv, levels, spawningChance, maxBranchesPerLevel); //<>//
}

// TODO make tree class (Tree -> Layers -> Branch -> Root and Top)
void mouseClicked() {
  background(255);
  drawBranchesRandom2(root, top, div, angle, wid, widthDiv, levels, spawningChance, spawningChanceDiv, maxBranchesPerLevel);
}


void drawBranchesRandom2(
  PVector root, 
  PVector top, 
  float div, 
  float angle, 
  float wid, 
  float widthDiv, 
  int levels, 
  float spawningChance, 
  float spawningChanceDiv,
  float maxBranchesPerLevel
  ) {
  strokeWeight(wid);

  line(root.x, root.y, top.x, top.y);
  
  spawningChance *= spawningChanceDiv;
  
  PVector branch = PVector.sub(top, root);
  branch.mult(div);

  if (levels >= 0) {
    wid*=widthDiv;
    levels--;

    for (int i = 0; i < maxBranchesPerLevel; i++) { //<>//
      float randAngle = random(-angle, angle);
      PVector tempBranch = branch.copy();
      tempBranch.rotate(randAngle);
      tempBranch.add(top);
      if (random(0, 100) < spawningChance) {
        drawBranchesRandom2(top, tempBranch, div, angle, wid, widthDiv, levels, spawningChance, maxBranchesPerLevel, spawningChanceDiv);
      }
    }
  }
}


void drawBranchesRandom(
  PVector root, 
  PVector top, 
  float div, 
  float angle, 
  float wid, 
  float widthDiv, 
  int levels, 
  float spawningChance
  ) {
  strokeWeight(wid);

  line(root.x, root.y, top.x, top.y);

  PVector branchLeft = PVector.sub(top, root);
  branchLeft.mult(div);
  PVector branchRight = branchLeft.copy();

  if (levels >= 0) {

    branchLeft.rotate(angle);
    branchRight.rotate(-angle);
    branchLeft.add(top);
    branchRight.add(top);
    wid*=widthDiv;
    levels--;
    if (random(0, 100) < spawningChance) {
      drawBranchesRandom(top, branchLeft, div, angle, wid, widthDiv, levels, spawningChance);
    }

    if (random(0, 100) < spawningChance) {
      drawBranchesRandom(top, branchRight, div, angle, wid, widthDiv, levels, spawningChance);
    }
  }
}

void drawBranches(PVector root, PVector top, float div, float angle, float wid, float widthDiv, int levels) {
  strokeWeight(wid);

  line(root.x, root.y, top.x, top.y);

  PVector branchLeft = PVector.sub(top, root);
  branchLeft.mult(div);
  PVector branchRight = branchLeft.copy();

  if (levels >= 0) {

    branchLeft.rotate(angle);
    branchRight.rotate(-angle);
    branchLeft.add(top);
    branchRight.add(top);
    wid*=widthDiv;
    levels--;
    drawBranches(top, branchLeft, div, angle, wid, widthDiv, levels);
    drawBranches(top, branchRight, div, angle, wid, widthDiv, levels);
  }
}