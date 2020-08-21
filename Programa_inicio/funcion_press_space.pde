//int frame;

boolean showStart = true;

void pressSpace(){
  //frame=(frameCount/10)%10;
  //println(frame);
  
  if(frameCount%25 == 0)  showStart = !showStart;  //Cada 25 frames cambia de estado
  
  if(showStart){
    fill(0);
    textSize(30);
    textAlign(CENTER,CENTER);
    text("Presione espacio para Jugar", width/2, height -height/4);
  }
  
}
