
/*****************************************************




*****************************************************/

player [] Players = new player[2];

//Generación de los jugadores
void setupPlayers(){
  for(int i = 0; i < map.length; i++){
    for(int j = 0; j < map[i].length; j++){
      if(map[i][j] == '1'){
        Players[0] = new player(j*sizeBlocks, i*sizeBlocks, 1);
      }else if(map[i][j] == '2'){
        Players[1] = new player(j*sizeBlocks, i*sizeBlocks, 2);
      }
    }
  }
  
}


//Clase
class player{
  int x,y;
  int sizeX = sizeBlocks;
  int sizeY = 2*sizeBlocks;
  
  int velX = 0, velX0 = 0;
  int velY = 0, velY0 = 0;
  int g = 10;
  float t;
  
  boolean jump = false;
  
  PImage spritehug;
  int frame;
  int afterVelX=1;
  
  player(int _x, int _y, int _color){
    x = _x;
    y = _y;
    
    spritehug = loadImage("HugCaminante.png");
  } 
  
  //--------------------------------COLISIONES--------------------------------//
  
  boolean checkRoof(){
    if(velY <= 0){
      for(int _y = 0; _y < map.length; _y++){
        for(int _x = 0; _x < map[_y].length; _x++){
          if(map[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkDownCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'S'){
            t = 0;
            velY0 = 0;
            velY = 0;
            return true;
            
          }else if(lavas[_y][_x].checkDownCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'L'){
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
      for(int _y = 0; _y < map.length; _y++){
        for(int _x = 0; _x < map[_y].length; _x++){
          if(map[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkUpCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'S'){
            t = 0;
            velY0 = 0;
            velY = 0;
            return true;
            
          }else if(lavas[_y][_x].checkUpCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'L'){
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
      for(int _y = 0; _y < map.length; _y++){
        for(int _x = 0; _x < map[_y].length; _x++){
          if(map[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkLeftCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'S'){
            velX = 0;
            return true;
            
          }else if(lavas[_y][_x].checkLeftCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'L'){
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
      for(int _y = 0; _y < map.length; _y++){
        for(int _x = 0; _x < map[_y].length; _x++){
          if(map[_y][_x] == ' '){  //Si el bloque no existe pasa al siguiente ciclo
            continue;
          }else if(suelos[_y][_x].checkRightCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'S'){
            velX = 0;
            return true;
            
          }else if(lavas[_y][_x].checkRightCollision(x, y, sizeX, sizeY) && map[_y][_x] == 'L'){
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
      jump = true;
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
    rect(x, y, sizeX, sizeY);
    
    frame=(frameCount/6)%10; 
    if (velX!=0){
     if(velX>0){
       afterVelX=1;
       copy(spritehug,frame*64,0,64,64,x - sizeX/2,y,2*sizeX,sizeY);
       
     }if(velX<0){
       afterVelX=2;
      
       copy(spritehug,frame*64,64,64,64,x - sizeX/2,y,2*sizeX,sizeY);
     }  
   }else{
     if(afterVelX==1)copy(spritehug,0,0,64,64,x - sizeX/2, y, 2*sizeX,sizeY);
     if(afterVelX==2 )copy(spritehug,0,64,64,64,x - sizeX/2, y, 2*sizeX,sizeY); 
    }
    
  }
  
}
