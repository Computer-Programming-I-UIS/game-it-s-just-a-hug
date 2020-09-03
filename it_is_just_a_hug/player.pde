/*****************************************************




*****************************************************/

player [] Players = new player[2];
block PlayersCol [] = new block [Players.length];
int playerBomb = 0;  //Jugador que tiene la bomba
boolean passBomb = false;  //true si el jugador sí puede pasar la bomba

//Generación de los jugadores
void setupPlayers(){
  for(int i = 0; i < Players.length; i++){
    Players[i] = new player(0,0,i);
    Players[i].setSkin(i+1);
  }
}

void colPlayers(){
  
  for(int i = 0; i < Players.length; i++){
    if(playerBomb != i){
      if(PlayersCol[playerBomb].checkCol(Players[i].x, Players[i].y, Players[i].sizeX, Players[i].sizeY) && passBomb){
        Players[playerBomb].setSprite();  //El jugador que tenía la bomba ahora no la tiene
        playerBomb = i;
        Players[playerBomb].setSprite();  //Ahora el otro jugador la tiene
        soundButton.trigger();
        passBomb = false;
        break;
        
      }else{
        if(dist(Players[playerBomb].x, Players[playerBomb].y, Players[i].x, Players[i].y) > 1.5*sizeBlocks && !PlayersCol[playerBomb].checkCol(Players[i].x, Players[i].y, Players[i].sizeX, Players[i].sizeY)){  //Si se aleja un poco y luego se acerca de nuevo le puede pegar la bomba
          passBomb = true;
        }
        
      }
      
    }  //end playerBomb != i
  }  //end for(i)
  
}


//Clase
class player{
  //Número del Jugador
  int num;
  
  //Posición
  int x,y;
  int sizeX = 25*sizeBlocks/32;
  int sizeY = 50*sizeBlocks/32;
  
  //Movimiento
  int velX = 0, velX0 = 0, velXMax = 5;
  int velY = 0, velY0 = 0, velYMax = 8;
  boolean jump = false;
  boolean move = true;
  int g = 10;
  float t;
  
  //Colisiones
  boolean ground = false;
  boolean port = false;
  
  //Sprite
  int spriteColor = 1;
  PImage sprite;  //El sprite que se muestra
  PImage spriteWalk;
  PImage spriteBomb;
  PImage spriteBurned;
  int frame;
  int pastVelX = 1;
  boolean kaboom = false;
  
  //Bomba
  boolean lejos = true;
  boolean bomb = false;
  
  player(int _x, int _y, int _num){
    x = _x;
    y = _y;
    num = _num;
    
    /*
    for(int c = 1; c < 1; c++){  //Comprueba que existan los sprites para cada color
      String fileNameW = "player0"+c+"_walking.png";
      String fileNameB = "player0"+c+"_bomb.png";
      if(!fileExists(fileNameW, "sprites") || !fileExists(fileNameB, "sprites")){  //Si no existe alguno de los sprites
        println("¡ERROR!");
        println("Los archivos", fileNameW, "o", fileNameB, "NO existen o no se ecuentra en la carpeta \"data\\sprites\\\"");
        println("Revisa los nombres de los archivos y la carpeta \"data\\sprites\\\"");
        exit();
        break;
      }
    }
    */
    spriteWalk = loadImage("data/sprites/player01_walking.png");
    spriteBomb = loadImage("data/sprites/player01_bomb.png");
    spriteBurned = loadImage("data/sprites/player01_bomb_Actived.png");
    sprite = spriteWalk;
  } 
  
  void setXY(int _x, int _y){
    x = _x;
    y = _y;
  }
  
  void setSkin(int _spriteColor){
    spriteColor = _spriteColor;
    spriteWalk = loadImage("data/sprites/player0"+_spriteColor+"_walking.png");
    spriteBomb = loadImage("data/sprites/player0"+_spriteColor+"_bomb.png");
    spriteBurned = loadImage("data/sprites/player0"+_spriteColor+"_bomb_Actived.png");
    
    sprite = spriteWalk;
    
  }
  
  void setSprite(){
    bomb = !bomb;
    if(!bomb)  sprite = spriteWalk;
    else  sprite = spriteBomb;
  }
  
  void kaboom(){
    sprite = spriteBurned;
    kaboom = true;
    frame = 0;
  }
  
  void reset(){
    //Movimiento
    velX = 0;
    velX0 = 0;
    velY = 0;
    velY0 = 0;
    t = 0;
    jump = false;
    move = true;
    ground = false;
    port = false;
    
    //Sprite
    frame = 0;
    pastVelX = 1;
    kaboom = false;
    bomb = false;
    lejos  = true;
  }
  
  void update(){
    controlPlayers();
    PlayersCol[num].setXY(x,y);  //Actualiza la colisión
    colPlayers();
    
    //Colisiones
    ground = checkCol(x, y+1, sizeX, sizeY);
    checkPort(x, y, sizeX, sizeY, num);  //Checa los portales
    if(port){
      for(int p = 0; p < numBTeleportMap; p++){
        if(dist(x, y, Teleport[p].x, Teleport[p].y) < 2*sizeBlocks){
          port = true;
          break;
        }else{
          port = false;
        }
      }
    }
    
    //Salto
    if(jump && (ground || y + sizeY == height)){  //Si se presiona la tecla de salto y está tocando suelo
      if(y + sizeY == height){
        y--;
      }
      velY0 = -velYMax;
      t = 0;
    }
    
    //Movimiento X
    if(!move){
      velX = 0;
    }
    for(int i = 0; i < abs(velX); i++){
      if(!checkCol(x + sign(velX), y, sizeX, sizeY) && (x > 0 && x + sizeX < width) ){  //Revisa en cada pixel que avanza si hay un bloque o está al borde de la pantalla
        x += sign(velX);  //Si no hay bloque disminuye o aumenta (dependiendo la dirección) una unidad la posición en x
      }else{
        if(x == 0) x++;
        else if(x + sizeX == width)  x--;
        velX = 0;
        break;
      }
    }
      
    //Movimiento Y
    velY = constrain(round(velY0 + g*t), -velYMax, velYMax);  //La velocidad nunca va a ser muy grande
    t += 0.04;
    if(!move){
      velY = 0;
      t = 0;
      jump = false;
    }
    for(int i = 0; i < abs(velY); i++){
      if(!checkCol(x, y + sign(velY), sizeX, sizeY) && y + sizeY < height){
        y += sign(velY);
      }else{
        //if(y + sizeY == height)  y--;
        velY = 0;
        t = 0;
        velY0 = 0;
        break;
      }
    }
  }
  
  void display(){
    
    //Máscara de colisión
    /*
    fill(255);
    noStroke();
    rect(x, y, sizeX, sizeY);
    */
    
    
    //frame = (frameCount/6)%10; 
    if(!kaboom){
      frame = (frameCount/(abs(2*velX/3)+1))%10;  //Dependiendo de la velocidad cambia de frames más rápido o no
    }else{
      if(frame < 9 && frameCount%5 == 0){
        frame++;
      }
    }
    
    if(velY <= 0){  //No está cayendo
      if(!kaboom){
        if(velX > 0){
          pastVelX = 1;
          copy(sprite, frame*64, 0, 64,64, x - sizeX/2, y, 2*sizeX, sizeY +1);  //Muestra el sprite mirando a la derecha (+1 porque no se ajusta muy bien la imagen)
          
        }else if(velX < 0){
          pastVelX = -1;
          copy(sprite, frame*64, 64, 64,64, x - sizeX/2, y, 2*sizeX, sizeY +1);  //Muestra el sprite mirando a la izquierda
          
        }else if(velX == 0){  //Si no se mueve, mira en la dirección en la que se estába moviendo
          if(pastVelX == 1){
            copy(sprite,0,0,64,64,x - sizeX/2, y, 2*sizeX, sizeY +1);
          }
          if(pastVelX == -1){
            copy(sprite,0,64,64,64,x - sizeX/2, y, 2*sizeX, sizeY +1);
          }
          
        }
      }else{
        if(pastVelX == 1)  copy(sprite, frame*64, 0, 64,64, x - sizeX/2, y, 2*sizeX, sizeY +1);  //Muestra el sprite mirando a la derecha (+1 porque no se ajusta muy bien la imagen)
        if(pastVelX == -1)  copy(sprite, frame*64, 64, 64,64, x - sizeX/2, y, 2*sizeX, sizeY +1);  //Muestra el sprite mirando a la izquierda
      }
    }else{ //Está cayendo
      if(pastVelX == 1)  copy(sprite, 192,0, 64,64,x - sizeX/2, y, 2*sizeX, sizeY +1);
      if(pastVelX == -1)  copy(sprite, 192,64, 64,64,x - sizeX/2, y, 2*sizeX, sizeY +1);
    }
    
  }
  
}
