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
  
  setupBlocks();
  setupPlayers();
  
  importMap(1);
  wallpaper = loadImage("data/map1.png");
}
void draw(){
  //println(frameRate);
  
  image(wallpaper,0,0,wallpaper.width,wallpaper.height);
  /*
  for(int i = 0; i < numBGroundMap; i++){
    Ground[i].display();
  }
  */
  Players[0].update();
  Players[0].display();
  
}

//Obtener el signo de un número
int sign(int num){
  if(num == 0)  return 0;
  else if(num < 0) return -1;
  else  return +1;
}


void mousePressed(){
  Players[0].x = mouseX;
  Players[0].y = mouseY;
}
