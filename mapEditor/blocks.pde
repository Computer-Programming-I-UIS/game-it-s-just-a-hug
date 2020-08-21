
//----------------------GENERACIÖN DE LOS TILES----------------------//

void setupBlocks(){
  for(int i = 0; i < Blocks.length; i++){
    for(int j = 0; j < Blocks[i].length; j++){
      Blocks[i][j] = new block(j*sizeTiles, i*sizeTiles, sizeTiles);
      Blocks[i][j].type = 0;
    }
  }
  
}

//----------------------DIBUJAR CUADRÍCULA----------------------//

void showGrid(){
  stroke(255);
  strokeWeight(1);
  
  //Lineas horizontales
  for(int i = 0; i < Blocks.length; i++){
    line(0, i*sizeTiles, Blocks[0].length*sizeTiles, i*sizeTiles);
    if(i == Blocks.length - 1)
      line(0, i*sizeTiles + sizeTiles, Blocks[0].length*sizeTiles , i*sizeTiles + sizeTiles);
  }
  //Lineas verticales
  for(int j = 0; j < Blocks[0].length; j++){
    line(j*sizeTiles, 0, j*sizeTiles, Blocks.length*sizeTiles);
    if(j == Blocks[0].length - 1)
      line(j*sizeTiles + sizeTiles, 0, j*sizeTiles + sizeTiles, Blocks.length*sizeTiles);
  }
  
}

//----------------------DIBUJAR BLOQUES----------------------//

void displayBlocks(){
  for(int i = 0; i < Blocks.length; i++){
    for(int j = 0; j < Blocks[i].length; j++){
      Blocks[i][j].display();
    }
  }
}

//----------------------ACTUALIZAR BLOQUES----------------------//

void updateBlocks(){
  boolean leftB = false;
  boolean upB = false;
  boolean rightB = false;
  boolean downB = false;
  
  for(int i = 0; i < Blocks.length; i++){
    for(int j = 0; j < Blocks[i].length; j++){
      leftB = false;
      upB = false;
      rightB = false;
      downB = false;
      
      //if(i > 0 && i < Blocks.length-1 && j > 0 && j < Blocks[i].length -1){  //Si ese bloque no es de los de borde o esquina
      
      if(j == 0 || Blocks[i][j].type == Blocks[i][j-1].type)  leftB = true;  //Si el bloque de la izquierda es del mismo tipo de bloque entonces leftB = true
      if(i == 0 || Blocks[i][j].type == Blocks[i-1][j].type)  upB = true;
      if(j == Blocks[i].length-1 || Blocks[i][j].type == Blocks[i][j+1].type)  rightB = true;
      if(i == Blocks.length-1 || Blocks[i][j].type == Blocks[i+1][j].type)  downB = true;
      
      Blocks[i][j].updateTile(leftB, upB, rightB, downB); 
    }
  }
  
}


//----------------------REVISAR SI HAY OTRO BLOQUE CON EL JUGADOR----------------------//

void deletePlayer(int _p){
  for(int i = 0; i < Blocks.length; i++){
    for(int j = 0; j < Blocks[i].length; j++){
      if(Blocks[i][j].type == _p){  //Si ya hay otro bloque con ese jugador
        Blocks[i][j].type = 0;  //Establece ese bloque como vacio
        break;
      }
      
    }
  }
  
}


//----------------------CLASE----------------------//

class block{
  int x, y;  //Cordenadas superior izquierda del tile
  int size;  //Tamaño 
  int type;
  
  int xTile = 0;
  int yTile = 0;
  
  block(int _x, int _y, int _size){
    x = _x;
    y = _y;
    size = _size;
  }
  
  void changeType(int _type){
    if(_type == 1 || _type == 2){
      deletePlayer(_type);
    }
    type = _type;
    updateBlocks();
  }
  
  void updateTile(boolean _left, boolean _up, boolean _right, boolean _down){
    String xyTile = Tiles[type].updateTile(_left, _up, _right, _down);
    
    int [] xy = int(split(xyTile, ','));  //Separa el string en cada ',' y lo convierte a int
    
    xTile = xy[0];
    yTile = xy[1];
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
    
    if(Tiles[type].tileImage != null){  //Si ese tile SÍ tiene imagen
      copy(Tiles[type].tileImage, xTile, yTile, sizeTiles,sizeTiles, x,y, size,size);  //Pone la imagen del tile que corresponde
    }
    
  }
  
}
