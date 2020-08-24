
buttonMenu [] BTitle = new buttonMenu[4];
button [] BMaps = new button[5];

void setupButtons(){
  //Pantalla Inicio
  textSize(50);
  int dyButtons = round(textAscent()) + 5;
  BTitle[0] = new buttonMenu(width/2 - 2*round(textWidth("Jugar")/4), height/2 + 40, 2*round(textWidth("Jugar")/2), round(textAscent()), "Jugar");
  BTitle[1] = new buttonMenu(width/2 - 2*round(textWidth("Mapas")/4), height/2 + 40 + dyButtons, 2*round(textWidth("Mapas")/2), round(textAscent()), "Mapas");
  BTitle[2] = new buttonMenu(width/2 - 2*round(textWidth("Creditos")/4), height/2 + 40 + 2*dyButtons, 2*round(textWidth("Creditos")/2), round(textAscent()), "Creditos");
  BTitle[3] = new buttonMenu(width/2 - 2*round(textWidth("Salir")/4), height/2 + 40 + 3*dyButtons, 2*round(textWidth("Salir")/2), round(textAscent()), "Salir");
  
  //Selector de mapas
  int dxButtons = 170;
  dyButtons = 3;
  for(int b = 0; b < BMaps.length; b++){
    BMaps[b] = new button((width - 5*dxButtons)/2 + b*dxButtons, height/2 - 41, 160,82, "map"+(b+1)+".png", "maps");
  }
  
}


class button{
  //Posición
  int x, y;
  int sizeX, sizeY;
  
  //Función
  boolean prsd = false;  //Presionado o no
  boolean mslc = false;  //Mouse sobre el botón o no
  int status = 0;  //estado en el que está (presionado o no) ó (0,1,2,3,4...)
  int numStatus;  //Numero de posiciones en las que puede estar el botón 
  
  //Apariencia
  PImage imageB;
  color [] colorB = {color(124,0,0),color(23,43,234)};
  int colorS = 0;  //Color seleccionado
  String [] info;  //Almacena el texto que se muestra en cada estado
  int sizeTxt = 13;
  
  //Cuando el botón NO tiene imagen
  button(int _x, int _y, int _sizeX, int _sizeY, int _numStatus, int _ColorS, String _info1){
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    
    numStatus = _numStatus;;
    info = new String [numStatus];
    info[0] = _info1;
    
    colorS = constrain(_ColorS, 0, colorB.length);
    imageB = null;
  }
  
  //Cuando el botón tiene imagen y solo una opción 
  button(int _x, int _y, int _sizeX, int _sizeY, String imageName, String folder){
    x = _x;
    y = _y;
    sizeX = _sizeX;
    sizeY = _sizeY;
    
    numStatus = 1;
    info = null;
    
    if(!fileExists(imageName, folder)){  //Si no existe
      println("¡ERROR!");
      println("El archivo",imageName,"NO existe o no se ecuentra en la carpeta \"data\\",folder,"\\\"");
      println("Revisa el nombre del archivo y la carpeta \"data\\",folder,"\\\"");
      exit();
    }else{
      imageB = loadImage("data/"+folder+"/"+imageName);
    }
  }
  
  void setInfo(int _i, String _info){
    _i = constrain(_i, 0, numStatus -1);
    info[_i] = _info;
  }
  
  boolean checkMouse(){
    if(mouseX > x && mouseX < x + sizeX && mouseY > y && mouseY < y + sizeY){  //Si el puntero está sobre el botón
      mslc = true;
      return true;
    }else{
      mslc = false;
      return false;
    }
  }
  
  int changeStatus(){
    prsd = !prsd;
    status++;
    if(status == numStatus)  status = 0;  //Se resetea al llegar al máximo
    return status;
  }
  
  void display(){
    
    if(mslc){
      stroke(255);
      strokeWeight(4);  //Si el mouse está sobre el botón
    }else{
      stroke(150);
      strokeWeight(1);
    }
    
    fill(colorB[colorS]);
    rect(x, y, sizeX, sizeY);  //Dibuja el botón
    
    if(info != null){
      fill(255);
      //textFont(Font1);
      textSize(sizeTxt);
      textAlign(CENTER,CENTER);
      text(info[status], x + sizeX/2, y + sizeY/2);
      
    }else{
      image(imageB, x+2, y+2, sizeX-4, sizeY-4);
    }
    
  }
}


class buttonMenu extends button{
  boolean soundCheck = false;
  
  buttonMenu(int _x, int _y, int sx, int sy, String _info1){
    super(_x, _y, sx, sy, 1, 0, _info1);
    sizeTxt = 60;
  }
  
  void display(){
    textFont(pixelFont);
    if(mslc){
      textSize(sizeTxt +5);
      fill(255,0,0);
      
      //Sonidos
      if(!soundCheck){
        soundButton.trigger();
        soundCheck = true;
      }
    }else{
      textSize(sizeTxt);
      fill(255);
      soundCheck = false;
    }
    
    
    textAlign(CENTER,CENTER);
    text(info[status], x + sizeX/2, y + sizeY/2);
  }
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//

void actionButtons(){
  //----------------------Pantalla inicio----------------------//
  if(scene == 'I'){
    //Jugar
    if(BTitle[0].prsd){
      int _map = round(random(1,5));
      importMap(_map);
      musicTitleS.shiftGain(musicTitleS.getGain(),-40, 2500);  //Fade-out
      
      scene = 'G';
      BTitle[0].prsd = false;
    }
    //Mapas
    if(BTitle[1].prsd){
      
      scene = 'M';
      BTitle[1].prsd = false;
    }
    //Créditos
    if(BTitle[2].prsd){
      
      BTitle[2].prsd = false;
    }
    //Salir
    if(BTitle[3].prsd){
      exit();  //Acaba el Programa
      BTitle[3].prsd = false;
    }
    
  }
  
  //----------------------Selector de Mapas----------------------//
  if(scene == 'M'){
    for(int b = 0; b < BMaps.length; b++){
      if(BMaps[b].prsd){
        importMap(b+1);  //Importa el mapa seleccionado
        musicTitleS.shiftGain(musicTitleS.getGain(),-40, 2500);  //Fade-out
        
        scene = 'G';  //Inicia el juego
        BMaps[b].prsd = false;
        break;
      }
    }
  }
  
}
