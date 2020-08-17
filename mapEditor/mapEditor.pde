
/*****************************************************

Este es el editor de niveles

Es necesario tener un archivo de imagen diferente para cada tipo de objeto, es decir uno para los tiles de tierra, agua, letrero, etc.
Cada tile debe de tener un tamaño de 32x32 píxeles y dependiendo del tamaño de la imágen el código detecta el comportamiento de ese tile.
Ejemplo:
  Para un el tile de ground, si el tamaño de la imágen es 96x96 el programa interpreta que hay 9 diferentes tiles para el suelo.
  Cuando se diseñe el nivel, Solo se selecciona el tipo de bloque que se quiere, luego al hacer click sobre el bloque ese bloque queda con ese tipo
  Y el programa automáticamente coloca el tile correspondiente.

*****************************************************/

//Tamaño de los Tiles
int sizeTiles = 32;

//Cantidad de Bloques del Nivel    -Deben ser los mismo que el juego!! de lo contrario el juego no detecta el nivel y lo considera como corrupto
int numTilesX = 35;
int numTilesY = 18;

//Tiles
/*
  1 - nombre del archivo con la extensión
  2 - Carácter que se almacena en el archivo de texto (no puede estar repetido)
  3 - Si es un tipo de bloque con colisión = "Y", Si no, entonces es un bloque decorativo = "N"
  4 - Si es un tipo de bloque con animación = "Y", Si no, entonces es un bloque estático = "N"

*/
String [][] typeTiles = {{"tileground01.jpg","S","Y","N"},
                         {"tileground02.jpg","S","Y","N"},
                         {"tileground03.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground02.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground03.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"}};  //
PImage [] tilesImages = new PImage [typeTiles.length];  //Imágenes
int [][] configImages = new int [typeTiles.length][3];  //Almacena las cordenadas del la imagen que se pone en el boton
//Background
String [] backgroundsFilesNames = {"background01.jpg"};
PImage [] backgroundsImages = new PImage [backgroundsFilesNames.length];

//Bloques del Nivel
char [][] blocks = new char [numTilesY][numTilesX];

//Mostrar Cuadrícula
boolean showGrid = true;


//Número del Nivel que guarda
int numLevel = 0;

void setup(){
  setupScreen();
  importTiles();
  setupButtons();
  setupTiles();
}

void draw(){
  background(150);
  
  //Tiles
  displayTiles();
  
  //Botones
  fill(255);
  noStroke();
  rect((numTilesX+0.5)*sizeTiles, sizeTiles/2, sizeTiles*4, (numTilesY-1)*sizeTiles);
  displayButtons();
  actionButtons();
  
  //Cuadrícula
  if(showGrid)  showGrid();
}



void setupScreen(){
  int sizeScreenX = numTilesX+5;
  surface.setSize((sizeScreenX)*sizeTiles, numTilesY*sizeTiles+1);  //Define el tamaño de la ventana
  surface.setLocation((displayWidth/2) - (sizeScreenX)*sizeTiles/2, (displayHeight/2) - (numTilesY+1)*sizeTiles/2);  //Aparezca centrada la ventana
  surface.setTitle("Editor de Mapas");  //Título de la ventana
  //surface.setResizable(true);
  
}

void importTiles(){
  for(int i = 0; i < typeTiles.length; i++){
    if(fileExists(typeTiles[i][0])){  //Si el archivo existe
      tilesImages[i] = loadImage("data/"+typeTiles[i][0]);
      
      if(tilesImages[i].width%32 != 0 || tilesImages[i].height%32 != 0){  //Si el tamaño de la imagen no es correcta  (multiplo de 32)
        println("ERROR! \nLa imagen",typeTiles[i][0],"NO tiene el tamaño correcto \nCada tile de la imagen debe de ser de 32x32 píxeles");
        exit();  //Acaba el programa
        
      }else{  //Si es del tamaño correcto
        
        //Tipos de Tiles
          int s = 32;  //Tamaño de los tiles
          
          if(tilesImages[i].width == s && tilesImages[i].height == s){  //1x1
            configImages[i][0] = 1;
            configImages[i][1] = 0;
            configImages[i][2] = 0;
            
          }else if(tilesImages[i].width == 3*s && tilesImages[i].height == 3*s){  //3x3
            configImages[i][0] = 3;
            configImages[i][1] = s;
            configImages[i][2] = s;
            
          }
      }
      
    }else{
      println("¡ERROR!");
      println("El archivo",typeTiles[i][0],"NO existe o no se ecuentra en la carpeta \"data\"");
      println("Revisa el nombre del archivo y la carpeta \"data\" \nO elimina el tipo de bloque de la variable \"typeTiles\"");
      exit();  //Acaba el programa
    }
  }
  
}

boolean fileExists(String fileName){
  File dataFolder = new File(dataPath(""));
  
  for (File file : dataFolder.listFiles()) {    //Escanea todos los archivos en la carpeta data  (*Otra sintaxis de for)
    if (file.getName().equals(fileName)){    //Si el nombre del archivo es el mismo del que se necesita
      return true;
    }
  }
  return false;
}

void mouseMoved(){
  for(int b = 0; b < numBotones; b++){
    if(Botones[b].checkMouse()){
      cursor(HAND);
      break;
    }else  cursor(ARROW);
  }
  
}

void mousePressed(){
  //Botones
  for(int b = 0; b < numBotones; b++){
    if(Botones[b].checkMouse()){
      Botones[b].changeState();
      break;
    }
  }
  
}
