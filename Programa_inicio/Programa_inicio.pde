int screenControl=0;
int sizeBlock = 32;
//Cantidad de Bloques
int numBlocksX = 35;
int numBlocksY = 18;
PImage inicio;
PFont pixel;
void setup(){
  
  surface.setSize(numBlocksX*sizeBlock, numBlocksY*sizeBlock);
  surface.setLocation((displayWidth/2) - numBlocksX*sizeBlock/2, (displayHeight/2) - numBlocksY*sizeBlock/2 - sizeBlock);  //Aparezca centrada la ventana
  inicio = loadImage("Pantalla de inicio.png");
  pixel = loadFont("8-bitOperatorPlus-Regular-48.vlw");
  textFont(pixel);
}

void draw(){
  
  image(inicio,0,0, inicio.width, inicio.height); //fondo de pantalla
  pressSpace();
  
}
