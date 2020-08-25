//Player 1
boolean wKey, wKey1;
boolean aKey, aKey1;
boolean dKey, dKey1;

//Player 2
boolean upKey, upKey1;
boolean leftKey, leftKey1;
boolean rightKey, rightKey1;

boolean spaceKey;
boolean scapeKey;

void keyPressed(){
  
  if(key == 27){  //Si se presiona escape
    key = 0;  //Al convertirla a cero, evita que processing cierre la aplicación, como lo hace por defecto
    scapeKey = true;
    /*
    if(pauseIsPosible){
      if(!pause){  //Si no estaba pausado, guarda en que escena estaba
        lastScene = scene;
      }else{  //Si estba pausado, restaura la escena en la que estaba
        scene = lastScene;
      }
      pause = !pause;
    }
    */
  }
  
  keyControl(keyCode, true);
}

void keyReleased(){
  keyControl(keyCode, false);
  if(key == 27){  //Si se presiona escape
    key = 0;  //Al convertirla a cero, evita que processing cierre la aplicación, como lo hace por defecto
    scapeKey = false;
  }
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
    case 68:  //D
      if(state && !dKey)  dKey1 = true;
      else if(!state)  dKey1 = false;
      dKey = state;
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
    case 39:  //DERECHA
      if(state && !rightKey)  rightKey1 = true;
      else if(!state)  rightKey1 = false;
      rightKey = state;
      break;
    case 32:  //ESPACIO
      spaceKey = state;
      break;
    default:
      //Otra
      break;
  }
}

void controlPlayers(){
  //Player 1
  if(wKey)  Players[0].jump = true;
  else  Players[0].jump = false;
  
  if(aKey)  Players[0].velX = -Players[0].velXMax;
  if(dKey)  Players[0].velX = Players[0].velXMax;
  if(!aKey && !dKey)  Players[0].velX = 0;
  if(aKey && dKey)  Players[0].velX = 0;
  
  //Player 2
  if(upKey)  Players[1].jump = true;
  else  Players[1].jump = false;
  
  if(leftKey)  Players[1].velX = -Players[1].velXMax;
  if(rightKey)  Players[1].velX = Players[1].velXMax;
  if(!leftKey && !rightKey)  Players[1].velX = 0;
  if(leftKey && rightKey)  Players[1].velX = 0;
  
}
