
/*****************************************************



*****************************************************/

//Tamaño de los Bloques
int sizeBlocks = 32;
//Cantidad de Bloques
int numBlocksX = 35;
int numBlocksY = 18;

//Escena
int numScenes = 3;
int scene = 0;  // 0 = Inicio  / 1 = Pantalla Principal  / 2 = Juego



void setup(){
  setupScreen();
  
  setupPlayers();
  setupBlocks();
  setupButtons();
  
  importMap(0);
  inicioSet();
}
void draw(){
  if(!play.checkButton){
  inicioDraw();
  }
  else{
  music.pause();
  juegoDraw();
  }
}

void juegoDraw(){
  //Tiempo bomba
  println(millis());
  if(millis() > 99990){
    Players[0].move = false;
    Players[1].move = false;
  }
  
  /*
  for(int i = 0; i < numBGroundMap; i++){
    Ground[i].display();
  }
  */
  
  //Muestra el fondo
  image(backgroundMap, 0,0, backgroundMap.width, backgroundMap.height);
  
  colPlayers();
  for(int p = 0; p < Players.length; p++){
    Players[p].update();
    Players[p].display();
    //PlayersCol[p].display();
  }
  /*
  for(int i = 0; i < numButtonsScene[scene]; i++){
    Buttons[scene][i].display();
  }*/
  for(int i = 0; i < numBTeleportMap; i++){
    //Teleport[i].display();
  }
}


//Configurar el tamaño de la ventana
void setupScreen(){
  surface.setSize(numBlocksX*sizeBlocks, numBlocksY*sizeBlocks);  //Define el tamaño de la ventana
  surface.setLocation((displayWidth/2) - numBlocksX*sizeBlocks/2, (displayHeight/2) - numBlocksY*sizeBlocks/2 - sizeBlocks);  //Aparezca centrada la ventana
  surface.setTitle("It's just a Hug");  //Título de la ventana
  
  //surface.setResizable(true);
}


//Verificar si existe un archivo dentro de la carpeta "data\"
  //Creditos al usuario "Schred"  https://discourse.processing.org/t/checking-if-a-file-exists-strange-runtime-error/20276/5
boolean fileExists(String fileName, String folder){
  //Para un archivo que está directamente en la carpeta data (folder = "")
  File dataFolder = new File(dataPath(folder));
  
  for (File file : dataFolder.listFiles()) {    //Escanea todos los archivos en la carpeta data  (*Otra sintaxis de for)
    if (file.getName().equals(fileName)){    //Si el nombre del archivo es el mismo del que se necesita
      return true;
    }
  }
  return false;
}

//Obtener el signo de un número
int sign(int num){
  if(num == 0)  return 0;
  else if(num < 0) return -1;
  else  return +1;
}

void mouseMoved(){
  for(int i = 0; i < numButtonsScene[scene]; i++){
    if(Buttons[scene][i].checkMouse()){
      cursor(HAND);
      break;
    }else{
      cursor(ARROW);
    }
  }
  
}

void mousePressed(){
  for(int i = 0; i < numButtonsScene[scene]; i++){
    if(Buttons[scene][i].checkMouse()){
      Buttons[scene][i].changeStatus();
      break;
    }
  }
}

void keyTyped(){
  scene++;
  if(scene == numScenes)  scene = 0;
}
