

boolean showStart = true;

void pressSpace(){
    
  if(!showMenu)if(frameCount%25 == 0)  showStart = !showStart;  //Cada 25 frames cambia de estado     //si no se esta mostrando el menu entonces cambiar intermitemente cada 25 frames
  
  if(showStart){
    textFont(pixel);
    fill(0);
    textSize(30);
    textAlign(CENTER,CENTER);
    text("Presione espacio para continuar", width/2, height -height/4);
  }
  
}
