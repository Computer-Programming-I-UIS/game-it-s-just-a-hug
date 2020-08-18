
/*****************************************************




*****************************************************/

//Tamaño de los Bloques
int sizeBlock = 32;
//Cantidad de Bloques
int numAncho = 35;
int numAlto = 18;
PImage wallpaper;

void setup(){
  setupScreen();
  configLevel(0);
  
  genBlocks();
  genPlayers();
  wallpaper = loadImage("data/Level0.png");
  //importFile();
}
void draw(){
  println(frameRate);
  background(0);
  image(wallpaper,0,0,wallpaper.width,wallpaper.height);
  for(int y = 0; y < level.length; y++){
    for(int x = 0; x < level[y].length; x++){
     // if(level[y][x] == 'S')  suelos[y][x].display();
    //  else if(level[y][x] == 'L')  lavas[y][x].display();
    }
  }
  Player1.display();
  Player1.move();
  
}

void mousePressed(){
  Player1.x = mouseX;
  Player1.y = mouseY;
}
//hola mundo
