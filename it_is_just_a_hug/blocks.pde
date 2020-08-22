/*****************************************************

La cantidad máxima de bloques de tierra es igual a la mitad de la cantidad total de bloques en pantalla
Dado que cuando se configuran los mapas si en la matriz map[][] hay una 'S' al lado de otra estas dos se unen formando un solo bloque
Entonces el nivel se forma de rectángulos y en el peor de los casos usando esta forma de unir los bloques que estan uno al lado de otro
Se formaría un tablero de ajedrez y la cantidad de bloques sería la mitad de la cantidad total de bloques en pantalla.

*****************************************************/

block Ground [] = new block [(numBlocksX*numBlocksY)/2];
block Teleport [] = new block [6];
int numBGroundMap = Ground.length;  //Número de rectángulos de bloque tierra que tiene el mapa
int numBTeleportMap = Teleport.length;

//Generar Bloques
void setupBlocks(){
  
  for(int i = 0; i < Ground.length; i++){
    Ground[i] = new block(i*sizeBlocks, i*sizeBlocks);  //Como cada vez que se configura un map se establece unas nuevas cordenadas entonces se pueden iniciar todos en (0,0)
  }
  /*
  for(int i = 0; i < Teleport.length; i++){
    Teleport[i] = new block(i*5*sizeBlocks + 500, i*3*sizeBlocks);
  }*/
  Teleport[0] = new block(5*sizeBlocks, 2*sizeBlocks);
  Teleport[1] = new block(15*sizeBlocks, sizeBlocks);
  Teleport[2] = new block(8*sizeBlocks, 14*sizeBlocks);
  Teleport[3] = new block(22*sizeBlocks, sizeBlocks);
  
  
  for(int i = 0; i < PlayersCol.length; i++){
    PlayersCol[i] = new block(Players[i].x, Players[i].y);
    PlayersCol[i].sizeX = Players[i].sizeX;
    PlayersCol[i].sizeY = Players[i].sizeY;
  }
  
}

boolean checkCol(int _x, int _y, int _sizeX, int _sizeY){
  //Bloques
  for(int i = 0; i < numBGroundMap; i++){
    if(Ground[i].checkCol(_x, _y, _sizeX, _sizeY)){
      return true;
    }
  }
  return false;
}

boolean checkPort(int _x, int _y, int _sizeX, int _sizeY, int numPlayer){
  int port;
  for(int i = 0; i < numBTeleportMap; i++){
    if(Teleport[i].checkCol(_x, _y, _sizeX, _sizeY) && !Players[numPlayer].port){
      do{
        port = round(random(0, numBTeleportMap-1));  //Escoge un portal aleatorio
      }while(port == i);
      Players[numPlayer].setXY(Teleport[port].x, Teleport[port].y);
      Players[numPlayer].velX = 0;
      Players[numPlayer].velY = 0;
      Players[numPlayer].port = true;
      return true;
    }
  }
  return false;
}

//Clase
class block{
  int x, y;
  int sizeX = sizeBlocks;
  int sizeY = sizeBlocks;
  
  color color1 = color(100,100,100);
  
  block(int _x, int _y){
    x = _x;
    y = _y;
  }
  
  void setXY(int _x, int _y){
    x = _x;
    y = _y;
  }
  
  void setSize(int _sizeX){
    sizeX = _sizeX;
  }
  
  boolean checkCol(int _x, int _y, int _sizeX, int _sizeY){
    if(_x + _sizeX > x && _x < x + sizeX && _y + _sizeY > y && _y < y + sizeY){
      return true;
    }
    return false;
  }
  
  void display(){
    noStroke();
    stroke(0);
    fill(255);
    rect(x, y, sizeX, sizeY);
  }
  
}
