
void setupTiles() {
  //Siempre debe de ir primero el Vacio - Juagdor 1 - Jugador 2, en ese mismo orden y luego ya puede ir cualquier otro tile
  //NO CAMBIAR
  Tiles[0] = new tile("Vacio", ' ', true);
  Tiles[1] = new tile("Jugador1", "player01.png", '1', true, false);
  Tiles[2] = new tile("Jugador2", "player02.png", '2', true, false);


  Tiles[3] = new tile("Tierra", "tileground01.png", 'S', true, true);
  Tiles[4] = new tile("Tierra", "tileground02.png", 'S', true, true);
}

class tile {
  PImage tileImage;

  char letter;  //Letra que se imprime en el archivo de texto
  boolean showInFile;  //Mostrar letra en el archivo de texto (false por ejemplo para decoraciones)
  boolean showInImage;  //Mostrar bloque en la imagen (false por ejemplo para posiciones de jugadores o bloques móviles o tiles animados)

  int [] sizeTile = new int [2];  //Tamaño del tile (3x3, 1x1, etc)
  int [] defaultTile = new int [2];  //Posición del tile por default (el que se muestra en el boton)


  tile(String _n, String _fileName, char _letter, boolean _showInFile, boolean _showInImage) {

    if (!fileExists(_fileName, "tiles")) {  //Si no existe el archivo
      println("¡ERROR!");
      println("El archivo", _fileName, "NO existe o no se ecuentra en la carpeta \"data\"");
      println("Revisa el nombre del archivo y la carpeta \"data\" \nO elimina el tipo de tile");
      exit();  //Acaba el programa
    } else {
      tileImage = loadImage("data/tiles/"+_fileName);

      if (tileImage.width%sizeTiles != 0 || tileImage.height%sizeTiles != 0) {  //Si el tamaño de la imagen no es correcta  (multiplo del tamaño de los tiles)
        println("¡ERROR!");
        println("La imagen", _fileName, "NO tiene el tamaño correcto \nCada tile de la imagen debe de ser de", sizeTiles, "x", sizeTiles, "píxeles");
        exit();  //Acaba el programa
      } else {
        letter = _letter;
        showInFile = _showInFile;
        showInImage = _showInImage;

        sizeTile[0] = tileImage.width/sizeTiles;  //Catidad de tiles horizontal
        sizeTile[1] = tileImage.height/sizeTiles;  //Cantidad de tiles vertical

        if (sizeTile[0] == 1 && sizeTile[1] == 1) {
          defaultTile[0] = 0;
          defaultTile[1] = 0;
        } else if ((sizeTile[0] == 3 && sizeTile[1] == 3) || (sizeTile[0] == 4 && sizeTile[1] == 4)) {
          defaultTile[0] = sizeTiles;
          defaultTile[1] = 0;
        } else {
          defaultTile[0] = 0;
          defaultTile[1] = 0;
        }
      }
    }
  }
  //Vacío
  tile(String _n, char _letter, boolean _showInFile) {
    letter = _letter;
    showInFile = _showInFile;
    tileImage = null;
  }

  String updateTile(boolean _left, boolean _up, boolean _right, boolean _down) {
    //Tipo de tiles de 1x1
    if (sizeTile[0] == 1 && sizeTile[1] == 1) {
      return "0,0";
    }
    //Tipo de tiles 3x3
    if (sizeTile[0] == 3 && sizeTile[1] == 3) {
      if (!_left && !_up && _right && _down) {  //Bloque arriba izquierda
        return "0,0";
      } else if (_left && !_up && _right && _down) {  //Bloque arriba centro
        return Integer.toString(sizeTiles)+","+Integer.toString(0);
      } else if (_left && !_up && !_right && _down) {  //Bloque arriba derecha
        return Integer.toString(2*sizeTiles)+","+Integer.toString(0);
      } else if (!_left && _up && _right && _down) {  //Bloque centro izquierda
        return Integer.toString(0)+","+Integer.toString(sizeTiles);
      } else if (_left && _up && _right && _down) {  //Bloque centro
        return Integer.toString(sizeTiles)+","+Integer.toString(sizeTiles);
      } else if (_left && _up && !_right && _down) {  //Bloque centro derecha
        return Integer.toString(2*sizeTiles)+","+Integer.toString(sizeTiles);
      } else if (!_left && _up && _right && !_down) {  //Bloque abajo izquierda
        return Integer.toString(0)+","+Integer.toString(2*sizeTiles);
      } else if (_left && _up && _right && !_down) {  //Bloque abajo centro
        return Integer.toString(sizeTiles)+","+Integer.toString(2*sizeTiles);
      } else if (_left && _up && !_right && !_down) {  //Bloque abajo derecha
        return Integer.toString(2*sizeTiles)+","+Integer.toString(2*sizeTiles);
      } else {
        return Integer.toString(sizeTiles)+","+Integer.toString(0);
      }
    }else {
      return Integer.toString(9)+","+Integer.toString(0);
    }
  }
  
}
