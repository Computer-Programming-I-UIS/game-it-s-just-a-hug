/*****************************************************

S = Suelo
1 = Posición del Jugador 1
2 = Posición del Jugador 2

*****************************************************/

char [][] map = new char [numBlocksY][numBlocksX];  //Configuración de los bloques
PImage backgroundMap;  //Imagen de fonde del nivel


//Importar el mapa y configurarlo
void importMap(int numMap){
  String fileNameMapTXT = "map"+numMap+".txt";  //Nombre del archivo .txt
  String fileNameMapPNG = "map"+numMap+".png";  //Nombre del archivo .png
  String mapFile [] = new String[numBlocksY];  //Almacena todo lo que tenga el archivo
  
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
  
  for(int i = 0; i < map.length; i++){
    for(int j = 0; j < map[i].length; j++){
      
      if(map[i][j] == 'S'){  //Recorre todo la matriz hasta que encuentra una S por primera vez
        Ground[numBGroundMap].setXY(j*sizeBlocks, i*sizeBlocks);  //Se establece esa la posición del bloque
        
        for(int sX = 1; sX < map[i].length -j; sX++){
          if(map[i][j+sX] == 'S'){  //Si a la derecha hay más bloques S
            Ground[numBGroundMap].setSize((sX+1)*sizeBlocks);  //Aumenta el ancho del bloque
          }else{  //Si no hay otra S seguida se detiene y continua para contruir un nuevo bloque
            j += sX;
            break;
          }
        }
        numBGroundMap++;  //Aumenta el número de bloques Ground que hay
        
      }else if(map[i][j] == '1'){
        Players[0].setXY(j*sizeBlocks, i*sizeBlocks);
      }else if(map[i][j] == '2'){
        Players[1].setXY(j*sizeBlocks, i*sizeBlocks);
      }
      
    }  //end for (j)
  }  //end for (i)
  
} //end importMap
