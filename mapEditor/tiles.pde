
//----------------------GENERACIÖN DE LOS TILES----------------------//

tile [][] Tiles = new tile[numTilesY][numTilesX];

void setupTiles(){
  for(int i = 0; i < Tiles.length; i++){
    for(int j = 0; j < Tiles[i].length; j++){
      Tiles[i][j] = new tile(j*sizeTiles, i*sizeTiles, sizeTiles);
    }
  }
  
}

//----------------------DIBUJAR CUADRÍCULA----------------------//

void showGrid(){
  
  stroke(255);
  strokeWeight(1);
  
  //Lineas horizontales
  for(int i = 0; i < Tiles.length; i++){
    line(0, i*sizeTiles, Tiles[0].length*sizeTiles, i*sizeTiles);
    if(i == Tiles.length - 1)
      line(0, i*sizeTiles + sizeTiles, Tiles[0].length*sizeTiles , i*sizeTiles + sizeTiles);
  }
  //Lineas verticales
  for(int j = 0; j < Tiles[0].length; j++){
    line(j*sizeTiles, 0, j*sizeTiles, Tiles.length*sizeTiles);
    if(j == Tiles[0].length - 1)
      line(j*sizeTiles + sizeTiles, 0, j*sizeTiles + sizeTiles, Tiles.length*sizeTiles);
  }
  
}

//----------------------DIBUJAR TILES----------------------//

void displayTiles(){
  for(int i = 0; i < Tiles.length; i++){
    for(int j = 0; j < Tiles[i].length; j++){
      Tiles[i][j].display();
    }
  }
}

//----------------------CLASE----------------------//

class tile{
  int x, y;  //Cordenadas superior izquierda del tile
  int size;  //Tamaño 
  
  int typeBlock = typeTiles.length;
  int tile;
  
  tile(int _x, int _y, int _size){
    x = _x;
    y = _y;
    size = _size;
  }
  
  void changeType(int _type){
    typeBlock = _type;
  }
  
  void changeTile(int _i, int _j){
    
  }
  
  boolean checkMouse(){
    if(mouseX > x && mouseX < x + size && mouseY > y && mouseY < y + size){  //Si el puntero está sobre el botón
      if(mousePressed && mouseButton == LEFT){
        return true;
        }
      }
      return false;
    }
  void display(){
    
    if(checkMouse())  changeType(tileSelected);
    
    //fill(color(round(random(255))));
    //square(x, y, size);
    if(typeBlock != typeTiles.length){  //Es vacio
      copy(tilesImages[typeBlock], configImages[typeBlock][1], configImages[typeBlock][2], 32,32, x,y, size,size);  //Pone la imagen del tile que corresponde
    }
  }
}
