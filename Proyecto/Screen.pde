
/*****************************************************




*****************************************************/

void setupScreen(){
  surface.setSize(numAncho*sizeBlock, numAlto*sizeBlock);  //Define el tamaño de la ventana
  surface.setLocation((displayWidth/2) - numAncho*sizeBlock/2, (displayHeight/2) - numAlto*sizeBlock/2);  //Aparezca centrada la ventana
  surface.setTitle("It's just a Hug");  //Título de la ventana
  
  
  surface.setResizable(true);
}
