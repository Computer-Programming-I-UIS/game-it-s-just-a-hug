int screenControl=0;
int sizeBlock = 32;

boolean showMenu=false;

//Cantidad de Bloques

//Imagenes
PImage inicio;
//Fuentes
PFont pixel;
PFont comicFont;

//Estados de los botones
boolean playCheck = false; //verifica si el usario ya dio a play
boolean creditsCheck = false;
boolean mapsCheck = false;
boolean exitCheck = false;
void inicioSet(){
  
 // surface.setSize(numBlocksX*sizeBlock, numBlocksY*sizeBlock);
  //surface.setLocation((displayWidth/2) - numBlocksX*sizeBlock/2, (displayHeight/2) - numBlocksY*sizeBlock/2 - sizeBlock);  //Aparezca centrada la ventana
  inicio = loadImage("Pantalla de inicio.png");
  pixel = loadFont("8-bitOperatorPlus-Regular-48.vlw");
  comicFont = loadFont("ComicSansMS-Bold-48.vlw");
  
  
  play = new menu(texto1, width/2, height*5/9,/* textWidth(texto1)*/ 200);
  credits = new menu(texto2, width/2, height*6/9, /* textWidth(texto2)*/250);
  maps = new menu(texto3,width/2, height*7/9, /* textWidth(texto3)*/200);
  exit = new menu(texto4,width/2, height*8/9, /* textWidth(texto4)*/200);
  
}

void inicioDraw(){
  println("play",playCheck);
  println("maps",mapsCheck);
  println("credits",creditsCheck);
  println("exit",exitCheck);
  background(0);
  
  
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
    
      if (mousePressed){
        if(play.checkMouse()){
          playCheck=true;
          
          
        }
        if(credits.checkMouse()){
          creditsCheck=true;
          
        }
        if(maps.checkMouse()){
          mapsCheck=true;
          
        }
        
        if(exit.checkMouse()){
          exitCheck=true;
          exit();
          
        }
      
    }
    
 }
  
}
