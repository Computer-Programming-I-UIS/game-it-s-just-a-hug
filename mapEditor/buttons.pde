
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

//int numBotones = typeTiles.length + 3;  //Tres más para espacio en blanco, cuadricula e imrportar
button [] TButtons = new button[typeTiles.length];  //Botones para los tiles
button [] EButtons = new button[5];

int xButtons = (numTilesX + 1) * sizeTiles + 2;
int yButtons = 3*sizeTiles;
int dxButtons = sizeTiles;  //Separacion de los botones

int tileSelected = tilesImages.length;  //Almacena el tipo de tile seleccionado

void setupButtons(){
  
  int xButton = 0;
  int yButton = +2;
  
  EButtons[0] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, typeTiles.length);  //Vacio
  xButton += dxButtons;
  EButtons[1] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, "G");  //Cuadrícula
  xButton += dxButtons;
  EButtons[2] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, "S");  //Export
  xButton = 0;
  yButton += dxButtons;
  
  EButtons[3] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, -1);  //Jugador 1
  xButton += dxButtons;
  EButtons[4] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, -2);  //Jugador 2
  xButton += dxButtons;
  
  xButton = 0;
  yButton += dxButtons;
  
  //Tiles
  for(int b = 0; b < TButtons.length; b++){
    TButtons[b] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, b);
    xButton += dxButtons;
    if(xButton == 3*dxButtons){
      xButton = 0;
      yButton += dxButtons;
    }
    
  }
  
}

//----------------------DIBUJAR LOS BOTONES----------------------//

void displayButtons(){
  for(int b = 0; b < TButtons.length; b++){
    TButtons[b].display();
  }
  for(int b = 0; b < EButtons.length; b++){
    EButtons[b].display();
  }
  
}

//----------------------CLASE----------------------//

class button{
  int x, y;
  int size;
  int typeTile;
  
  color Color1 = color(255,255,0);  //Color del botón cuando no está selecionado
  color Color2 = color(255,0,0);  //Cuando el tile selecionado es el mismo del del boton
  
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  
  String info;
  
  //Para los tiles
  button(int _x, int _y, int _size, int _typeTile){
    x = _x;
    y = _y;
    size = _size;
    typeTile = _typeTile;
    info = null;
  }
  //Para el cuadrícula, guardar, etc
  button(int _x, int _y, int _size, String _info){
    x = _x;
    y = _y;
    size = _size;
    info = _info;
    typeTile = -3;
  }
  
  boolean checkMouse(){
    if(mouseX > x && mouseX < x + size && mouseY > y && mouseY < y + size){  //Si el puntero está sobre el botón
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
    if(typeTile == tileSelected)  stroke(Color2);  //Si el tile seleccionado es el mismo del del boton lo colera de otro color
    else  stroke(Color1);
    if(mslc || typeTile == tileSelected)  strokeWeight(5);  //Si el mouse está sobre el botón, el borde es más grueso
    else  strokeWeight(3);
    
    //Dibujar botón
    fill(0);
    square(x, y, size);
    if(typeTile >= 0 && typeTile < typeTiles.length){
      copy(tilesImages[typeTile], configImages[typeTile][1], configImages[typeTile][2], sizeTiles,sizeTiles, x,y, size,size);  //Pone la imagen del tile que corresponde
    }
    
    //Texto
    if(info != null){
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(15);
      text(info,x + size/2, y + size/2 -2);
    }
    if(typeTile < 0 && typeTile != -3){
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(15);
      text("J"+(-typeTile),x + size/2, y + size/2 -2);
    }
    
  }
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void actionButtons(){
  
  //----------------------CUADRÍCULA----------------------//
  
  if(EButtons[1].prsd){
      showGrid = !showGrid;
      EButtons[1].prsd = false;
  }
  
  //----------------------EXPORTAR NIVEL----------------------//
  
  if(EButtons[2].prsd){
    
    //Imagen
    PImage Level = get(0, 0, numTilesX*sizeTiles+1, numTilesY*sizeTiles+1);  //Solo exporta la gráfica
    Level.save("levels/Level"+numLevel+".png");  //La almacena en la carpeta "charts"
    
    //Archivo texto
    String [] level = new String[Tiles.length];
    //Inicial el string vacio  (no nulo)
    for(int i = 0; i < level.length; i++){
      level[i] = "";
    }
    
    for(int i = 0; i < Tiles.length; i++){
      for(int j = 0; j < Tiles[i].length; j++){
        if(Tiles[i][j].typeBlock == typeTiles.length){  //Es vacio
          level[i] += ' ';  //Deja un espacio en blanco
        }else if(Tiles[i][j].typeBlock < 0){  //Si es el bloque de un jugador
          level[i] += -Tiles[i][j].typeBlock;
        }else{
          level[i] += typeTiles[Tiles[i][j].typeBlock][1];  //Pone la letra que está definida para ese tipo de bloque
          
        }
      }
    }
    saveStrings("levels/Level"+numLevel+".txt", level);    //Guarda el nuevo archivo sin las demás lineas
    
    numLevel++;
    EButtons[2].prsd = false;
  }
  
  
  //----------------------TILE SELECCIONADO----------------------//
  
  if(EButtons[0].prsd){  //Vacio
    tileSelected = EButtons[0].typeTile;
    EButtons[0].prsd = false;
    
  }else if(EButtons[3].prsd){  //Juagdor 1
    tileSelected = EButtons[3].typeTile;
    EButtons[3].prsd = false;
    
  }else if(EButtons[4].prsd){  //Jugador 2
    tileSelected = EButtons[4].typeTile;
    EButtons[4].prsd = false;
  }else{
    for(int b = 0; b < TButtons.length; b++){  //Tiles
      if(TButtons[b].prsd){
        tileSelected = TButtons[b].typeTile;
        TButtons[b].prsd = false;
        break;
      }
    }
  }
  
}
