
buttonMenu [] BTitle = new buttonMenu[5];
button [] BMaps = new button[10];
button [] BMapSelector = new button[3];
int mapMapSelected = 0;  //Mapa que se muestra en el selector de mapas


buttonEditor [] EButtons = new buttonEditor[3];
buttonC xErrorE;  //X para cerrar los errores del editor
int tileSelected = 0;  //Almacena el tipo de tipo de tile seleccionado en el editor de mapas

void setupButtons(){
  //Pantalla Inicio
  textSize(50);
  int dyButtons = round(textAscent()) + 5;
  BTitle[0] = new buttonMenu(width/2 - 2*round(textWidth("Jugar")/4), height/2, 2*round(textWidth("Jugar")/2), round(textAscent()), "Jugar");
  BTitle[1] = new buttonMenu(width/2 - 2*round(textWidth("Mapas")/4), height/2 + dyButtons, 2*round(textWidth("Mapas")/2), round(textAscent()), "Mapas");
  BTitle[2] = new buttonMenu(width/2 - 2*round(textWidth("Créditos")/4), height/2 + 2*dyButtons, 2*round(textWidth("Créditos")/2), round(textAscent()), "Créditos");
  BTitle[3] = new buttonMenu(width/2 - 2*round(textWidth("¿Cómo Jugar?")/4), height/2 + 3*dyButtons, 2*round(textWidth("¿Cómo Jugar?")/2), round(textAscent()), "¿Cómo Jugar?");
  BTitle[4] = new buttonMenu(width/2 - 2*round(textWidth("Salir")/4), height/2 + 4*dyButtons, 2*round(textWidth("Salir")/2), round(textAscent()), "Salir");
  
  //Selector de mapas
  for(int b = 0; b < BMaps.length; b++){
    BMaps[b] = new button(3*sizeBlocks, 3*sizeBlocks/2, (numBlocksX-6)*sizeBlocks, 15*sizeBlocks, "map"+(b+1)+".png", "maps");
  }
  BMapSelector[0] = new button(sizeBlocks/2, (height/2)-3*sizeBlocks/2, 2*sizeBlocks, 3*sizeBlocks, 1, 1, "-");  //Mapa Anterior
  BMapSelector[1] = new button(width-5*sizeBlocks/2, (height/2)-3*sizeBlocks/2, 2*sizeBlocks, 3*sizeBlocks, 1, 1, "+");  //Mapa Siguiente
  
  BMapSelector[2] = new button(width-5*sizeBlocks/2, (height/2)+2*sizeBlocks, 2*sizeBlocks, sizeBlocks, 1, 1, "EDITAR");  //Nuevo Mapa
  BMapSelector[2].sizeTxt = 20;
  
  
  //Editor de mapas
  int xButtons = (numBlocksX + 1) * sizeBlocks + 2;
  int yButtons = 3*sizeBlocks;
  int dxButtons = sizeBlocks;  //Separacion de los botones
  
  int xButton = 0;
  int yButton = +2;
  
  EButtons[0] = new buttonEditor(xButtons + xButton, yButtons + yButton, 3*sizeBlocks -4, sizeBlocks -4, "CUADRÍCULA");  //Cuadrícula
  yButton += dxButtons;
  EButtons[2] = new buttonEditor(xButtons + xButton, yButtons + yButton, 3*sizeBlocks - 4, sizeBlocks -4, "FONDO");  //Background
  yButton += dxButtons;
  EButtons[1] = new buttonEditor(xButtons + xButton, yButtons + yButton, 3*sizeBlocks - 4, sizeBlocks -4, "GUARDAR");  //Export
  
  xErrorE = new buttonC((numBlocksX/2)*sizeBlocks + 8*sizeBlocks, (numBlocksY/2)*sizeBlocks - 3*sizeBlocks/2, 2*sizeBlocks/3, "X");  //Cerrar del mensaje de error
  
  //Tiles
  xButton = 0;
  yButton += dxButtons;
  for(int b = 0; b < TButtons.length; b++){
    TButtons[b] = new buttonEditor(xButtons + xButton, yButtons + yButton, sizeBlocks - 4, b);
    xButton += dxButtons;
    if(xButton == 3*dxButtons){
      xButton = 0;
      yButton += dxButtons;
    }
    
  }
}


class button{
  //Posición
  int x, y;
  int sizeX, sizeY;
  
  //Función
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  int status = 0;  //estado en el que está (presionado o no) ó (0,1,2,3,4...)
  int numStatus;  //Numero de posiciones en las que puede estar el botón 
  
  //Apariencia
  PImage imageB;
  color [] colorB = {color(#358C42),color(#40280A)};
  int colorS = 0;  //Color seleccionado
  String [] info;  //Almacena el texto que se muestra en cada estado
  //int sizeTxt = 13;
  int sizeTxt = 30;
  boolean soundCheck = false;  //Para que no se repita el sonido
  
  String folder;
  String imageName;
  
  //Cuando el botón NO tiene imagen
  button(int _x, int _y, int _sizeX, int _sizeY, int _numStatus, int _ColorS, String _info1){
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    
    numStatus = _numStatus;;
    info = new String [numStatus];
    info[0] = _info1;
    
    colorS = constrain(_ColorS, 0, colorB.length);
    imageB = null;
  }
  
  //Cuando el botón tiene imagen y solo una opción 
  button(int _x, int _y, int _sizeX, int _sizeY, String _imageName, String _folder){
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    
    numStatus = 1;
    info = null;
    
    imageName = _imageName;
    folder = _folder;
    
    if(!fileExists(imageName, folder)){  //Si no existe
      println("¡ERROR!");
      println("El archivo",imageName,"NO existe o no se ecuentra en la carpeta \"data\\",folder,"\\\"");
      println("Revisa el nombre del archivo y la carpeta \"data\\",folder,"\\\"");
      exit();
    }else{
      imageB = loadImage("data/"+folder+"/"+imageName);
    }
  }
  
  void setInfo(int _i, String _info){
    _i = constrain(_i, 0, numStatus -1);
    info[_i] = _info;
  }
  
  boolean checkMouse(){
    if(mouseX > x && mouseX < x + sizeX && mouseY > y && mouseY < y + sizeY){  //Si el puntero está sobre el botón
      mslc = true;
      if(!soundCheck){
        soundButton.trigger();
        soundCheck = true;
      }
      return true;
    }else{
      mslc = false;
      soundCheck = false;
      return false;
    }
  }
  
  int changeStatus(){
    prsd = !prsd;
    status++;
    if(status == numStatus)  status = 0;  //Se resetea al llegar al máximo
    return status;
  }
  
  void display(){
    
    if(mslc){
      stroke(255);
      strokeWeight(4);  //Si el mouse está sobre el botón
    }else{
      stroke(150);
      strokeWeight(1);
    }
    
    fill(colorB[colorS]);
    rect(x, y, sizeX, sizeY);  //Dibuja el botón
    
    if(info != null){
      if(numStatus == 1 && info[0] == "+"){
        stroke(255);
        strokeWeight(5);
        strokeJoin(MITER);
        line(x + sizeX/4, y + sizeY/4, x + 3*sizeX/4, y + sizeY/2);
        line(x + sizeX/4, y + 3*sizeY/4, x + 3*sizeX/4, y + sizeY/2);
        
      }else if(numStatus == 1 && info[0] == "-"){
        stroke(255);
        strokeWeight(5);
        strokeJoin(MITER);
        line(x + sizeX/4, y + sizeY/2, x + 3*sizeX/4, y + sizeY/4);
        line(x + sizeX/4, y + sizeY/2, x + 3*sizeX/4, y + 3*sizeY/4);
        
      }else{
        fill(255);
        textFont(pixelFont);
        textSize(sizeTxt);
        textAlign(CENTER,CENTER);
        text(info[status], x + sizeX/2, y + sizeY/2);
      }
      
    }else{
      image(imageB, x+2, y+2, sizeX-4, sizeY-4);
    }
    
  }
}


class buttonMenu extends button{
  boolean soundCheck = false;
  
  buttonMenu(int _x, int _y, int sx, int sy, String _info1){
    super(_x, _y, sx, sy, 1, 0, _info1);
    sizeTxt = 60;
  }
  
  void display(){
    textFont(pixelFont);
    if(mslc){
      textSize(sizeTxt +5);
      fill(255,0,0);
      
      //Sonidos
      if(!soundCheck){
        soundButton.trigger();
        soundCheck = true;
      }
    }else{
      textSize(sizeTxt);
      fill(255);
      soundCheck = false;
    }
    
    
    textAlign(CENTER,CENTER);
    text(info[status], x + sizeX/2, y + sizeY/2);
  }
}


class buttonEditor{
  int x, y;
  int sizeX, sizeY;
  int type;
  
  color Color1 = color(255,255,0);  //Color del borde cuando no está selecionado
  color Color2 = color(255,0,0);  //Cuando el tile selecionado es el mismo del del boton
  
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  
  String info;
  
  //Para los tiles
  buttonEditor(int _x, int _y, int _size, int _type){
    x = _x;
    y = _y;
    sizeX = _size;
    sizeY = _size;
    type = _type;
    info = null;
  }
  //Para el cuadrícula, guardar, etc
  buttonEditor(int _x, int _y, int _sizeX, int _sizeY, String _info){
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    info = _info;
  }
  
  boolean checkMouse(){
    if(mouseX > x && mouseX < x + sizeX && mouseY > y && mouseY < y + sizeY){  //Si el puntero está sobre el botón
      mslc = true;
      return true;
    }else{
      mslc = false;
      return false;
    }
  }
  
  void changeState(){
    prsd = !prsd;
  }
  
  void display(){
    //Borde del botón
    if(info == null && type == tileSelected)  stroke(Color2);  //Si el tile seleccionado es el mismo del boton lo colorea de otro color
    else  stroke(Color1);
    if(mslc)  strokeWeight(3);  //Si el mouse está sobre el botón, el borde es más grueso
    else  strokeWeight(1.5);
    
    //Dibujar botón
    fill(250);
    rect(x, y, sizeX, sizeY);
    if(info == null && Tiles[type].tileImage != null){  //Si es un botón de tile y ese tile SÍ tiene imagen
      copy(Tiles[type].tileImage, Tiles[type].defaultTile[0], Tiles[type].defaultTile[1], sizeBlocks,sizeBlocks, x,y, sizeX,sizeY);  //Pone la imagen del tile que corresponde
    }
    //Texto
    if(info != null){
      fill(0);
      textAlign(CENTER, CENTER);
      textFont(pixelFont);
      textSize(20);
      text(info,x + sizeX/2, y + sizeY/2 -2);
    }
    if(Tiles[type].letter == 'P'){  //Si es un teleport
      int numTeleports = 0;
      
      for(int i = 0; i < BlocksE.length; i++){
        for(int j = 0; j < BlocksE[i].length; j++){
          if(Tiles[BlocksE[i][j].type].letter == 'P')  numTeleports++;
        }
      }
      
      fill(255);
      textAlign(CENTER, CENTER);
      textFont(pixelFont);
      textSize(35);
      text(Teleport.length-numTeleports,x + sizeX/2 +2, y + sizeY/2 -5);
    }
    
  }
  
}

class buttonC extends buttonEditor{
  
  buttonC(int _x, int _y, int _size, String _info){
    super(_x, _y, _size, _size, _info);
  }
  
  boolean checkMouse(){
    if(dist(mouseX, mouseY, x, y) <= sizeX/2){  //Si el puntero está sobre el botón circular
      mslc = true;
      return true;
    }else{
      mslc = false;
      return false;
    }
  }
  void display(){
    fill(255,0,0);
    strokeWeight(0.5);
    stroke(255);
    circle(x,y,sizeX);
    
    if(info == "X"){
      stroke(255);
      strokeWeight(1);
      line(x-3, y-3, x+3, y+3);
      line(x-3, y+3, x+3, y-3);
    }
  }
  
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void actionButtons(){
  //----------------------Pantalla inicio----------------------//
  if(scene == 'I'){
    //Jugar
    if(BTitle[0].prsd){
      int _map;
      boolean _mapEmpty = false;
      int _pastMap = pastMap;
      do{
        _mapEmpty = false;
        _map = round(random(1,numMaxMaps));
        importMap(_map);
        if(numBGroundMap < 1)  _mapEmpty = true;  
      }while(_map == _pastMap || _mapEmpty);  //Para que el mapa no sea el mismo que se jugó antes
      
      importMap(_map);
      Players[0].resetScore();
      Players[1].resetScore();
      
      musicTitleS.shiftGain(musicTitleS.getGain(),-40, 2500);  //Fade-out
      musicGame.shiftGain(musicGame.getGain(),-20, 2500);  //Fade-in
      
      scene = 'G';
      BTitle[0].prsd = false;
    }
    //Mapas
    if(BTitle[1].prsd){
      //Vuelve a cargar las imágenes de los mapas
      for(int b = 0; b < BMaps.length; b++){
        BMaps[b].imageB = loadImage("data/"+BMaps[b].folder+"/"+BMaps[b].imageName);
      }
      mapMapSelected = 0;  //Reaparece en el mapa 1
      scene = 'M';
      BTitle[1].prsd = false;
    }
    //Créditos
    if(BTitle[2].prsd){
      
      scene = 'C';
      BTitle[2].prsd = false;
    }
    
    //ComoJugar
    if(BTitle[3].prsd){
      scene = 'H';
      BTitle[3].prsd = false;
    }
    //Salir
    if(BTitle[4].prsd){
      exit();  //Acaba el Programa
      BTitle[4].prsd = false;
    }
    
  }
  
  //----------------------Selector de Mapas----------------------//
  if(scene == 'M'){
    for(int b = 0; b < BMaps.length; b++){
      if(BMaps[b].prsd){
        importMap(b+1);  //Importa el mapa seleccionado
        Players[0].resetScore();
        Players[1].resetScore();
        
        musicTitleS.shiftGain(musicTitleS.getGain(),-40, 2500);  //Fade-out
        musicGame.shiftGain(musicGame.getGain(),-20, 2500);  //Fade-in
        
        scene = 'G';  //Inicia el juego
        BMaps[b].prsd = false;
        break;
      }
    }
    
    if(BMapSelector[2].prsd){  //Editar mapa
      musicTitleS.shiftGain(musicTitleS.getGain(),-40, 2500);  //Fade-out
      numMap = mapMapSelected+1;  //Como mapMapSelected es el index en el array y los mapas empiezan en 1
      //Importa la configuración de ese mapa
      importSettingsMap(numMap);
      updateBlocksE();
      
      //Cambia a la escena del editor de mapas
      setupScreen(true);
      scene = 'E';
      BMapSelector[2].prsd = false;
    }
  }
  
  //----------------------Editor de mapas----------------------//
  
  if(scene == 'E'){
    //Cuadrícula
    if(EButtons[0].prsd){
        showGrid = !showGrid;
        EButtons[0].prsd = false;
    }
    if(EButtons[2].prsd){  //Cambiar fondo
      backgroundSelected++;
      if(backgroundSelected > backgroundsFilesNames.length-1)  backgroundSelected = 0;
      EButtons[2].prsd = false;
    }
    
    //Exportar mapa
    if(EButtons[1].prsd){
      
      //Errores al exportar el mapa
      int _numPlayers = 0;
      int _numTeleports = 0;
      errorEditor = false;
      errorPlayers = false;
      errorTeleports = false;
      
      for(int i = 0; i < BlocksE.length; i++){
        for(int j = 0; j < BlocksE[i].length; j++){
          if(BlocksE[i][j].type == 1 || BlocksE[i][j].type == 2)  _numPlayers++;
          if(Tiles[BlocksE[i][j].type].letter == 'P')  _numTeleports++;
        }
      }
      if(_numPlayers != 2 || _numTeleports == 1){  //No estan los jugadores ubicados en el mapa o hay un error
        errorEditor = true;
        if(_numPlayers != 2)  errorPlayers = true;
        if(_numTeleports == 1)  errorTeleports = true;
        
      }else{
        //Imagen
        PImage mapImage;
        image(backgroundsImages[backgroundSelected],0,0,backgroundsImages[backgroundSelected].width,backgroundsImages[backgroundSelected].height);  //Limpia el nivel para ahora solo mostrar los bloques que sí se deben mostrar
        for(int i = 0; i < BlocksE.length; i++){
          for(int j = 0; j < BlocksE[i].length; j++){
            if(Tiles[BlocksE[i][j].type].showInImage == true){  //Si ese tile se muestra en la imagen
              BlocksE[i][j].display();  //Muestra ese bloque
            }
          }
        }
        mapImage = get(0, 0, numBlocksX*sizeBlocks, numBlocksY*sizeBlocks);  //Solo exporta la parte de la pantalla que tiene el mapa
        mapImage.save("data/maps/map"+numMap+".png");  //La almacena en la carpeta "maps"
        
        //Archivo texto
        String [] mapTxt = new String[BlocksE.length];
        //Inicial el string vacio  (no es lo mismo que nulo)
        for(int i = 0; i < mapTxt.length; i++){
          mapTxt[i] = "";
        }
        
        for(int i = 0; i < BlocksE.length; i++){
          for(int j = 0; j < BlocksE[i].length; j++){
            if(Tiles[BlocksE[i][j].type].showInFile == true){
              mapTxt[i] += Tiles[BlocksE[i][j].type].letter;
            }else{
              mapTxt[i] += ' ';
            }
          }
        }
        saveStrings("data/maps/map"+numMap+".txt", mapTxt);    //Guarda el archivo de texto
        saveSettingsMap(numMap);  //Guarda la configuración del mapa
      }  //Hay dos jugadores
      
      EButtons[1].prsd = false;
    }
    
    //Tile Seleccionado
    for(int b = 0; b < TButtons.length; b++){  //Tiles
      if(TButtons[b].prsd){
        tileSelected = TButtons[b].type;
        TButtons[b].prsd = false;
        break;
      }
    }
    
  }
  
}
