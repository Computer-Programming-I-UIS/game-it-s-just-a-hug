
//----------------------GENERACIÖN DE LOS BOTONES----------------------//

int xButtons = (numTilesX + 1) * sizeTiles + 2;
int yButtons = 3*sizeTiles;
int dxButtons = sizeTiles;  //Separacion de los botones

int tileSelected = 0;  //Almacena el tipo de tipo de tile seleccionado

void setupButtons(){
  
  int xButton = 0;
  int yButton = +2;
  
  EButtons[0] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, "G");  //Cuadrícula
  xButton += dxButtons;
  EButtons[1] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, "S");  //Export
  xButton += dxButtons;
  EButtons[2] = new button(xButtons + xButton, yButtons + yButton, sizeTiles - 4, "B");  //Background
  
  //Tiles
  xButton = 0;
  yButton += dxButtons;
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
  fill(255);
  noStroke();
  rect((numTilesX+0.5)*sizeTiles, sizeTiles/2, sizeTiles*4, (numTilesY-1)*sizeTiles);
  
  for(int b = 0; b < EButtons.length; b++){
    EButtons[b].display();
  }
  for(int b = 0; b < TButtons.length; b++){
    TButtons[b].display();
  }
  
}

//----------------------CLASE----------------------//

class button{
  int x, y;
  int size;
  int type;
  
  color Color1 = color(255,255,0);  //Color del borde cuando no está selecionado
  color Color2 = color(255,0,0);  //Cuando el tile selecionado es el mismo del del boton
  
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  
  String info;
  
  //Para los tiles
  button(int _x, int _y, int _size, int _type){
    x = _x;
    y = _y;
    size = _size;
    type = _type;
    info = null;
  }
  //Para el cuadrícula, guardar, etc
  button(int _x, int _y, int _size, String _info){
    x = _x;
    y = _y;
    size = _size;
    info = _info;
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
    if(info == null && type == tileSelected)  stroke(Color2);  //Si el tile seleccionado es el mismo del boton lo colorea de otro color
    else  stroke(Color1);
    if(mslc)  strokeWeight(5);  //Si el mouse está sobre el botón, el borde es más grueso
    else  strokeWeight(3);
    
    //Dibujar botón
    fill(0);
    square(x, y, size);
    if(info == null && Tiles[type].tileImage != null){  //Si es un botón de tile y ese tile SÍ tiene imagen
      copy(Tiles[type].tileImage, Tiles[type].defaultTile[0], Tiles[type].defaultTile[1], sizeTiles,sizeTiles, x,y, size,size);  //Pone la imagen del tile que corresponde
    }
    //Texto
    if(info != null){
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(15);
      text(info,x + size/2, y + size/2 -2);
    }
  }
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void actionButtons(){
  //----------------------CUADRÍCULA----------------------//
  
  if(EButtons[0].prsd){
      showGrid = !showGrid;
      EButtons[0].prsd = false;
  }
  
  //----------------------EXPORTAR NIVEL----------------------//
  
  if(EButtons[1].prsd){
    
    //Imagen
    PImage mapImage;
    image(backgroundsImages[0],0,0,backgroundsImages[0].width,backgroundsImages[0].height);  //Limpia el nivel para ahora solo mostrar los bloques que sí se deben mostrar
    for(int i = 0; i < Blocks.length; i++){
      for(int j = 0; j < Blocks[i].length; j++){
        if(Tiles[Blocks[i][j].type].showInImage == true){  //Si ese tile se muestra en la imagen
          Blocks[i][j].display();  //Muestra ese bloque
        }
      }
    }
    mapImage = get(0, 0, numTilesX*sizeTiles+1, numTilesY*sizeTiles+1);  //Solo exporta la parte de la pantalla que tiene el mapa
    mapImage.save("maps/map"+numMap+".png");  //La almacena en la carpeta "maps"
    
    //Archivo texto
    String [] mapTxt = new String[Blocks.length];
    //Inicial el string vacio  (no es lo mismo que nulo)
    for(int i = 0; i < mapTxt.length; i++){
      mapTxt[i] = "";
    }
    
    for(int i = 0; i < Blocks.length; i++){
      for(int j = 0; j < Blocks[i].length; j++){
        if(Tiles[Blocks[i][j].type].showInFile == true){
          mapTxt[i] += Tiles[Blocks[i][j].type].letter;
        }else{
          mapTxt[i] += ' ';
        }
      }
    }
    saveStrings("maps/map"+numMap+".txt", mapTxt);    //Guarda el archivo de texto
    
    numMap++;
    EButtons[1].prsd = false;
  }
  
  
  //----------------------TILE SELECCIONADO----------------------//
  for(int b = 0; b < TButtons.length; b++){  //Tiles
    if(TButtons[b].prsd){
      tileSelected = TButtons[b].type;
      TButtons[b].prsd = false;
      break;
    }
  } 
}
