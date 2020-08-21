
/*****************************************************




*****************************************************/

player [] Players = new player[2];

//Generación de los jugadores
void setupPlayers(){
  for(int i = 0; i < Players.length; i++){
    Players[i] = new player(0,0,i);
  }
  
}


//Clase
class player{
  //Número del Jugador
  int num;
  
  //Posición
  int x,y;
  int sizeX = sizeBlocks;
  int sizeY = 2*sizeBlocks;
  
  //Movimiento
  int velX = 0, velX0 = 0;
  int velY = 0, velY0 = 0;
  boolean jump = false;
  int g = 10;
  float t;
  
  //Colisiones
  boolean wallLeft = false;
  boolean roof = false;
  boolean wallRight = false;
  boolean ground = false;
  
  //Sprite
  int spriteColor = 0;
  PImage sprite;
  int frame;
  int pastVelX = 1;
  
  
  player(int _x, int _y, int _num){
    x = _x;
    y = _y;
    num = _num;
    
    sprite = loadImage("HugCaminante.png");
  } 
  
  void setXY(int _x, int _y){
    x = _x;
    y = _y;
  }
  
  void update(){
    control();
    
    //Colisiones
    wallLeft = checkCol(x-1, y, sizeX, sizeY);
    roof = checkCol(x, y-1, sizeX, sizeY);
    wallRight = checkCol(x+1, y, sizeX, sizeY);
    ground = checkCol(x, y+1, sizeX, sizeY);
    
    //Salto
    if(jump && ground){  //Si se presiona la tecla de salto y está tocando suelo
      velY0 = -6;
      t = 0;
    }
    
    //Movimiento X
    for(int i = 0; i < abs(velX); i++){
      if(!checkCol(x + sign(velX), y, sizeX, sizeY)){  //Revisa en cada pixel que avanza si hay un bloque o no
        x += sign(velX);  //Si no hay bloque disminuye o aumenta (dependiendo la dirección) una unidad la posición en x
      }else{
        velX = 0;
        break;
      }
    }
      
    //Movimiento Y
    velY = round(velY0 + g*t);
    t += 0.04;
    
    for(int i = 0; i < abs(velY); i++){
      if(!checkCol(x, y + sign(velY), sizeX, sizeY)){
        y += sign(velY);
      }else{
        velY = 0;
        t = 0;
        velY0 = 0;
        break;
      }
    }
  }
  
  void display(){
    
    //Máscara de colisión
    fill(255);
    noStroke();
    rect(x, y, sizeX, sizeY);
    
    
    frame = (frameCount/6)%10; 
    
    if(velX > 0){
      pastVelX = 1;
      copy(sprite, frame*64, 0, 64,64, x - sizeX/2, y, 2*sizeX, sizeY +1);  //Muestra el sprite mirando a la derecha (+1 porque no se ajusta muy bien la imagen)
      
    }else if(velX < 0){
      pastVelX = -1;
      copy(sprite, frame*64, 64, 64,64, x - sizeX/2, y, 2*sizeX, sizeY +1);  //Muestra el sprite mirando a la izquierda
      
    }else{  //Si no se mueve, mira en la dirección en la que se estába moviendo
      if(pastVelX == 1)  copy(sprite,0,0,64,64,x - sizeX/2, y, 2*sizeX, sizeY +1);
      if(pastVelX == -1)  copy(sprite,0,64,64,64,x - sizeX/2, y, 2*sizeX, sizeY +1);
      
    }
    
  }
  
}
