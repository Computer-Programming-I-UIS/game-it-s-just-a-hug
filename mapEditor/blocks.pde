
//----------------------GENERACIÖN DE LOS TILES----------------------//

block [][] Tiles = new block[numTilesY][numTilesX];

void setupBlocks(){
  for(int i = 0; i < Tiles.length; i++){
    for(int j = 0; j < Tiles[i].length; j++){
      Tiles[i][j] = new block(j*sizeTiles, i*sizeTiles, sizeTiles);
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

//----------------------ACTUALIZAR TILES----------------------//

void updateTiles(){
  
  //Recorre cada tipo de tile
  for(int t = 0; t < typeTiles.length; t++){
    
    //Tipo de tiles de 3x3
    if(configImages[t][0] == 3){
      //Recorremos cada tile del nivel
      for(int i = 0; i < Tiles.length; i++){
        for(int j = 0; j < Tiles[i].length; j++){
          
          if(Tiles[i][j].typeBlock != t){  //Si es un tipo de bloque diferente 
            continue;
          }else{
            if(i > 0 && i < Tiles.length-1 && j > 0 && j < Tiles[i].length -1){  //Si ese tile no es de los de borde o esquina
              
              int upB = Tiles[i-1][j].typeBlock;
              int downB = Tiles[i+1][j].typeBlock;
              int leftB = Tiles[i][j-1].typeBlock;
              int rightB = Tiles[i][j+1].typeBlock;
              
              if(upB != t && downB == t && leftB != t && rightB == t){  //Bloque arriba izquierda
                Tiles[i][j].xTile = 0;
                Tiles[i][j].yTile = 0;
                
              }else if(upB != t && downB == t && leftB == t && rightB == t){  //Bloque arriba centro
                Tiles[i][j].xTile = sizeTiles;
                Tiles[i][j].yTile = 0;
                
              }else if(upB != t && downB == t && leftB == t && rightB != t){  //Bloque arriba derecha
                Tiles[i][j].xTile = 2*sizeTiles;
                Tiles[i][j].yTile = 0;
                
              }else if(upB == t && downB == t && leftB != t && rightB == t){  //Bloque centro izquierda
                Tiles[i][j].xTile = 0;
                Tiles[i][j].yTile = sizeTiles;
                
              }else if(upB == t && downB == t && leftB == t && rightB == t){  //Bloque centro
                Tiles[i][j].xTile = sizeTiles;
                Tiles[i][j].yTile = sizeTiles;
                
              }else if(upB == t && downB == t && leftB == t && rightB != t){  //Bloque centro derecha
                Tiles[i][j].xTile = 2*sizeTiles;
                Tiles[i][j].yTile = sizeTiles;
                
              }else if(upB == t && downB != t && leftB != t && rightB == t){  //Bloque abajo izquierda
                Tiles[i][j].xTile = 0;
                Tiles[i][j].yTile = 2*sizeTiles;
                
              }else if(upB == t && downB != t && leftB == t && rightB == t){  //Bloque abajo centro
                Tiles[i][j].xTile = sizeTiles;
                Tiles[i][j].yTile = 2*sizeTiles;
                
              }else if(upB == t && downB != t && leftB == t && rightB != t){  //Bloque abajo derecha
                Tiles[i][j].xTile = 2*sizeTiles;
                Tiles[i][j].yTile = 2*sizeTiles;
                
              }else{
                Tiles[i][j].xTile = sizeTiles;
                Tiles[i][j].yTile = 0;
              }
            }
            else{
              Tiles[i][j].xTile = sizeTiles;
              Tiles[i][j].yTile = sizeTiles;
            }
          }
          
        }
      }
      
    }
    
  }
  
  
}

//----------------------REVISAR SI HAY OTRO BLOQUE CON EL JUGADOR----------------------//

void checkPlayer(int _p){
  for(int i = 0; i < Tiles.length; i++){
    for(int j = 0; j < Tiles[i].length; j++){
      if(Tiles[i][j].typeBlock == _p){  //Si ya hay otro bloque con ese jugador
        Tiles[i][j].typeBlock = typeTiles.length;  //Establece ese bloque como vacio
        break;
      }
    }
  }
}


//----------------------CLASE----------------------//

class block{
  int x, y;  //Cordenadas superior izquierda del tile
  int size;  //Tamaño 
  
  int typeBlock = typeTiles.length;
  int xTile = 0;
  int yTile = 0;
  
  block(int _x, int _y, int _size){
    x = _x;
    y = _y;
    size = _size;
  }
  
  void changeType(int _type){
    if(_type < 0)  checkPlayer(_type);
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
    updateTiles();
    if(typeBlock >= 0 && typeBlock != typeTiles.length){  //Es vacio
      copy(tilesImages[typeBlock], xTile, yTile, sizeTiles,sizeTiles, x,y, size,size);  //Pone la imagen del tile que corresponde
      
    }else if(typeBlock < 0){
      fill(color(round(random(255))));
      square(x, y, size);
    }
  }
}
