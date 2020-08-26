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
char scene = 'C';  //'T' = TitleScreen / 'I' = Menu Inicio / 'G' = Juego / 'M' = Mapas /  / 'C' = Creditos / 'H' = ¿Cómo Jugar?

//TitleScreen
PImage titleSBackground;
PImage titleSPlayer1;
PImage titleSPlayer2;
int titleSfade = 0;
PImage titleSTitle;
PImage titleSBomb;
PImage titleHow;
boolean showPressSpace = true;
AudioPlayer musicTitleS;
AudioSample soundButton;

//Fuentes
PFont pixelFont;

//Contador
int frameBomb = 0;
int timerMax = 60;  //Tiempo que dura la bomba
int timer = timerMax;
int secondsTimer = 0;  //Variable para saber si ha transcurrido un segundo
int timeMaxAfterExplosion = 5;
int timeAfterExplosion = timeMaxAfterExplosion;

//Cantidad máxima de niveles
int numMaxMaps = 6;

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
  titleHow = loadImage("titleScreen/pantalla controles.png");
  
  pixelFont = createFont("fonts/monogram_extended.ttf",45);
  //pixelFont = loadFont("fonts/8-bitOperatorPlus-Regular-48.vlw");
  
  //Musica
  minim = new Minim(this);
  musicTitleS = minim.loadFile("sounds/8bit-Smooth_Presentation_-_David_Fesliyan.mp3");
  musicTitleS.setGain(-10);  //Bajar el volumen
  //musicTitleS.setGain(-500);
  soundButton = minim.loadSample("sounds/pcmouseclick2.mp3"); 
  soundButton.setGain(-15);
  //soundButton.setGain(-500);
  
  //Importa un nivel cualquiera
  importMap(2);
}

void draw(){
  background(0);
  actionButtons();
  
  //Pantalla Inicio
  switch(scene){
    case 'T':  //Pantalla de Título
      if(!musicTitleS.isPlaying())  musicTitleS.loop();  //Inicia reproduciendose en loop
      
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
      if(!musicTitleS.isPlaying())  musicTitleS.loop();
      
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
      
      image(backgroundMap, 0,0, backgroundMap.width, backgroundMap.height);  //Imagen del nivel
      
      for(int t = 0; t < numBTeleportMap; t++){  //Imagen de los Teleports
        Teleport[t].display();
      }
      
      //Jugadores
      for(int p = 0; p < Players.length; p++){
        Players[p].update();
        Players[p].display();
      }
      
      //Tiempo
      frameBomb = (frameCount/6)%10;
      copy(titleSBomb, frameBomb*200,0, 200,200, 16,16, 64,64);  //Imagen de la bomba
      
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
            
            //scene = 'I';
          }
        }
      }if(timer == 0 && !Players[playerBomb].kaboom){  //Se acabó el tiempo
        Players[0].move = false;
        Players[1].move = false;
        Players[playerBomb].kaboom();
      }
      textFont(pixelFont);
      textSize(40);
      fill(255);
      textAlign(CENTER,CENTER);
      text(nf(timer,2),46,46);  //Muestra el tiempo encima de la bomba
      
      if(scapeKey)  scene = 'I';
      break;
      
    case 'M':  //Selector de mapas
      if(!musicTitleS.isPlaying())  musicTitleS.loop();
      
      image(titleSBackground, 0,0, titleSBackground.width, titleSBackground.height); //Fondo
      BMaps[mapMapSelected].display();
      BMapSelector[0].display();  //Mapa anterior
      BMapSelector[1].display();  //Mapa siguiente
      
      
      if(scapeKey)  scene = 'I';
      break;
      
    case 'C':  //Créditos
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
      text("8 Bit Presentation por David Fesliyan", width/2, 9*sizeBlocks);
      
      textSize(35);  fill(100);
      text("Efectos Sonoros", width/2, 11*sizeBlocks);
      textSize(30);  fill(0);
      text("Partners in Rhyme", width/2, 12*sizeBlocks);
      
      
      
      textSize(35);  fill(100);
      text("Agradecimientos", width/2, 13*sizeBlocks);
      textSize(30);  fill(0);
      text("Alex Julián Mantilla Ríos - Tutor de la Universidad Industrial de Santander\nCamilo Eduardo Rojas - Profesor de la Universidad Industrial de Santander", width/2, 14*sizeBlocks);
      
      if(scapeKey)  scene = 'I';
      break;
      
    case 'H':  //Cómo jugar
      image(titleHow, 0,0, titleSBackground.width, titleSBackground.height);
      if(scapeKey) scene = 'I';
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
    
    default:
        //Nothing
      break;
  }
  
}
