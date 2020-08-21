
int numMaxButtons = 10;  //Número máximo de botones por escena
button [][] Buttons = new button[numScenes][numMaxButtons];
int [] numButtonsScene = new int [numScenes];

void setupButtons(){
  numButtonsScene[0] = 0;
  
  
  Buttons[0][0] = new button(5*sizeBlocks, 7*sizeBlocks, 2*sizeBlocks, sizeBlocks, 1, 0, "Hola");
  Buttons[0][1] = new button(10*sizeBlocks, 5*sizeBlocks, 2*sizeBlocks, sizeBlocks, 2, 0, "Hola");
  Buttons[0][1].setInfo(1, "Qué más");
  
  numButtonsScene[1] = 3;
  Buttons[1][0] = new button(5*sizeBlocks, 7*sizeBlocks, 2*sizeBlocks, sizeBlocks, 1, 0, "Chau");
  Buttons[1][1] = new button(10*sizeBlocks, 5*sizeBlocks, 2*sizeBlocks, sizeBlocks, 2, 0, "Siuu");
  Buttons[1][1].setInfo(1, "Noou");
  Buttons[1][2] = new button(9*sizeBlocks, 7*sizeBlocks, 2*sizeBlocks, sizeBlocks, 1, 0, "kkkk");
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
    
    if(mslc)  strokeWeight(4);  //Si el mouse está sobre el botón y no esta el valor máximo
    else  strokeWeight(1);
    
    stroke(0);
    fill(colorB[colorS]);
    rect(x, y, sizeX, sizeY);  //Dibuja el botón
    
    if(info != null){
      fill(255);
      //textFont(Font1);
      textSize(sizeTxt);
      textAlign(CENTER,CENTER);
      text(info[status], x + sizeX/2, y + sizeY/2);
      
    }else{
      image(imageB, x,y, sizeX, sizeY);
    }
    
  }
}

//----------------------ACCIÓN DE LOS BOTONES----------------------//
/*
void accionBotones(){
  
  //----------------------PUNTOS-BARRAS----------------------//
  
  if(Botones[0].prsd){  //Si el botón está activado
    strokeWeight(2);
    //Lineas Rectas
    if(!Botones[3].prsd){  //Si está seleccionado dibujar rectas  (No está activado)
      stroke(Temas[temaSlct][5]);
      for(int b = 0; b < numBarras - 1; b++){
        line(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto, Barras[b+1].x + Barras[b].ancho/2, Barras[b+1].y - Barras[b+1].alto);  //Linea que une las barras 
      }
    }else{  //Curva  (Está activado el botón)
      noFill();
      stroke(Temas[temaSlct][5]);
      beginShape();
      for(int b = 0; b < numBarras; b++){
        if(b == 0 || b == numBarras - 1){  //Es necesario usar dos puntos para el inicio y el final, es decir deben de estar repetidos
          curveVertex(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto);
        }
        curveVertex(Barras[b].x + Barras[b].ancho/2, Barras[b].y - Barras[b].alto);
      }
      endShape();
    }
  }
  
  //----------------------CAMBIO DEL NUMERO DE BARRAS----------------------//
  
  if(Botones[1].prsd){
    if(numBarras != numMaxBarras)  cambiarNumBarras(true);
    Botones[1].prsd = false;
  }
  if(Botones[2].prsd){
    if(numBarras != 1)  cambiarNumBarras(false);
    Botones[2].prsd = false;
  }
  
  //----------------------RESET----------------------//
  
  if(Botones[4].prsd){
    for(int b = 0; b < numMaxBarras; b++){
      Barras[b].reset();
    }
    Botones[4].prsd = false;
  }
  
  //----------------------TIPO----------------------//
  
  if(Botones[5].prsd){
    int estadoAnterior;
    estadoAnterior = Botones[5].estado -1;
    if(estadoAnterior < 0)  estadoAnterior = Botones[5].numEstados -1;
    Titulo1 = Botones[5].info[estadoAnterior];
    Botones[5].prsd = false;
  }
  
  //----------------------EJE Y----------------------//
  
  if(Botones[6].prsd){
    if(yMax == 100)  yMax = 500;
    else if(yMax == 1000) yMax = 100;
    else  yMax += 1000;
    yMax = constrain(yMax, 0, 1000);
    
    Botones[6].prsd = false;
  }
  
  //----------------------AÑOS-MESES----------------------//
  
  if(Botones[7].prsd){  //Años
    textFont(Font1);
    fill(Temas[temaSlct][5]);
    for(int b = 0; b < numBarras; b++){
      text(year() - b, Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La última barra es la del presente año y las anteriores son las de los años anteriores
    }
    Titulo2 = "Anuales";
  }if(!Botones[7].prsd){  //Meses
    String [] meses = {"EN", "FEB", "MAR", "ABR", "MAY", "JUN", "JUL", "AGTO", "SEPT", "OCT", "NOV", "DIC"};
    int mes = month();
    textFont(Font1);
    fill(Temas[temaSlct][5]);
    for(int b = 0; b < numBarras; b++){
      mes--;
      if(mes < 0)  mes = 11;
      text(meses[mes], Barras[numBarras - b -1].x + Barras[numBarras - b -1].ancho/2, yGrafica + 10);  //La ultima barra es la del mes actual
    }
    Titulo2 = "Mensuales";
  }
  
  //----------------------EXPORTAR GRÁFICA----------------------//
  
  if(Botones[8].prsd){
    PImage Chart = get(xGrafica - 50, 0, xBotones - 30, height);  //Solo exporta la gráfica
    Chart.save("charts/"+Titulo1+"_"+Titulo2+numImagen+".png");  //La almacena en la carpeta "charts"
    numImagen++;
    Botones[8].prsd = false;
  }
  
  //----------------------TEMAS DE COLORES----------------------//
  
  if(Botones[9].prsd){
    temaSlct++;
    if(temaSlct >= Temas.length)  temaSlct = 0;
    
    Botones[9].prsd = false;
  }
}
*/
