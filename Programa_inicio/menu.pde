
String texto1="JUGAR";
String texto2="CREDITOS";
String texto3="MAPEAR";
String texto4="SALIR";


menu play;
menu credits;
menu maps;
menu exit;

class menu{
 char[] palabra;
 String word;
 int x; //posicion del centro del texto en x
 int y;  //Una línea poligonal es la que se forma cuando unimos segmentos de recta de un plano.
  
  menu(String _palabra, int _x,int _y){
    x=_x;
    y=_y;
    word=_palabra;
    
   
    
  }
  
void display(){
    textFont(comicFont);
    fill(255);
    textSize(50);
    textAlign(CENTER,CENTER);
    text(word, x, y);
    rect(x,y,5,5);
  
  }




}
