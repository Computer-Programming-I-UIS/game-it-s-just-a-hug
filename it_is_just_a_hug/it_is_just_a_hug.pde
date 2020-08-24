/*****************************************************



*****************************************************/

//Librerías
import ddf.minim.*;
Minim minim;

//Tamaño de los Bloques
int sizeBlocks = 32;
//Cantidad de Bloques
int numBlocksX = 35;
int numBlocksY = 18;

//Escena
char scene = 'T';  //'T' = TitleScreen / 'I' = Menu Inicio / 'G' = Juego / 'P' = Pausa / 'C' = Creditos / 'M' = Mapas

//TitleScreen
PImage titleSBackground;
PImage titleSPlayer1;
PImage titleSPlayer2;
int titleSfade = 0;
PImage titleSTitle;
PImage titleSBomb;
boolean showPressSpace = true;
AudioPlayer musicTitleS;
AudioSample soundButton;

//Fuentes
PFont pixelFont;

void setup(){
  //Configuraciones generales
  setupScreen();
  setupPlayers();
  setupBlocks();
  setupButtons();
  
  //TitleScreen
  titleSBackground = loadImage("titleScreen/only_background.png");
  titleSPlayer1 = loadImage("titleScreen/player_azul.png");
  titleSPlayer2 = loadImage("titleScreen/player_rojo.png");
  titleSTitle = loadImage("titleScreen/title.png");
  titleSBomb = loadImage("titleScreen/bombAnimation.png");
  
  pixelFont = createFont("fonts/monogram_extended.ttf",45);
  //pixelFont = loadFont("fonts/8-bitOperatorPlus-Regular-48.vlw");
  
  //Musica
  minim = new Minim(this);
  musicTitleS = minim.loadFile("sounds/8bit-Smooth_Presentation_-_David_Fesliyan.mp3");
  //musicTitleS.setGain(-5);  //Bajar el volumen
  musicTitleS.setGain(-500);  //Bajar el volumen
  soundButton = minim.loadSample("sounds/pcmouseclick2.mp3"); 
  soundButton.setGain(-6);
  
}

void draw(){
  background(0);
  actionButtons();
  
  //Pantalla Inicio
  switch(scene){
    case 'T':  //Pantalla de Título
      if(!musicTitleS.isPlaying())  musicTitleS.loop();  //Inicia reproduciendose en loop
      
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      
      int frameBomb = (frameCount/6)%10;
      copy(titleSBomb, frameBomb*200,0, 200,200, 660,20, 200,200);
      image(titleSTitle, 0,0, titleSTitle.width, titleSTitle.height);
      
      //Texto Presione escacio para continuar
      if(frameCount%25 == 0)  showPressSpace = !showPressSpace;  //Parpadea el texto cada 25 frames
      if(showPressSpace && titleSfade == 0){  //Si no se ha presionado espacio
        textFont(pixelFont);
        fill(0);
        textSize(35);
        textAlign(CENTER,CENTER);
        text("Presione espacio para continuar", width/2, height -height/8);
        
      }
      if(spaceKey && titleSfade == 0){
        titleSfade = 1;
      }
      if(titleSfade != 0)  titleSfade++;
      if(titleSfade >= 40)  scene = 'I';  //Si ya desparecieron los jugadores cambia la escena
      
      image(titleSPlayer1, -titleSfade*10, titleSfade*10, titleSPlayer1.width, titleSPlayer1.height); //Player_Azul
      image(titleSPlayer2, titleSfade*10, titleSfade*10, titleSPlayer2.width, titleSPlayer2.height); //Player_Rojo
      
      break;
    
    case 'I':  //Menu Inicio
      
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      frameBomb = (frameCount/6)%10;
      copy(titleSBomb, frameBomb*200,0, 200,200, 660,20, 200,200);
      image(titleSTitle, 0,0, titleSTitle.width, titleSTitle.height);
      
      for(int b = 0; b < BTitle.length; b++){
        BTitle[b].display();
      }
      break;
    
    case 'G':  //Juego
      if(musicTitleS.isPlaying() && musicTitleS.getGain() < -30){  //Si se está reproduciendo y ya el volumen es muy bajo se pausa
        musicTitleS.pause();
      }
      /*
      if(millis() > 99990){
        Players[0].move = false;
        Players[1].move = false;
      }
      */
      image(backgroundMap, 0,0, backgroundMap.width, backgroundMap.height);  //Imagen del nivel
      
      colPlayers();
      for(int p = 0; p < Players.length; p++){
        Players[p].update();
        Players[p].display();
      }
      
      break;
      
    case 'M':
      
      
      for(int b = 0; b < BMaps.length; b++){
        BMaps[b].display();
      }
      
      
      
      
      break;
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
    case 'I':
      for(int b = 0; b < BTitle.length; b++){
        if(BTitle[b].checkMouse()){
          cursor(HAND);
          break;
        }else{
          cursor(ARROW);
        }
      }
      break;
    
    case 'M':
      for(int b = 0; b < BMaps.length; b++){
        if(BMaps[b].checkMouse()){
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
    case 'I':
      for(int b = 0; b < BTitle.length; b++){
        if(BTitle[b].checkMouse()){
          BTitle[b].changeStatus();
          break;
        }
      }
      break;
      
    case 'M':
      for(int b = 0; b < BMaps.length; b++){
        if(BMaps[b].checkMouse()){
          BMaps[b].changeStatus();
          break;
        }
      }
      break;
    
    default:
        //Nothing
      break;
  }
  
}
