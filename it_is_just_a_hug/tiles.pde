/*****************************************************

Este código el que se encarga de los diferentes tipos de tiles que tiene el videojuego

Es necesario tener un archivo de imagen diferente para cada tipo de objeto, es decir uno para tierra, agua, letreros, etc.
Cada tile debe de tener un tamaño de 32x32 píxeles (tamaño de la variable sizeTiles) y dependiendo del tamaño de la imágen el código detecta el comportamiento de ese tile.
Ejemplo:
  Para un el tile de ground, si el tamaño de la imágen es 96x96 el programa interpreta que hay 9 diferentes tiles para la tierra.
  Cuando se diseñe el nivel, Solo se selecciona el tipo de bloque que se quiere, luego al hacer click sobre el bloque ese bloque queda con ese tipo
  Y el programa automáticamente coloca el tile correspondiente.

Al exportar el mapa se generan los archivos "mapX.png" y "mapX.txt" (X es el número del mapa). Donde esos archivos se guardan en la carpeta "data/maps/" del videojuego.

Para insertar nuevos tipos de bloques debe de añadirse la imagen en la ruta "data/tiles/" (es recomendado imágenes en formato .png)
Y se debe de añadir un nuevo objeto de la clase tile. Se debe de actualizar el tamaño del array Tiles y declarar ese tipo de bloque en la función setupTiles()
  * Se debe especificar el nombre del archivo, el caráter que se almacena en el archivo mapX.txt y si ese bloque bloque es un objeto estático o no.
  
Para insertar nuevos backgrounds debe de añadirse la imagen en la ruta "data/backgrounds/" la imagen debe de tener un tamaño de 1120x576 pixeles (tamaño de la ventana del juego)
Y se debe añadir el nombre del archivo en el array backgroundsFilesNames. 
*****************************************************/

tile [] Tiles = new tile[7];
buttonEditor [] TButtons = new buttonEditor[Tiles.length];  //Botones para los tiles

//Background
String [] backgroundsFilesNames = {"background01.png", "background02.png", "background03.png"};
PImage [] backgroundsImages = new PImage [backgroundsFilesNames.length];
int backgroundSelected = 0;

void setupTiles() {
  //Siempre debe de ir primero el Vacio - Juagdor 1 - Jugador 2, en ese mismo orden y luego ya puede ir cualquier otro tile
  //NO CAMBIAR
  Tiles[0] = new tile("Vacio", ' ', true);
  Tiles[1] = new tile("Jugador1", "player01.png", '1', true, false);
  Tiles[2] = new tile("Jugador2", "player02.png", '2', true, false);
  
  Tiles[3] = new tile("Tierra128x128", "tileground01.png", 'S', true, true);
  Tiles[4] = new tile("Nieve128x128", "tileground02.png", 'S', true, true);
  Tiles[5] = new tile("Teleport", "teleport01.png", 'P', true, true);
  Tiles[6] = new tile("Señal", "sign01.png", 'L', false, true);
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
      println("El archivo", _fileName, "NO existe o no se ecuentra en la carpeta \"data\\\"");
      println("Revisa el nombre del archivo y la carpeta \"data\\\" \nO elimina el tipo de tile");
      exit();  //Acaba el programa
    } else {
      tileImage = loadImage("data/tiles/"+_fileName);

      if (tileImage.width%sizeBlocks != 0 || tileImage.height%sizeBlocks != 0) {  //Si el tamaño de la imagen no es correcta  (multiplo del tamaño de los tiles)
        println("¡ERROR!");
        println("La imagen", _fileName, "NO tiene el tamaño correcto \nCada tile de la imagen debe de ser de", sizeBlocks, "x", sizeBlocks, "píxeles");
        exit();  //Acaba el programa
      } else {
        letter = _letter;
        showInFile = _showInFile;
        showInImage = _showInImage;

        sizeTile[0] = tileImage.width/sizeBlocks;  //Catidad de tiles horizontal
        sizeTile[1] = tileImage.height/sizeBlocks;  //Cantidad de tiles vertical

        if (sizeTile[0] == 1 && sizeTile[1] == 1) {
          defaultTile[0] = 0;
          defaultTile[1] = 0;
        } else if ((sizeTile[0] == 3 && sizeTile[1] == 3) || (sizeTile[0] == 4 && sizeTile[1] == 4)) {
          defaultTile[0] = sizeBlocks;
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
        return Integer.toString(sizeBlocks)+","+Integer.toString(0);
      } else if (_left && !_up && !_right && _down) {  //Bloque arriba derecha
        return Integer.toString(2*sizeBlocks)+","+Integer.toString(0);
      } else if (!_left && _up && _right && _down) {  //Bloque centro izquierda
        return Integer.toString(0)+","+Integer.toString(sizeBlocks);
      } else if (_left && _up && _right && _down) {  //Bloque centro
        return Integer.toString(sizeBlocks)+","+Integer.toString(sizeBlocks);
      } else if (_left && _up && !_right && _down) {  //Bloque centro derecha
        return Integer.toString(2*sizeBlocks)+","+Integer.toString(sizeBlocks);
      } else if (!_left && _up && _right && !_down) {  //Bloque abajo izquierda
        return Integer.toString(0)+","+Integer.toString(2*sizeBlocks);
      } else if (_left && _up && _right && !_down) {  //Bloque abajo centro
        return Integer.toString(sizeBlocks)+","+Integer.toString(2*sizeBlocks);
      } else if (_left && _up && !_right && !_down) {  //Bloque abajo derecha
        return Integer.toString(2*sizeBlocks)+","+Integer.toString(2*sizeBlocks);
      } else {
        return Integer.toString(sizeBlocks)+","+Integer.toString(0);
      }
    }
    //Tipo de tiles 4x4
    if (sizeTile[0] == 4 && sizeTile[1] == 4) {
      if (!_left && !_up && _right && _down) {  //Bloque arriba izquierda
        return "0,0";
      } else if (_left && !_up && _right && _down) {  //Bloque arriba centro
        return Integer.toString(sizeBlocks)+","+Integer.toString(0);
      } else if (_left && !_up && !_right && _down) {  //Bloque arriba derecha
        return Integer.toString(2*sizeBlocks)+","+Integer.toString(0);
      } else if (!_left && _up && _right && _down) {  //Bloque centro izquierda
        return Integer.toString(0)+","+Integer.toString(sizeBlocks);
      } else if (_left && _up && _right && _down) {  //Bloque centro
        return Integer.toString(sizeBlocks)+","+Integer.toString(sizeBlocks);
      } else if (_left && _up && !_right && _down) {  //Bloque centro derecha
        return Integer.toString(2*sizeBlocks)+","+Integer.toString(sizeBlocks);
      } else if (!_left && _up && _right && !_down) {  //Bloque abajo izquierda
        return Integer.toString(0)+","+Integer.toString(2*sizeBlocks);
      } else if (_left && _up && _right && !_down) {  //Bloque abajo centro
        return Integer.toString(sizeBlocks)+","+Integer.toString(2*sizeBlocks);
      } else if (_left && _up && !_right && !_down) {  //Bloque abajo derecha
        return Integer.toString(2*sizeBlocks)+","+Integer.toString(2*sizeBlocks);
      } else if (!_left && !_up && !_right && _down) {  //Bloque vertica arriba
        return Integer.toString(3*sizeBlocks)+","+Integer.toString(0);
      } else if (!_left && _up && !_right && _down) {  //Bloque vertical centro
        return Integer.toString(3*sizeBlocks)+","+Integer.toString(sizeBlocks);
      } else if (!_left && _up && !_right && !_down) {  //Bloque vertical abajo
        return Integer.toString(3*sizeBlocks)+","+Integer.toString(2*sizeBlocks);
      } else if (!_left && !_up && _right && !_down) {  //Bloque horizontal izquierda
        return Integer.toString(0)+","+Integer.toString(3*sizeBlocks);
      } else if (_left && !_up && _right && !_down) {  //Bloque horizontal centro
        return Integer.toString(sizeBlocks)+","+Integer.toString(3*sizeBlocks);
      } else if (_left && !_up && !_right && !_down) {  //Bloque horizontal derecha
        return Integer.toString(2*sizeBlocks)+","+Integer.toString(3*sizeBlocks);
      } else if (!_left && !_up && !_right && !_down) {  //Bloque solo
        return Integer.toString(3*sizeBlocks)+","+Integer.toString(3*sizeBlocks);
      } else {
        return Integer.toString(sizeBlocks)+","+Integer.toString(0);
      }
    }else {
      return Integer.toString(0)+","+Integer.toString(0);
    }
  }
  
}
