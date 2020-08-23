/*****************************************************



*****************************************************/

//Tamaño de los Bloques
int sizeBlocks = 32;
//Cantidad de Bloques
int numBlocksX = 35;
int numBlocksY = 18;

//Escena
char scene = 'T';  //'T' = TitleScreen / 'M' = Menu / 'G' = Juego / 'P' = Pausa / 'C' = Creditos

//TitleScreen
PImage titleSBackground;
PImage titleSTitle;
PImage titleSBomb;
boolean showPressSpace = true;

//Fuentes
PFont pixelFont;

void setup(){
  //Configuraciones generales
  setupScreen();
  setupPlayers();
  setupBlocks();
  setupButtons();
  
  //TitleScreen
  titleSBackground = loadImage("HomeSreen/Pantallad de inicio fondo principal.png");
  titleSTitle = loadImage("HomeSreen/Pantalla de inicio Titulo.png");
  titleSBomb = loadImage("HomeSreen/Bomba animada Sprite.png");
  
  pixelFont = loadFont("8-bitOperatorPlus-Regular-48.vlw");
  
  
}
void draw(){
  background(0);
  actionButtons();
  //Pantalla Inicio
  switch(scene){
    case 'T':  //Pantalla de Título
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      int frameBomb = (frameCount/6)%10;
      copy(titleSBomb, frameBomb*200,0, 200,200, 660,20, 200,200);
      image(titleSTitle, 0,0, titleSTitle.width, titleSTitle.height);
      
      //Texto Presione escacio para continuar
      if(frameCount%25 == 0)  showPressSpace = !showPressSpace;
      if(showPressSpace){
        textFont(pixelFont);
        fill(0);
        textSize(25);
        textAlign(CENTER,CENTER);
        text("Presione espacio para continuar", width/2, height -height/8);
      }
      
      if(spaceKey)
        scene = 'M';
      
      break;
    
    case 'M':  //Menu
      
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      frameBomb = (frameCount/6)%10;
      copy(titleSBomb, frameBomb*200,0, 200,200, 660,20, 200,200);
      image(titleSTitle, 0,0, titleSTitle.width, titleSTitle.height);
      
      for(int b = 0; b < BTitle.length; b++){
        BTitle[b].display();
      }
      break;
    
    case 'G':  //Juego
      if(millis() > 99990){
        Players[0].move = false;
        Players[1].move = false;
      }
      
      image(backgroundMap, 0,0, backgroundMap.width, backgroundMap.height);  //Imagen del nivel
      
      colPlayers();
      for(int p = 0; p < Players.length; p++){
        Players[p].update();
        Players[p].display();
      }
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
  switch(scene){
    case 'M':
      for(int b = 0; b < BTitle.length; b++){
        if(BTitle[b].checkMouse()){
          cursor(HAND);
          break;
        }else{
          cursor(ARROW);
        }
      }
      break;
      
    default:
        //Nothing
      break;
  }
  
}

void mousePressed(){
  switch(scene){
    case 'M':
      for(int b = 0; b < BTitle.length; b++){
        if(BTitle[b].checkMouse()){
          BTitle[b].changeStatus();
          break;
        }
      }
      break;
      
    default:
        //Nothing
      break;
  }
  
}
