/*****************************************************

S = Suelo
P = Teleports
1 = Posición del Jugador 1
2 = Posición del Jugador 2

*****************************************************/

char [][] map = new char [numBlocksY][numBlocksX];  //Configuración de los bloques
PImage backgroundMap;  //Imagen de fonde del nivel
int pastMap = -1;  //inicia en -1 para que se pueda jugar cualquier nivel en principio

//Importar el mapa y configurarlo
void importMap(int numMap){
  String fileNameMapTXT = "map"+numMap+".txt";  //Nombre del archivo .txt
  String fileNameMapPNG = "map"+numMap+".png";  //Nombre del archivo .png
  String mapFile [] = new String[numBlocksY];  //Almacena todo lo que tenga el archivo
  
  for(int i = 0; i < map.length; i++){
    for(int j = 0; j < map[i].length; j++){
      map[i][j] = ' ';
    }
  }
  
  //Comprueba que el archivo exista antes de intentar importarlo
  if(!fileExists(fileNameMapTXT, "maps")){  //Si no existe
    println("¡ERROR!");
    println("El archivo", fileNameMapTXT, "NO existe o no se ecuentra en la carpeta \"data\\maps\"");
    println("Revisa el nombre del archivo y la carpeta \"data\\maps\"");
    exit();  //Acaba el programa
    
  }else{  //El archivo sí existe entonces lo importa
    mapFile = loadStrings("data/maps/"+fileNameMapTXT);  //Carga el archivo
    
    if(mapFile.length != numBlocksY){  //El archivo tiene menos o más filas de la cantidad de bloques de alto
      println("¡ERROR!");
      println("El archivo", fileNameMapTXT, "NO es válido, por favor vuelva a generar el mapa");
      exit();
      
    }else{  //El archivo tiene la cantidad de filas correctas
      
      boolean valido = true;
      for(int r = 0; r < mapFile.length; r++){  //Recorre cada string del array
        if(mapFile[r].length() != numBlocksX){  //Si tiene una cantidad de carácteres diferente a la del ancho
          valido = false;  //No es valido
          break;
        }
      }
      if(!valido){
        println("¡ERROR!");
        println("El archivo", fileNameMapTXT, "NO es válido, por favor vuelva a generar el mapa");
        exit();
        
      }else{  //Mapa válido
        for(int r = 0; r < mapFile.length; r++){
          for(int c = 0; c < mapFile[r].length(); c++){
            map[r][c] = mapFile[r].charAt(c);  //Asigna a la matriz de char 
          }
        }
        
      }
    }  //end tiene la cantidad de filas correctas
  }  //end el archivo existe
  
  //Importar la imagen
  if(!fileExists(fileNameMapPNG, "maps")){
    println("¡ERROR!");
    println("El archivo", fileNameMapPNG, "NO existe o no se ecuentra en la carpeta \"data\\maps\"");
    println("Revisa el nombre del archivo y la carpeta \"data\\maps\"");
    exit();  //Acaba el programa
  }else{
    backgroundMap = loadImage("data/maps/"+fileNameMapPNG);
  }
  
  
  //Configuración
  numBGroundMap = 0;  //Resetea la variable
  numBTeleportMap = 0;  //Resetea la variable
  //Reestablecer el tamaño y posición de los bloques a una unidad para que cuando se vuelva a importar pueda cambiarse de tamaño correcto
  for(int i = 0; i < Ground.length; i++){
    Ground[i].setXY(0,0);
    Ground[i].setSize(sizeBlocks);
  }
  
  //Establece la nueva configuración
  for(int i = 0; i < map.length; i++){
    for(int j = 0; j < map[i].length; j++){
      
      if(map[i][j] == 'S'){  //Recorre todo la matriz hasta que encuentra una S por primera vez
        Ground[numBGroundMap].setXY(j*sizeBlocks, i*sizeBlocks);  //Se establece esa la posición del bloque
        
        for(int sX = 1; sX < map[i].length -j; sX++){
          if(map[i][j+sX] == 'S'){  //Si a la derecha hay más bloques S
            Ground[numBGroundMap].setSize((sX+1)*sizeBlocks);  //Aumenta el ancho del bloque
          }else{  //Si no hay otra S seguida se detiene y continua para contruir un nuevo bloque
            j += sX-1;
            break;
          }
        }
        numBGroundMap++;  //Aumenta el número de bloques Ground que hay
        
      }else if(map[i][j] == '1'){
        Players[0].setXY(j*sizeBlocks, i*sizeBlocks);
        PlayersCol[0].setXY(j*sizeBlocks, i*sizeBlocks);  //"Máscara" de colisión del jugador1 para con los otros jugadores
      }else if(map[i][j] == '2'){
        Players[1].setXY(j*sizeBlocks, i*sizeBlocks);
        PlayersCol[1].setXY(j*sizeBlocks, i*sizeBlocks);
      }else if(map[i][j] == 'P'){
        Teleport[numBTeleportMap].setXY(j*sizeBlocks, i*sizeBlocks);
        numBTeleportMap++;
        numBTeleportMap = constrain(numBTeleportMap, 0, Teleport.length-1);
      }
      
    }  //end for (j)
  }  //end for (i)
  
  //Establecer jugador aleatorio con la bomba
  
  playerBomb = round(random(0,Players.length-1));
  for(int i = 0; i < Players.length; i++){
    Players[i].reset();  //Resetea las variable del jugador
    if(i == playerBomb){
      Players[i].bomb = true;
    }else{
      Players[i].bomb = false;
    }
    Players[i].setSprite();
    Players[i].setSprite();  //Se llama dos veces para que al final quedé la variable bomb en el valor correcto
  }
  
  //Resetear tiempo
  timer = timerMax;
  secondsTimer = second();
  timeAfterExplosion = timeMaxAfterExplosion;
} //end importMap
