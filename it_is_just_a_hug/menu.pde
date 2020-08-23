
String texto1="JUGAR";
String texto2="CREDITOS";
String texto3="MAPEAR";
String texto4="SALIR";


menu play;
menu credits;
menu maps;
menu exit;

class menu{
 //char[] palabra;
 String word;
 int x; //posicion del centro del texto en x
 int y;  //posicion en y
 float sizeX;
 int ySize;
 
  
  menu(String _palabra, int _x,int _y, float _sizeX){
    x=_x;
    y=_y;
    word=_palabra;
    sizeX=_sizeX;
   // ySize= _ySize;
   
    
  }
  
void display(){
    textFont(comicFont);
    fill(255);
    textSize(50);
    textAlign(CENTER,CENTER);
    text(word, x, y);
    rectMode(CENTER);
    //rect(x,y,sizeX,50);
    rectMode(CORNER);
   // println(sizeX);
  }
  
  boolean checkMouse(){
    if(mouseX > x - sizeX/2 && mouseX < x + sizeX/2 && mouseY > y - 25 && mouseY < y + 25){  //como los dibuja desde el centro, esos son sloslimites
      return true;
    }
    else return false;
    
  }
  
  




}
