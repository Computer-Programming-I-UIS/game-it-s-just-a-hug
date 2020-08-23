
import ddf.minim.*;

import ddf.minim.*;
Minim minim;
AudioSample sound1;

int screenControl=0;
int sizeBlock = 32;

boolean showMenu=false;

//Cantidad de Bloques

//Imagenes
PImage inicioFondo;
PImage inicioTitulo;
PImage inicioBomba;
//Fuentes
PFont pixel;
PFont comicFont;


void inicioSet(){
  minim = new Minim(this);
  sound1 = minim.loadSample("sound/pcmouseclick2.mp3");
 // surface.setSize(numBlocksX*sizeBlock, numBlocksY*sizeBlock);
  //surface.setLocation((displayWidth/2) - numBlocksX*sizeBlock/2, (displayHeight/2) - numBlocksY*sizeBlock/2 - sizeBlock);  //Aparezca centrada la ventana
  inicioFondo = loadImage("HomeSreen/Pantallad de inicio fondo principal.png");
  inicioTitulo=  loadImage("HomeSreen/Pantalla de inicio Titulo.png");
  inicioBomba= loadImage("HomeSreen/Bomba animada Sprite.png");
  pixel = loadFont("8-bitOperatorPlus-Regular-48.vlw");
  comicFont = loadFont("ComicSansMS-Bold-48.vlw");
  
  
  play = new menu(texto1, width/2, height*5/9,/* textWidth(texto1)*/ 200);
  credits = new menu(texto2, width/2, height*6/9, /* textWidth(texto2)*/250);
  maps = new menu(texto3,width/2, height*7/9, /* textWidth(texto3)*/200);
  exit = new menu(texto4,width/2, height*8/9, /* textWidth(texto4)*/200);
  
}
int frameBomba=0;
void inicioDraw(){
  
  image(inicioFondo,0,0, inicioFondo.width, inicioFondo.height); //fondo 
  
  //bomba aniamcion
  frameBomba = (frameCount/6)%10;
  copy(inicioBomba,frameBomba*200,0,200,200,660,20,200,200);
  
  
  //fin bomba animacion 
  
  image(inicioTitulo,0,0,inicioTitulo.width, inicioTitulo.height);
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
   
  if(exit.checkButton)exit();
        
 }
  
}
