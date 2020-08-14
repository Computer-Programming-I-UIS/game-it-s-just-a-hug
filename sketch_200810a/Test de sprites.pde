int i; 
PImage spritehug;
int frame;
boolean acode=false;
boolean dcode=false;
int  afterkey=0;
int dx=4;
int x=50;
int y=50;

void setup(){
  size(720,480);
  
  
  spritehug = loadImage("Spritesheet Azul caminante Todas.png");
 
  
}

void draw(){
  
  frame=(frameCount/2)%10;  
  /*la funcion draw se ejecuta a 60f/s asi que divido en 6 para obtener 10f/s y el 
  mudulo me dice en posicion del 1 al 10 estamos
  
  
     */
   
   println(dcode);
       
   background(255);
   if (dcode || acode){
     if(dcode){
       println("whatsaaaap");
       
       copy(spritehug,frame*320,0,320,320,x,y,100,100);
       x+=dx;
        }
     if(acode){
       
       copy(spritehug,frame*320,320,320,320,x,y,100,100);
       x-=dx;
       }  
     }
     
   else{
     if(afterkey=='d' || afterkey==0)copy(spritehug,0,0,320,320,x,y,100,100);
     if(afterkey=='a')copy(spritehug,0,320,320,320,x,y,100,100); 
   
   
   
   }
   
   }
   
   
   
void keyPressed(){
 // if(key==CODED)keycontrol(keyCode, true);
  
  if(key != CODED)keycontrol(key, true);
}
void keyReleased(){
 //if(key==CODED)keycontrol(keyCode, false);

  
 if(key != CODED){
   keycontrol(key, false);
   afterkey= key;
 
 
 }
}
   
void keycontrol(int k, boolean b){
   switch(k){
    /* case UP:
     upcode=b;
     break;
     
     
     case DOWN:
     downcode=b;
     break;
     */
     case 'a':
     acode=b;
     break;
     
     case 'd':
     dcode=b;
     break;
     
     default:
     
     break;
     
   
     
   }
 
  
}
