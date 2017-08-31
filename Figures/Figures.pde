void setup(){
  size(300,300);    
  generateClouds();
}

void generateClouds(){
  loadPixels();
  for(int x = 0; x < width; x++){
     for(int y = 0; y < height; y++){
        set(x,y,color(random(1,255)));
     }  
  }
  

}

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






void draw(){
  filter(2);
}