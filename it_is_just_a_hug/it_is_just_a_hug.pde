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
  
  image(wallpaper,0,0,wallpaper.width,wallpaper.height);
  
  for(int i = 0; i < numBGroundMap; i++){
    Ground[i].display();
  }
  Players[0].update();
  Players[0].display();
  
  
}

int sign(int num){  //Obtener el signo de un número
  if(num == 0)  return 0;
  else if(num < 0) return -1;
  else  return +1;
}

void mousePressed(){
  Players[0].x = mouseX;
  Players[0].y = mouseY;
}
