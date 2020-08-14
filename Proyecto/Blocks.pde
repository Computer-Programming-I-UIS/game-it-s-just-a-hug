
/*****************************************************




*****************************************************/

roca suelos [][] = new roca [numAlto][numAncho];
lava lavas [][] = new lava [numAlto][numAncho];

//Generar Bloques
void genBlocks(){
  
  for(int y = 0; y < level.length; y++){
    for(int x = 0; x < level[y].length; x++){
      suelos[y][x] = new roca(x*sizeBlock, y*sizeBlock);
      lavas[y][x] = new lava(x*sizeBlock, y*sizeBlock);
    }
  }
  
}

//Clase

class block{
  int x, y;
  int size = sizeBlock;
  color color1 = color(100,100,100);
  
  block(int _x, int _y){
    x = _x;
    y = _y;
  }
  //Colisión con la parte de arriba del bloque (el objeto está sobre el bloque)
  boolean checkUpCollision(int _x, int _y, int _xSize, int _ySize){
    if(_x + _xSize > x && _x < x + size && _y + _ySize == y){
      return true;
    }
    return false;
  }
  
  //Colisión con la parte de abajo del bloque (el objeto saltó y está tocando "techo")
  boolean checkDownCollision(int _x, int _y, int _xSize, int _ySize){
    if(_x + _xSize > x && _x < x + size && _y == y + size){
      return true;
    }
    return false;
  }
  
  //Colisión con la parte izquierda del bloque (el objeto está moviendose hacia la derecha)
  boolean checkRightCollision(int _x, int _y, int _xSize, int _ySize){
    if(_y + _ySize > y && _y < y + size && _x + _xSize == x){
      return true;
    }
    return false;
  }
  
  //Colisión con la parte derecha del bloque (el objeto está moviendose hacia la izqurierda)
  boolean checkLeftCollision(int _x, int _y, int _xSize, int _ySize){
    if(_y + _ySize > y && _y < y + size && _x == x + size){
      return true;
    }
    return false;
  }
  
  void display(){
    noStroke();
    //stroke(0);
    fill(color1);
    square(x, y, size);
  }
  
}

class roca extends block{
  
  roca(int _x, int _y){
    super(_x, _y);
    color1 = color(255,0,0);
  }
  
}

class lava extends block{
  
  lava(int _x, int _y){
    super(_x, _y);
    color1 = color(0,0,255);
  }
  
}
