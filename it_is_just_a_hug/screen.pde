  
/*****************************************************




*****************************************************/

void setupScreen(){
  surface.setSize(numAncho*sizeBlocks, numAlto*sizeBlocks);  //Define el tamaño de la ventana
  surface.setLocation((displayWidth/2) - numAncho*sizeBlocks/2, (displayHeight/2) - numAlto*sizeBlocks/2 - sizeBlocks);  //Aparezca centrada la ventana
  surface.setTitle("It's just a Hug");  //Título de la ventana
  
  //surface.setResizable(true);
}
