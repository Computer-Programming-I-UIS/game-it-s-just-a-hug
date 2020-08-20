
/*****************************************************




*****************************************************/

//Tamaño de los Bloques
int sizeBlocks = 32;
//Cantidad de Bloques
int numAncho = 35;
int numAlto = 18;
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
  /*
  for(int y = 0; y < level.length; y++){
    for(int x = 0; x < level[y].length; x++){
      if(level[y][x] == 'S')  suelos[y][x].display();
      else if(level[y][x] == 'L')  lavas[y][x].display();
    }
  }
  */
  Players[0].display();
  Players[0].move();
  
}

void mousePressed(){
  Players[0].x = mouseX;
  Players[0].y = mouseY;
}
