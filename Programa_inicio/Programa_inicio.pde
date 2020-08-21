int screenControl=0;
int sizeBlock = 32;
//Cantidad de Bloques
int numAncho = 35;
int numAlto = 18;
PImage inicio;
PFont pixel;
void setup(){
surface.setSize(numAncho*sizeBlock, numAlto*sizeBlock);
inicio = loadImage("Pantalla de inicio.png");
pixel = loadFont("8-bitOperatorPlus-Regular-48.vlw");
textFont(pixel);
}

void draw(){
  
  image(inicio,0,0,numAncho*sizeBlock, numAlto*sizeBlock); //fondo de pantalla
  pressSpace();
  
}
