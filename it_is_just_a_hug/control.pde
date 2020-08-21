//Player 1
boolean wKey, wKey1;
boolean aKey, aKey1;
boolean sKey, sKey1;
boolean dKey, dKey1;
boolean fKey, fKey1;  //Atacar

//Player 2
boolean upKey, upKey1;
boolean leftKey, leftKey1;
boolean downKey, downKey1;
boolean rightKey, rightKey1;
boolean lKey, lKey1;  //Atacar

boolean spaceKey;

void keyPressed(){
  /*
  if(key == 27){  //Si se presiona escape se pausa
    key = 0;  //Al convertirla a cero, evita que processing cierre la aplicación, como lo hace por defecto
    if(pauseIsPosible){
      if(!pause){  //Si no estaba pausado, guarda en que escena estaba
        lastScene = scene;
      }else{  //Si estba pausado, restaura la escena en la que estaba
        scene = lastScene;
      }
      pause = !pause;
    }
  }*/
  keyControl(keyCode, true);
}

void keyReleased(){
  keyControl(keyCode, false);
}

void keyControl(int k, boolean state){
  switch(k){
    case 87:  //W
      if(state && !wKey)  wKey1 = true;  //Variable para que solo se actualiza cuando se suelta y se presiona no tiene en cuenta si se tiene presionado
      else if(!state)  wKey1 = false;  //En caso que no se haya puesto en false
      wKey = state;
      break;
    case 65:  //A
      if(state && !aKey)  aKey1 = true;
      else if(!state)  aKey1 = false;
      aKey = state;
      break;
    case 83:  //S
      if(state && !sKey)  sKey1 = true;
      else if(!state)  sKey1 = false;
      sKey = state;
      break;
    case 68:  //D
      if(state && !dKey)  dKey1 = true;
      else if(!state)  dKey1 = false;
      dKey = state;
      break;
    case 70:  //F
      if(state && !fKey)  fKey1 = true;
      else if(!state)  fKey1 = false;
      fKey = state;
      break;
    case 38:  //ARRIBA
      if(state && !upKey)  upKey1 = true;
      else if(!state)  upKey1 = false;
      upKey = state;
      break;
    case 37:  //IZQUIERDA
      if(state && !leftKey)  leftKey1 = true;
      else if(!state)  leftKey1 = false;
      leftKey = state;
      break;
    case 40:  //ABAJO
      if(state && !downKey)  downKey1 = true;
      else if(!state)  downKey1 = false;
      downKey = state;
      break;
    case 39:  //DERECHA
      if(state && !rightKey)  rightKey1 = true;
      else if(!state)  rightKey1 = false;
      rightKey = state;
      break;
    case 76:  //L
      if(state && !lKey)  lKey1 = true;
      else if(!state)  lKey1 = false;
      lKey = state;
      break;
    case 32:  //ESPACIO
      spaceKey = state;
      break;
    default:
      //println("OTRA");
      break;
  }
}

void control(){
  
  if(wKey){
    Players[0].jump = true;
  }else{
    Players[0].jump = false;
  }
  
  if(aKey){
    Players[0].velX = -3;
  }
  if(dKey){
    Players[0].velX = 3;
  }
  if(!aKey && !dKey){
    Players[0].velX = 0;
  }
  if(aKey && dKey){
    Players[0].velX = 0;
  }
}
