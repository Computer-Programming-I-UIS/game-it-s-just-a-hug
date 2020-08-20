/*****************************************************




*****************************************************/

//Tamaño de los Bloques
int sizeBlocks = 32;
//Cantidad de Bloques
int numBlocksX = 35;
int numBlocksY = 18;

PImage wallpaper;

void setup(){
  setupScreen();
  importMap(0);
  
  setupBlocks();
  setupPlayers();
  wallpaper = loadImage("data/map0.png");
}
void draw(){
  //println(frameRate);
  background(0);
  image(wallpaper,0,0,wallpaper.width,wallpaper.height);
  
  for(int i = 0; y < numBGroundMap; i++){
    Ground[i].display();
  }
  Players[0].display();
  Players[0].move();
  
}

void mousePressed(){
  Players[0].x = mouseX;
  Players[0].y = mouseY;
}
