
/*****************************************************




*****************************************************/

player Player1;
player Player2;
PImage spritehug;
//Generación de los jugadores
void genPlayers(){
  spritehug = loadImage("Spritesheet Azul caminante Todas.png");
  for(int i = 0; i < level.length; i++){
    for(int j = 0; j < level[i].length; j++){
      if(level[i][j] == '1'){
        Player1 = new player(j*sizeBlock, i*sizeBlock);
      }
    }
  }
  
}


//Clase
class player{
  int x,y;
  int velX = 0, velX0 = 0;
  int velY = 0, velY0 = 0;
  
  int g = 10;
  int size = 2*sizeBlock;  //La mitad del tamaño de los bloques
  boolean jjump = false;
  float t;
  int frame;
  int afterVelX=1;
  
  player(int _x, int _y){
    x = _x;
    y = _y;
  } 
  
  //--------------------------------COLISIONES--------------------------------//
  
  boolean checkRoof(){
    if(velY <= 0){
      for(int _y = 0; _y < level.length; _y++){
        for(int _x = 0; _x < level[_y].length; _x++){
          if(level[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkDownCollision(x, y, size, size) && level[_y][_x] == 'S'){
            t = 0;
            velY0 = 0;
            velY = 0;
            return true;
            
          }else if(lavas[_y][_x].checkDownCollision(x, y, size, size) && level[_y][_x] == 'L'){
            x = width/2;
            y = height/2;
            return true;
          }
        }
      }  //end fors
      return false;
    }else  return false;
  }
  
  boolean checkGround(){
    if(velY >= 0){
      for(int _y = 0; _y < level.length; _y++){
        for(int _x = 0; _x < level[_y].length; _x++){
          if(level[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkUpCollision(x, y, size, size) && level[_y][_x] == 'S'){
            t = 0;
            velY0 = 0;
            velY = 0;
            return true;
            
          }else if(lavas[_y][_x].checkUpCollision(x, y, size, size) && level[_y][_x] == 'L'){
            x = width/2;
            y = height/2;
            return true;
          }
        }
      }  //end fors
      return false;
    }else  return false;
  }
  
  boolean checkLeftWall(){
    if(velX <= 0){
      for(int _y = 0; _y < level.length; _y++){
        for(int _x = 0; _x < level[_y].length; _x++){
          if(level[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkLeftCollision(x, y, size, size) && level[_y][_x] == 'S'){
            velX = 0;
            return true;
            
          }else if(lavas[_y][_x].checkLeftCollision(x, y, size, size) && level[_y][_x] == 'L'){
            x = width/2;
            y = height/2;
            return true;
          }
        }
      }  //end fors
      return false;
    }else  return false;
  }
  
  boolean checkRightWall(){
    if(velX >= 0){
      for(int _y = 0; _y < level.length; _y++){
        for(int _x = 0; _x < level[_y].length; _x++){
          if(level[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkRightCollision(x, y, size, size) && level[_y][_x] == 'S'){
            velX = 0;
            return true;
            
          }else if(lavas[_y][_x].checkRightCollision(x, y, size, size) && level[_y][_x] == 'L'){
            x = width/2;
            y = height/2;
            return true;
          }
        }
      }  //end fors
      return false;
    }else  return false;
  }
  
  //--------------------------------CONTROLES--------------------------------//
  
  void jump(){
    if(checkGround()){
      velY0 = -6;
      t = 0;
      jjump = true;
      //y--;
    }
  }
  void move(){
    control();
    
    //Eje X
    if(velX < 0){
      for(int a = velX; a < 0; a++){
        if(!checkLeftWall()){
          x--;
          
        }else{
          velX = 0;
          break;
        }
      }
    }else{
      for(int a = 0; a < velX; a++){
        if(!checkRightWall()){
          x++;
        }else{
          velX = 0;
          break;
        }
      }
    }
      
    //Eje Y
    velY = round(velY0 + g*t); 
    t += 0.04;
    if(velY < 0){
      for(int a = velY; a < 0; a++){
        if(!checkRoof()){
          y--;
        }else{
          break;
        }
      }
    }else{
      //Comprobación en cada pixel que aumenta
      for(int a = 0; a < velY; a++){
        if(!checkGround()){
          y++;  //Aumenta en 1
        }else{
          break;  //Tocó suelo entonces deja de caer;
        }
      }
    }
  }
  
  void display(){
    fill(255);
    noStroke();
   // square(x, y, size);
  //  copy(spritehug,0,0,320,320,x,y,size,size);
  frames();
    
  }
  void frames(){
    frame=(frameCount/6)%10; 
    
    if (velX!=0){
     if(velX>0){
       afterVelX=1;
       copy(spritehug,frame*320,0,320,320,x,y,size,size);
       
     }if(velX<0){
       afterVelX=2;
       copy(spritehug,frame*320,320,320,320,x,y,size,size);
     }  
   }else{
     if(afterVelX==1)copy(spritehug,0,0,320,320,x,y,size,size);
     if(afterVelX==2 )copy(spritehug,0,320,320,320,x,y,size,size); 
    }
  }
  
}
