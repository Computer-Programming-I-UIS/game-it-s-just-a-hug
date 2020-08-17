
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

int numBotones = typeTiles.length + 3;  //Tres más para espacio en blanco, exportar e imrportar
boton [] Botones = new boton[numBotones];

int xButtons = (numTilesX + 1) * sizeTiles + 2;
int yButtons = 3*sizeTiles;
int dxButtons = sizeTiles;  //Separacion de los botones

int tileSelected = tilesImages.length;  //Almacena el tipo de tile seleccionado

void setupButtons(){
  
  int xButton = 0;
  int yButton = +2;
  
  //Vacio - Cuadícula - Export
  Botones[typeTiles.length] = new boton(xButtons + xButton, yButtons + yButton, sizeTiles - 4, typeTiles.length);  //Vacio
  xButton += dxButtons;
  Botones[typeTiles.length +1] = new boton(xButtons + xButton, yButtons + yButton, sizeTiles - 4, "Grid");  //Cuadrícula
  xButton += dxButtons;
  Botones[typeTiles.length +2] = new boton(xButtons + xButton, yButtons + yButton, sizeTiles - 4, "Save");  //Export
  xButton = 0;
  yButton += dxButtons;
  
  //Tiles
  for(int b = 0; b < typeTiles.length; b++){
    Botones[b] = new boton(xButtons + xButton, yButtons + yButton, sizeTiles - 4, b);
    xButton += dxButtons;
    if(xButton == 3*dxButtons){
      xButton = 0;
      yButton += dxButtons;
    }
    
  }
  
}

//----------------------DIBUJAR LOS BOTONES----------------------//

void displayButtons(){
  for(int b = 0; b < Botones.length; b++){
    Botones[b].display();
  }
  
}

//----------------------CLASE----------------------//

class boton{
  int x, y;
  int size;
  int typeTile;
  
  color Color1 = color(255,255,0);  //Color del botón cuando no está selecionado
  color Color2 = color(255,0,0);  //Cuando el tile selecionado es el mismo del del boton
  
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  
  String info;
  
  //Para los tiles
  boton(int _x, int _y, int _size, int _typeTile){
    x = _x;
    y = _y;
    size = _size;
    typeTile = _typeTile;
    info = null;
  }
  //Para el importar y guardar
  boton(int _x, int _y, int _size, String _info){
    x = _x;
    y = _y;
    size = _size;
    info = _info;
    typeTile = -1;
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
    if(typeTile != -1 && typeTile != typeTiles.length){
      copy(tilesImages[typeTile], configImages[typeTile][1], configImages[typeTile][2], 32,32, x,y, size,size);  //Pone la imagen del tile que corresponde
    }
    
    //Texto
    if(info != null){
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(10);
      text(info,x + size/2 ,y + size/2);
    }
  }
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void actionButtons(){
  
  //----------------------CUADRÍCULA----------------------//
  
  if(Botones[typeTiles.length +1].prsd){
      showGrid = !showGrid;
      Botones[typeTiles.length +1].prsd = false;
  }
  
  //----------------------EXPORTAR NIVEL----------------------//
  
  if(Botones[typeTiles.length +2].prsd){
    
    //Imagen
    PImage Level = get(0, 0, numTilesX*sizeTiles+1, numTilesY*sizeTiles+1);  //Solo exporta la gráfica
    Level.save("levels/Level"+numLevel+".png");  //La almacena en la carpeta "charts"
    numLevel++;
    Botones[typeTiles.length +2].prsd = false;
    
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
        }else{
          level[i] += typeTiles[Tiles[i][j].typeBlock][1];  //Pone la letra que está definida para ese tipo de bloque
          
        }
      }
    }
    saveStrings("levels/Level"+numLevel+".txt", level);    //Guarda el nuevo archivo sin las demás lineas
  }
  
  
  //----------------------TILE SELECCIONADO----------------------//
  
  for(int b = 0; b <= typeTiles.length; b++){
    if(Botones[b].prsd){
      tileSelected = Botones[b].typeTile;
      Botones[b].prsd = false;
      break;
    }
  }
  
}
