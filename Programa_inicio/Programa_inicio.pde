int screenControl=0;
int sizeBlock = 32;

boolean showMenu=false;

//Cantidad de Bloques
int numBlocksX = 35;
int numBlocksY = 18;
PImage inicio;
PFont pixel;
PFont comicFont;


void setup(){
  
  surface.setSize(numBlocksX*sizeBlock, numBlocksY*sizeBlock);
  surface.setLocation((displayWidth/2) - numBlocksX*sizeBlock/2, (displayHeight/2) - numBlocksY*sizeBlock/2 - sizeBlock);  //Aparezca centrada la ventana
  inicio = loadImage("Pantalla de inicio.png");
  pixel = loadFont("8-bitOperatorPlus-Regular-48.vlw");
  comicFont = loadFont("ComicSansMS-Bold-48.vlw");
  
  
  play = new menu(texto1, width/2, height*5/9);
  credits = new menu(texto2, width/2, height*6/9);
  maps = new menu(texto3,width/2, height*7/9);
  exit = new menu(texto4,width/2, height*8/9);
  
}

void draw(){
  
  image(inicio,0,0, inicio.width, inicio.height); //fondo de pantalla
  pressSpace();
  
  if(keyPressed && key == 32){
    showMenu=true;
    showStart= false;
  }
   
    
   
  if (showMenu){
  play.display();
  credits.display();
  maps.display();
  exit.display();
  
  }
  
}

void mousePressed(){
 
  
  
}
