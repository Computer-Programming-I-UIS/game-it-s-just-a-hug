
tile [] Tile = new tile[4];

void setupTiles(){
  //Siempre debe de ir primero el Vacio - Juagdor 1 - Jugador 2, en ese mismo orden y luego ya puede ir cualquier otro tile
  Tile[0] = new tile(' ');
  Tile[1] = new tile("Jugador1", "player01.png", '1', true, false);
  Tile[2] = new tile("Jugador2", "player02.png", '2', true, false);
  
  Tile[3] = new tile("Tierra", "tileground01.png", 'S', true, true);
}

class tile{
  PImage tileImage;
  
  char letter;  //Letra que se imprime en el archivo de texto
  boolean showInFile;  //Mostrar letra en el archivo de texto (false por ejemplo para decoraciones)
  boolean showInImage;  //Mostrar bloque en la imagen (false por ejemplo para posiciones de jugadores o bloques móviles o tiles animados)
  
  int [] sizeTile = new int [2];  //Tamaño del tile (3x3, 1x1, etc)
  int [] defaultTile = new int [2];  //Posición del tile por default (el que se muestra en el boton)
  
  
  tile(String _n, String _fileName, char _letter, boolean _showInFile, boolean _showInImage){
    
    if(fileExists(_fileName)){  //Si existe el archivo
      tileImage = loadImage("data/"+_fileName);
      
      if(tileImage.width%sizeTiles != 0 || tileImage.height%sizeTiles != 0){  //Si el tamaño de la imagen no es correcta  (multiplo del tamaño de los tiles)
        println("¡ERROR!");
        println("La imagen",_fileName,"NO tiene el tamaño correcto \nCada tile de la imagen debe de ser de",sizeTiles,"x",sizeTiles,"píxeles");
        exit();  //Acaba el programa
      }
    }else{
      println("¡ERROR!");
      println("El archivo",_fileName,"NO existe o no se ecuentra en la carpeta \"data\"");
      println("Revisa el nombre del archivo y la carpeta \"data\" \nO elimina el tipo de tile");
      exit();  //Acaba el programa
    }
    
    letter = _letter;
    showInFile = _showInFile;
    showInImage = _showInImage;
    
    int [] sizeTile = new int [2];  //Tamaño del tile (3x3, 1x1, etc)
    int [] defaultTile = new int [2];  //Posición del tile por default (el que se muestra en el boton)
    
    sizeTile[0] = tileImage.width/sizeTiles;  //Catidad de tiles horizontal
    sizeTile[1] = tileImage.height/sizeTiles;  //Cantidad de tiles vertical
    
    if(sizeTile[0] == 1 && sizeTile[1] == 1){
      defaultTile[0] = 0;
      defaultTile[1] = 0;
    }else if(sizeTile[0] == 3 && sizeTile[1] == 3){
      defaultTile[0] = 1;
      defaultTile[1] = 1;
    }else if(sizeTile[0] == 4 && sizeTile[1] == 4){
      defaultTile[0] = 1;
      defaultTile[1] = 1;
    }else{
      defaultTile[0] = 0;
      defaultTile[1] = 0;
    }
    
  }
  //Vacío
  tile(char _letter){
    letter = _letter;
  }
  
  void updateTile(tile up, tile down, tile left, tile right){
    
    
    
  } 
}
