/*****************************************************

------------------------It's Just a Hug------------------------

Autores: Sebastián García Angarita
         Juan Sebastian Guerrero Peña
Fecha: 26/Agosto/2020

Descripción: Este proyecto fue realizado como Proyecto Final de la materia Programación de Computadores I.
             
             VideoJuego para dos jugadores donde cada uno tiene la misión de deshacerse de la bomba,
             para hacerlo deberá pegársela a su compañero y salir corriendo para no ser atrapado de nuevo.
             Cuando la partida comienza arriba a la derecha hay un temporizador de 60 segundos, cuando el
             tiempo acabe el jugador que tenga la bomba en la mano le explotará y su contrincante ganara
             un punto y pasará otro mapa aleatorio.

*Requiere libreria Minim
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
char scene = 'E';  //'T' = TitleScreen / 'I' = Menu Inicio / 'G' = Juego / 'M' = Mapas / 'E' = Editor de Mapas / 'C' = Creditos / 'H' = ¿Cómo Jugar?

//TitleScreen
PImage titleSBackground;
PImage titleSPlayer1;
PImage titleSPlayer2;
int titleSfade = 0;
PImage titleSTitle;
PImage titleSBomb;
PImage titleHow;
boolean showPressSpace = true;

//Fuentes
PFont pixelFont;

//Contador
int frameBomb = 0;
int timerMax = 60;  //Tiempo que dura la bomba
int timer = timerMax;
int secondsTimer = 0;  //Variable para saber si ha transcurrido un segundo
int timeMaxAfterExplosion = 4;
int timeAfterExplosion = timeMaxAfterExplosion;

//Cantidad máxima de niveles
int numMaxMaps = 6;

//Sonidos
AudioPlayer musicTitleS;
AudioPlayer musicGame;
AudioSample soundButton;
AudioSample soundExplosion;

//Editor de mapas
boolean showGrid = false;
int numMap = 0;


void setup(){
  //Configuraciones generales
  setupScreen(false);
  setupPlayers();
  setupBlocks();
  setupButtons();
  //Editor
  setupBlocksEditor();
  setupTiles();
  
  
  //TitleScreen
  titleSBackground = loadImage("titleScreen/only_background.png");
  titleSPlayer1 = loadImage("titleScreen/player_azul.png");
  titleSPlayer2 = loadImage("titleScreen/player_rojo.png");
  titleSTitle = loadImage("titleScreen/title.png");
  titleSBomb = loadImage("titleScreen/bombAnimation.png");
  titleHow = loadImage("titleScreen/pantalla controles.png");
  
  pixelFont = createFont("fonts/monogram_extended.ttf",45);
  //pixelFont = loadFont("fonts/8-bitOperatorPlus-Regular-48.vlw");
  
  //Musica
  minim = new Minim(this);
  musicTitleS = minim.loadFile("sounds/8bit-Smooth_Presentation_-_David_Fesliyan.mp3");
  musicTitleS.setGain(-40);  //Bajar el volumen
  soundButton = minim.loadSample("sounds/pcmouseclick2.mp3"); 
  soundButton.setGain(-20);
  soundExplosion = minim.loadSample("sounds/explosion.mp3");
  soundExplosion.setGain(-5);
  musicGame = minim.loadFile("sounds/Never_Surrender.mp3");
  musicGame.setGain(-40);
  
  //Importa un nivel cualquiera
  importMap(2);
  
  //Importar los fondos de los niveles
  for(int i = 0; i < backgroundsFilesNames.length; i++){
    if(!fileExists(backgroundsFilesNames[i], "backgrounds")){
      println("¡ERROR!");
      println("El archivo",backgroundsFilesNames[i],"NO existe");
      exit();
    }else{
      backgroundsImages[i] = loadImage("data/backgrounds/"+backgroundsFilesNames[i]);
    }
  }
}

void draw(){
  //background(0);
  actionButtons();
  
  //Pantalla Inicio
  switch(scene){
    case 'T':  //Pantalla de Título
      if(!musicTitleS.isPlaying()){
        musicTitleS.loop();  //Inicia reproduciendose en loop
        musicTitleS.shiftGain(musicTitleS.getGain(),-15, 2500);  //Fade-In
      }if(musicGame.isPlaying() && musicGame.getGain() < -30)  musicGame.pause();
      
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      
      frameBomb = (frameCount/6)%10;
      copy(titleSBomb, frameBomb*200,0, 200,200, 660,20, 200,200);
      image(titleSTitle, 0,0, titleSTitle.width, titleSTitle.height);
      
      //Texto Presione escacio para continuar
      if(frameCount%25 == 0)  showPressSpace = !showPressSpace;  //Parpadea el texto cada 25 frames
      if(showPressSpace && titleSfade == 0){  //Si no se ha presionado espacio
        textFont(pixelFont);
        fill(80);
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
      setupScreen(false);
      if(!musicTitleS.isPlaying()){
        musicTitleS.loop();
        musicTitleS.shiftGain(musicTitleS.getGain(),-15, 2500);  //Fade-In
      }if(musicGame.isPlaying() && musicGame.getGain() < -30)  musicGame.pause();
      
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
      }if(!musicGame.isPlaying())  musicGame.loop();
      
      image(backgroundMap, 0,0, backgroundMap.width, backgroundMap.height);  //Imagen del nivel
      
      for(int t = 0; t <= numBTeleportMap; t++){  //Imagen de los Teleports
        Teleport[t].display();
      }
      
      //Jugadores
      for(int p = 0; p < Players.length; p++){
        Players[p].update();
        Players[p].display();
      }
      
      //Tiempo
      
      if(secondsTimer != second()){  //Actualizar el tiempo cada segundo
        secondsTimer = second();
        timer--;
        timer = constrain(timer, 0, timerMax);
        if(Players[playerBomb].kaboom){
          timeAfterExplosion--;
          if(timeAfterExplosion == 0){
            int _map;
            do{
              _map = round(random(1,numMaxMaps));
            }while(_map == pastMap);  //Para que el mapa no sea el mismo que se jugó antes
            pastMap = _map;
            importMap(_map);
            
          }
        }
      }if(timer == 0 && !Players[playerBomb].kaboom){  //Se acabó el tiempo
        Players[0].move = false;
        Players[1].move = false;
        Players[playerBomb].kaboom();
        soundExplosion.trigger();
      }
      frameBomb = (frameCount/6)%10;
      copy(titleSBomb, frameBomb*200,0, 200,200, 16,16, 64,64);  //Imagen de la bomba
      
      textFont(pixelFont);
      textSize(40);
      fill(255);
      textAlign(CENTER,CENTER);
      text(nf(timer,2),46,46);  //Muestra el tiempo encima de la bomba
      
      if(scapeKey){
        scene = 'I';
        musicGame.shiftGain(musicGame.getGain(),-40, 2500);  //Fade-Out
      }
      break;
      
    case 'M':  //Selector de mapas
      if(!musicTitleS.isPlaying()){
        musicTitleS.loop();
        musicTitleS.shiftGain(musicTitleS.getGain(),-15, 2500);  //Fade-In
      }if(musicGame.isPlaying() && musicGame.getGain() < -30)  musicGame.pause();
      
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      BMaps[mapMapSelected].display();
      BMapSelector[0].display();  //Mapa anterior
      BMapSelector[1].display();  //Mapa siguiente
      
      if(scapeKey)  scene = 'I';
      break;
      
    case 'E':
      setupScreen(true);
      image(backgroundsImages[0],0,0,backgroundsImages[0].width,backgroundsImages[0].height);  //Fondo del nivel
      
      //Mostrar los Bloques
      for(int i = 0; i < BlocksE.length; i++){
        for(int j = 0; j < BlocksE[i].length; j++){
          BlocksE[i][j].display();
        }
      }
      for(int i = 0; i < BlocksE.length; i++){
        for(int j = 0; j < BlocksE[i].length; j++){
          if(BlocksE[i][j].type == 1 || BlocksE[i][j].type == 1)  BlocksE[i][j].display();  //Muestra a los jugadores encima de los bloques
        }
      }
      
      //Mostrar Botones
      noStroke();
      fill(100);
      rect(numBlocksX*sizeBlocks, 0, sizeBlocks*5, height);
      fill(255);
      rect((numBlocksX+0.5)*sizeBlocks, sizeBlocks/2, sizeBlocks*4, (numBlocksY-1)*sizeBlocks);
      
      for(int b = 0; b < EButtons.length; b++){
        EButtons[b].display();
      }
      for(int b = 0; b < TButtons.length; b++){
        TButtons[b].display();
      }
      actionButtons();
      
      //Cuadrícula
      if(showGrid)  showGrid();
      
      if(scapeKey)  scene = 'I';
      break;
    
    case 'C':  //Créditos
      if(!musicTitleS.isPlaying()){
        musicTitleS.loop();
        musicTitleS.shiftGain(musicTitleS.getGain(),-15, 2500);  //Fade-In
      }if(musicGame.isPlaying() && musicGame.getGain() < -30)  musicGame.pause();
      
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      
      textFont(pixelFont);
      textSize(40);
      fill(0);
      textAlign(CENTER, TOP);
      text("CRÉDITOS",width/2, sizeBlocks);
      
      textSize(35);  fill(100);
      text("Programación", width/2, 3*sizeBlocks);
      textSize(30);  fill(0);
      text("Sebastián García Angarita\nJuan Sebastian Guerrero Peña (Konat)", width/2, 4*sizeBlocks);
      
      textSize(35);  fill(100);
      text("Gráficos", width/2, 6*sizeBlocks);
      textSize(30);  fill(0);
      text("Juan Sebastian Guerrero Peña (Konat)", width/2, 7*sizeBlocks);
      
      textSize(35);  fill(100);
      text("Música", width/2, 8*sizeBlocks);
      textSize(30);  fill(0);
      text("Fesliyan Studios music www.fesliyanstudios.com\n Patrick de Arteaga patrickdearteaga.com", width/2, 9*sizeBlocks);
      
      textSize(35);  fill(100);
      text("Efectos Sonoros", width/2, 11*sizeBlocks);
      textSize(30);  fill(0);
      text("Partners in Rhyme www.PartnersInRhyme.com\nFree Sound Effects www.freesoundeffects.com", width/2, 12*sizeBlocks);
      
      textSize(35);  fill(100);
      text("Agradecimientos", width/2, 14*sizeBlocks);
      textSize(30);  fill(0);
      text("Alex Julián Mantilla Ríos - Tutor de la Universidad Industrial de Santander\nCamilo Eduardo Rojas - Profesor de la Universidad Industrial de Santander", width/2, 15*sizeBlocks);
      
      if(scapeKey)  scene = 'I';
      break;
      
    case 'H':  //Cómo jugar
      if(!musicTitleS.isPlaying()){
        musicTitleS.loop();
        musicTitleS.shiftGain(musicTitleS.getGain(),-15, 2500);  //Fade-In
      }if(musicGame.isPlaying() && musicGame.getGain() < -30)  musicGame.pause();
      
      image(titleHow, 0,0, titleSBackground.width, titleSBackground.height);
      if(scapeKey) scene = 'I';
      break;
    
  }
}



//Configurar el tamaño de la ventana
void setupScreen(boolean mapEditor){
  int sizeScreenX = numBlocksX;
  if(mapEditor)  sizeScreenX = numBlocksX+5;
  
  surface.setSize((sizeScreenX)*sizeBlocks, numBlocksY*sizeBlocks);  //Define el tamaño de la ventana
  surface.setLocation((displayWidth/2) - sizeScreenX*sizeBlocks/2, (displayHeight/2) - (numBlocksY+2)*sizeBlocks/2);  //Aparezca centrada la ventana
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
          for(int i = b; i < BTitle.length; i++){  //Desactiva todos los otros botones para que no aparezcan dos seleccionados
            if(i != b)  BTitle[i].mslc = false;
          }
          break;
        }else{
          cursor(ARROW);
        }
      }
      break;
    
    case 'M':
      if(BMaps[mapMapSelected].checkMouse()){
        cursor(HAND);
        for(int i = 0; i < BMaps.length; i++){
          if(i != mapMapSelected)  BMaps[i].mslc = false;
        }
      }else if(BMapSelector[0].checkMouse() || BMapSelector[1].checkMouse()){
        cursor(HAND);
      }else{
        cursor(ARROW);
      }
      break;
    
    case 'E':
      for(int b = 0; b < TButtons.length; b++){
        if(TButtons[b].checkMouse()){
          cursor(HAND);
          for(int i = b; i < TButtons.length; i++){  //Desactiva todos los otros botones para que no aparezcan dos seleccionados
            if(i != b)  TButtons[i].mslc = false;
          }
          break;
        }else  cursor(ARROW);
      }
      for(int b = 0; b < EButtons.length; b++){
        if(EButtons[b].checkMouse()){
          cursor(HAND);
          for(int i = b; i < EButtons.length; i++){
            if(i != b)  EButtons[i].mslc = false;
          }
          break;
        }else  cursor(ARROW);
      }
      
      break;
    
    default:
        cursor(ARROW);
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
      if(BMaps[mapMapSelected].checkMouse())  BMaps[mapMapSelected].changeStatus();
      else if(BMapSelector[0].checkMouse())  mapMapSelected--;
      else if(BMapSelector[1].checkMouse())  mapMapSelected++;
      mapMapSelected = constrain(mapMapSelected, 0, numMaxMaps -1);
      break;
    
    case 'E':
      //Botones
      for(int b = 0; b < TButtons.length; b++){
        if(TButtons[b].checkMouse()){
          TButtons[b].changeState();
          break;
        }
      }
      for(int b = 0; b < EButtons.length; b++){
        if(EButtons[b].checkMouse()){
          EButtons[b].changeState();
          break;
        }
      }
      break;
    
    default:
        //Nothing
      break;
  }
  
}
