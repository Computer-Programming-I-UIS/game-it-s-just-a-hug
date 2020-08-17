  
/*****************************************************




*****************************************************/

void setupScreen(){
  int tempSize[] = {displayWidth/(numAncho+3),displayHeight/(numAlto+3)};
  sizeBlock = min(tempSize);
  println(tempSize[0],tempSize[1],sizeBlock);
  
  surface.setSize(numAncho*sizeBlock, numAlto*sizeBlock);  //Define el tamaño de la ventana
  surface.setLocation((displayWidth/2) - numAncho*sizeBlock/2, (displayHeight/2) - numAlto*sizeBlock/2 - sizeBlock);  //Aparezca centrada la ventana
  surface.setTitle("It's just a Hug");  //Título de la ventana
  
  
  surface.setResizable(true);
}
