int frame;
void pressSpace(){
  frame=(frameCount/10)%10;
  println(frame);
  
  if(frame>=0 && frame <=7){
  fill(0);
  textSize(30);
  textAlign(CENTER,CENTER);
  text("Press space to continue",numAncho*sizeBlock/2, numAlto*sizeBlock*3/4);
   
  }
  
}
