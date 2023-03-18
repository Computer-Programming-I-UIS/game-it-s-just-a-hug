
blockE [][] BlocksE = new blockE[numBlocksY][numBlocksX];

//----------------------GENERACIÖN DE LOS TILES----------------------//

void setupBlocksEditor(){
  for(int i = 0; i < BlocksE.length; i++){
    for(int j = 0; j < BlocksE[i].length; j++){
      BlocksE[i][j] = new blockE(j*sizeBlocks, i*sizeBlocks, sizeBlocks);
      BlocksE[i][j].type = 0;
    }
  }
  
}

//----------------------DIBUJAR CUADRÍCULA----------------------//

void showGrid(){
  stroke(255);
  strokeWeight(1);
  
  //Lineas horizontales
  for(int i = 0; i < BlocksE.length; i++){
    line(0, i*sizeBlocks, BlocksE[0].length*sizeBlocks, i*sizeBlocks);
    if(i == BlocksE.length - 1)
      line(0, i*sizeBlocks + sizeBlocks, BlocksE[0].length*sizeBlocks , i*sizeBlocks + sizeBlocks);
  }
  //Lineas verticales
  for(int j = 0; j < BlocksE[0].length; j++){
    line(j*sizeBlocks, 0, j*sizeBlocks, BlocksE.length*sizeBlocks);
    if(j == BlocksE[0].length - 1)
      line(j*sizeBlocks + sizeBlocks, 0, j*sizeBlocks + sizeBlocks, BlocksE.length*sizeBlocks);
  }
  
}

//----------------------ACTUALIZAR BLOQUES----------------------//

void updateBlocksE(){
  boolean leftB = false;
  boolean upB = false;
  boolean rightB = false;
  boolean downB = false;
  
  for(int i = 0; i < BlocksE.length; i++){
    for(int j = 0; j < BlocksE[i].length; j++){
      leftB = false;
      upB = false;
      rightB = false;
      downB = false;
      
      if(j == 0 || BlocksE[i][j].type == BlocksE[i][j-1].type)  leftB = true;  //Si el bloque de la izquierda es del mismo tipo de bloque entonces leftB = true
      if(i == 0 || BlocksE[i][j].type == BlocksE[i-1][j].type)  upB = true;
      if(j == BlocksE[i].length-1 || BlocksE[i][j].type == BlocksE[i][j+1].type)  rightB = true;
      if(i == BlocksE.length-1 || BlocksE[i][j].type == BlocksE[i+1][j].type)  downB = true;
      
      BlocksE[i][j].updateTile(leftB, upB, rightB, downB);
      
    }
  }
  
}


//----------------------REVISAR SI HAY OTRO BLOQUE CON EL JUGADOR----------------------//

void deletePlayer(int _p){
  for(int i = 0; i < BlocksE.length; i++){
    for(int j = 0; j < BlocksE[i].length; j++){
      if(BlocksE[i][j].type == _p){  //Si ya hay otro bloque con ese jugador
        BlocksE[i][j].type = 0;  //Establece ese bloque como vacio
        break;
      }
      
    }
  }
  
}

void adjustPlayer(){
  for(int i = 0; i < BlocksE.length; i++){
    for(int j = 0; j < BlocksE[i].length; j++){
      if(BlocksE[i][j].type == 1 || BlocksE[i][j].type == 2){  //Si hay un bloque con un jugador
        if(i != BlocksE.length -1)  BlocksE[i+1][j].type = 0;  //Establece el bloque de abajo como vacio
        else{
          deletePlayer(BlocksE[i][j].type);  //Elimina al jugador
          BlocksE[i-1][j].type = BlocksE[i][j].type;   //Y lo ubica un bloque arriba
        }
        
      }
      
    }
  }
}

void adjustTeleports(){
  for(int i = 0; i < BlocksE.length; i++){
    for(int j = 0; j < BlocksE[i].length; j++){
      if(Tiles[BlocksE[i][j].type].letter == 'P'){
        if(i != BlocksE.length -1)  BlocksE[i+1][j].type = 0;  //Establece el bloque de abajo como vacio para que cuando se teletransporte no se sobreponga un bloque
        else{
          BlocksE[i-1][j].type = BlocksE[i][j].type;   //Y lo ubica un bloque arriba
          BlocksE[i][j].type = 0;
        }
      }
    }
  }
  
}

//----------------------CLASE----------------------//

class blockE{
  int x, y;  //Cordenadas superior izquierda del tile
  int size;  //Tamaño 
  int type;
  
  int xTile = 0;
  int yTile = 0;
  
  blockE(int _x, int _y, int _size){
    x = _x;
    y = _y;
    size = _size;
  }
  
  void changeType(int _type){
    if(_type == 1 || _type == 2){
      deletePlayer(_type);
    }
    type = _type;
    
    if(Tiles[_type].letter == 'P'){  //Si es un teleport
      int numTeleports = 0;
      for(int i = 0; i < BlocksE.length; i++){
        for(int j = 0; j < BlocksE[i].length; j++){
          if(Tiles[BlocksE[i][j].type].letter == 'P')  numTeleports++;
        }
      }
      if(numTeleports > Teleport.length)  type = 0;
    }
    
    adjustPlayer();
    adjustTeleports();
    updateBlocksE();
  }
  
  void updateTile(boolean _left, boolean _up, boolean _right, boolean _down){
    String xyTile = Tiles[type].updateTile(_left, _up, _right, _down);
    
    int [] xy = int(split(xyTile, ','));  //Separa el string en cada ',' y lo convierte a int
    
    xTile = xy[0];
    yTile = xy[1];
  }
  
  boolean checkMouse(){
    if(mouseX > x && mouseX < x + size && mouseY > y && mouseY < y + size){  //Si el puntero está sobre el botón
      if(mousePressed && mouseButton == LEFT){
        return true;
        }
      }
      return false;
    }
  void display(){
    if(checkMouse())  changeType(tileSelected);
    
    if(Tiles[type].tileImage != null){  //Si ese tile SÍ tiene imagen
      if(type != 1 && type != 2){  //Si no es un bloque de jugador
        copy(Tiles[type].tileImage, xTile, yTile, sizeBlocks,sizeBlocks, x,y, size,size);  //Pone la imagen del tile que corresponde
      }else{
        copy(Tiles[type].tileImage, xTile, yTile, sizeBlocks,sizeBlocks, x- (25*size/32)/2, y + (2*sizeBlocks -50*size/32), 50*size/32, 50*size/32);  //Los bloques de jugador ocupan dos bloques de alto
      }
    }
    
  }
  
}

void resetBlocksE(){
  for(int i = 0; i < BlocksE.length; i++){
    for(int j = 0; j < BlocksE[i].length; j++){
      BlocksE[i][j].type = 0;
    }
  }
}

void importSettingsMap(int numMap){  //Importar la configuración del mapa seleccionado para poder editarlo
  String fileNameMapTXT = "map"+numMap+"_settings.txt";  //Nombre del archivo .txt
  String mapSettingsFile [] = new String[numBlocksY];  //Almacena todo lo que tenga el archivo
  
  //Resetea los bloques
  resetBlocksE();
  
  if(!fileExists(fileNameMapTXT, "../shared_files/data/maps")){  //Si no existe
    println("¡ERROR!");
    println("El archivo", fileNameMapTXT, "NO existe o no se ecuentra en la carpeta \"data/maps\"");
    println("Revisa el nombre del archivo y la carpeta \"data/maps\"");
    //exit();
    resetBlocksE();
    
  }else{  //El archivo sí existe entonces lo importa
    mapSettingsFile = loadStrings("../shared_files/data/maps/"+fileNameMapTXT);  //Carga el archivo
    
    if(mapSettingsFile.length != numBlocksY+1){  //No es del tamaño correcto
      println("¡ERROR!");
      resetBlocksE();
      
    }else{  //El archivo tiene la cantidad de filas correctas
      
      boolean valido = true;
      for(int r = 0; r < mapSettingsFile.length; r++){  //Recorre cada string del array
        //Si tiene una cantidad de carácteres diferente a la del ancho o el string no es un número entero (la primera linea es el número del fondo del mapa)
        if(r != 0){
          if(mapSettingsFile[r].length() != numBlocksX){
            valido = false;  //No es valido
            break;
          }
          for(int c = 0; c < mapSettingsFile[r].length(); c++){
            String tempNum = String.valueOf(mapSettingsFile[r].charAt(c));
            if(!isInteger(tempNum)){
              valido = false;  //No es valido
              break;
            }
          }
        }
      }
      if(!valido){
        println("¡ERROR!");
        resetBlocksE();
        
      }else{  //Mapa válido
        backgroundSelected = Character.getNumericValue(mapSettingsFile[0].charAt(0));
        backgroundSelected = constrain(backgroundSelected, 0, backgroundsFilesNames.length -1);
        
        for(int r = 1; r < mapSettingsFile.length; r++){
          for(int c = 0; c < mapSettingsFile[r].length(); c++){
            BlocksE[r-1][c].type = Character.getNumericValue(mapSettingsFile[r].charAt(c));
            BlocksE[r-1][c].type = constrain(BlocksE[r-1][c].type, 0, Tiles.length-1);
            
          }  //end for (c)
        }  //end for (r)
      }
    }  //end tiene la cantidad de filas correctas y es un número
  }  //end el archivo existe
  
  tileSelected = 0;  //Inicia el editor con el tipo de tile en blanco
  
}

void saveSettingsMap(int _numMap){
  String [] mapSettingsTxt = new String[BlocksE.length+1];
  //Inicial el string vacio  (no es lo mismo que nulo)
  for(int i = 0; i < mapSettingsTxt.length; i++){
    mapSettingsTxt[i] = "";
  }
  mapSettingsTxt[0] = Integer.toString(backgroundSelected);  //Guarda el fondo
  
  for(int i = 0; i < BlocksE.length; i++){
    for(int j = 0; j < BlocksE[i].length; j++){
      mapSettingsTxt[i+1] += Integer.toString(BlocksE[i][j].type);  //Guarda el tipo de bloque
    }
  }
  saveStrings("../shared_files/data/maps/map"+_numMap+"_settings.txt", mapSettingsTxt);    //Guarda el archivo de texto
}
