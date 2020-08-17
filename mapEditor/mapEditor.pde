
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
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"},
                         {"tileground01.jpg","S","Y","N"}};  //
PImage [] tilesImages = new PImage [typeTiles.length];  //Imágenes
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
  iniciarBotones();
}

void draw(){
  background(150);
  if(showGrid)  showGrid();
  
  println(mouseX,mouseY);
  fill(255);
  noStroke();
  rect((numTilesX+0.5)*sizeTiles, sizeTiles/2, sizeTiles*4, (numTilesY-1)*sizeTiles);
  displayButtons();
  actionButtons();
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
      tilesImages[i] = loadImage("data/"+typeTiles[i]);;
      
    }else{
      println("¡ERROR!");
      println("El archivo",typeTiles[i][0],"NO existe o no se ecuentra en la carpeta \"data\"");
      println("Revisa el nombre del archivo y la carpeta \"data\"");
      println("O elimina el tipo de bloque de la variable \"typeTiles\"");
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

void mouseClicked(){
  for(int b = 0; b < numBotones; b++){
    if(Botones[b].checkMouse()){
      Botones[b].changeState();
      break;
    }
  }
  
}
