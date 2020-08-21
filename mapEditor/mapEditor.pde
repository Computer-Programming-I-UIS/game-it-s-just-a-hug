/*****************************************************

Este es el editor de mapas para el videojuego It's Just a Hug

Es necesario tener un archivo de imagen diferente para cada tipo de objeto, es decir uno para tierra, agua, letreros, etc.
Cada tile debe de tener un tamaño de 32x32 píxeles (tamaño de la variable sizeTiles) y dependiendo del tamaño de la imágen el código detecta el comportamiento de ese tile.
Ejemplo:
  Para un el tile de ground, si el tamaño de la imágen es 96x96 el programa interpreta que hay 9 diferentes tiles para la tierra.
  Cuando se diseñe el nivel, Solo se selecciona el tipo de bloque que se quiere, luego al hacer click sobre el bloque ese bloque queda con ese tipo
  Y el programa automáticamente coloca el tile correspondiente.

Al exportar el mapa se generan los archivos "mapX.png" y "mapX.txt" (X es el número del mapa). Donde esos archivos deben ser copiados en la carpeta "data/" del videojuego.
Cada vez que se reinicia el editor de mapas X se establece en cero. Por tanto cada vez que se inicie el editor es recomendable los mapas hechos anteriormente los guarde en
otra carpeta. de lo contrario se sobreescriben los archivos.

Para insertar nuevos tipos de bloques debe de añadirse la imagen en la ruta "data/tiles/" (es recomendado imágenes en formato .png)
Y se debe de añadir un nuevo objeto de la clase tile. Se debe de actualizar el tamaño del array Tiles y declarar ese tipo de bloque en la función setupTiles()
  * Se debe especificar el nombre del archivo, el caráter que se almacena en el archivo mapX.txt y si ese bloque bloque es un objeto estático o no.
  
Para insertar nuevos backgrounds debe de añadirse la imagen en la ruta "data/backgrounds/" (la imagen debe de tener un tamaño de 1120x576 pixeles)
Y se debe añadir el nombre del archivo en el array backgroundsFilesNames. 
*****************************************************/

//Tamaño de los Tiles
int sizeTiles = 32;

//Cantidad de Bloques del Nivel    -Deben ser los mismo que el juego!! de lo contrario el juego no detecta el nivel y lo considera como corrupto
int numTilesX = 35;
int numTilesY = 18;

block [][] Blocks = new block[numTilesY][numTilesX];
tile [] Tiles = new tile[5];
button [] TButtons = new button[Tiles.length];  //Botones para los tiles
button [] EButtons = new button[3];


//Background
String [] backgroundsFilesNames = {"sky01.png"};
PImage [] backgroundsImages = new PImage [backgroundsFilesNames.length];

//Mostrar Cuadrícula
boolean showGrid = false;
//Número del Nivel que guarda
int numMap = 0;

void setup(){
  setupScreen();
  setupTiles();
  setupButtons();
  setupBlocks();
  
  for(int i = 0; i < backgroundsFilesNames.length; i++){
    if(!fileExists(backgroundsFilesNames[i], "backgrounds")){
      println("¡ERROR!");
      println("El archivo",backgroundsFilesNames[i],"NO existe");
      exit();
    }else{
      backgroundsImages[i] = loadImage("data/backgrounds/"+backgroundsFilesNames[i]);
    }
  }
}

void draw(){
  image(backgroundsImages[0],0,0,backgroundsImages[0].width,backgroundsImages[0].height);
  //Bloques
  displayBlocks();
  //Botones
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

//Verificar si existe un archivo dentro de la carpeta "data\"
  //Creditos al usuario "Schred"  https://discourse.processing.org/t/checking-if-a-file-exists-strange-runtime-error/20276/5
boolean fileExists(String fileName, String folder){
  //Para un archivo que está directamente en la carpeta data (folder = "")
  File dataFolder = new File(dataPath(folder));
  
  for (File file : dataFolder.listFiles()) {    //Escanea todos los archivos en la carpeta data  (*Otra sintaxis de for)
    if (file.getName().equals(fileName)){    //Si el nombre del archivo es el mismo del que se necesita
      return true;
    }
  }
  return false;
}

void mouseMoved(){
  for(int b = 0; b < TButtons.length; b++){
    if(TButtons[b].checkMouse()){
      cursor(HAND);
      break;
    }else  cursor(ARROW);
  }
  for(int b = 0; b < EButtons.length; b++){
    if(EButtons[b].checkMouse()){
      cursor(HAND);
      break;
    }else  cursor(ARROW);
  }
}

void mousePressed(){
  //Botones
  for(int b = 0; b < TButtons.length; b++){
    if(TButtons[b].checkMouse()){
      TButtons[b].changeState();
      break;
    }
  }
  for(int b = 0; b < EButtons.length; b++){
    if(EButtons[b].checkMouse()){
      EButtons[b].changeState();
      break;
    }
  }
  
}
