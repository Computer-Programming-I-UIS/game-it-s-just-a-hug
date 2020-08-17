
//----------------------GENERACIÖN DE LOS TILES----------------------//

tile [][] Tiles = new tile[numTilesY][numTilesX];

void generarTiles(){
  for(int i = 0; i < Tiles.length; i++){
    for(int j = 0; j < Tiles[i].length; j++){
      Tiles[i][j] = new tile(j*sizeTiles, i*sizeTiles, sizeTiles);
      
    }
  }
  
}

//----------------------DIBUJAR CUADRÍCULA----------------------//

void showGrid(){
  
  stroke(255);
  strokeWeight(1);
  
  //Lineas horizontales
  for(int i = 0; i < Tiles.length; i++){
    line(0, i*sizeTiles, Tiles[0].length*sizeTiles, i*sizeTiles);
    if(i == Tiles.length - 1)
      line(0, i*sizeTiles + sizeTiles, Tiles[0].length*sizeTiles , i*sizeTiles + sizeTiles);
  }
  //Lineas verticales
  for(int j = 0; j < Tiles[0].length; j++){
    line(j*sizeTiles, 0, j*sizeTiles, Tiles.length*sizeTiles);
    if(j == Tiles[0].length - 1)
      line(j*sizeTiles + sizeTiles, 0, j*sizeTiles + sizeTiles, Tiles.length*sizeTiles);
  }
  
}

//----------------------DIBUJAR TILES----------------------//

void showTiles(){
  for(int i = 0; i < Tiles.length; i++){
    for(int j = 0; j < Tiles[i].length; j++){
      Tiles[i][j].show();
    }
  }
}

//----------------------CLASE----------------------//

class tile{
  int x, y;  //Cordenadas superior izquierda del tile
  int size;  //Tamaño
  PImage tileset;  //Imagen del tile 
  
  int typeBlock;
  int tile;
  
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  
  //Cuando el botón cambia de color al presionarse y tiene varias opciones
  tile(int _x, int _y, int _size){
    x = _x;
    y = _y;
    size = _size;
  }
  
  void changeType(int _type){
    int typeBlock = _type;
  }
  
  void changeTile(int _i, int _j){
    
  }
  
  boolean checarMouse(){
    if(mouseX > x && mouseX < x + size && mouseY > y && mouseY < y + size){  //Si el puntero está sobre el botón
      mslc = true;
      return true;
    }else{
      mslc = false;
      return false;
    }
  }
  /*
  int cambiarEstado(){
    prsd = !prsd;
    estado++;
    if(estado == numEstados)  estado = 0;  //Se resetea al llegar al máximo
    return estado;
  }
  */
  void show(){
    square(x, y, size);
  }
}

 /*
  if(Botones[8].prsd){
    PImage Chart = get(xGrafica - 50, 0, xBotones - 30, height);  //Solo exporta la gráfica
    Chart.save("charts/"+Titulo1+"_"+Titulo2+numImagen+".png");  //La almacena en la carpeta "charts"
    numImagen++;
    Botones[8].prsd = false;
  }
  */
