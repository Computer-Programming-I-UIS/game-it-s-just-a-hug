
/*****************************************************

S = Suelo
L = Lava
1 = Posición del Jugador 1
2 = Posición del Jugador 2

*****************************************************/

char [][] defaultMap = {{'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ','S',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ','S',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ','S','S','S',' ','S','S','S','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ','S','S','S',' ','S','S','S','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ','1',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ','S','S','S',' ','S','S','S','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ','S','S','S','S','S','S','S','S','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S','S'},
                        {'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'},
                        {'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'}};

char [][] map = new char [numBlocksY][numBlocksX];


//Importar el mapa y configurarlo

void importMap(int numMap){
  String fileNameMap = "map"+numMap+".txt";  //Nombre del Archivo
  String mapFile [] = new String[numBlocksY];  //Almacena todo lo que tenga el archivo
  
  //Comprueba que el archivo exista antes de intentar importarlo
  if(!fileExists(fileNameMap)){  //Si no existe
    map = defaultMap;  //El nivel es el que está por defecto
    
  }else{  //El archivo sí existe entonces lo importa
    mapFile = loadStrings(fileNameMap);  //Carga el archivo
    
    if(mapFile.length != numBlocksY){  //El archivo tiene menos o más filas de la cantidad de bloques de alto
      println("Level Corrupto");
      map = defaultMap;
    }else{  //El archivo tiene la cantidad de filas correctas
      
      boolean valido = true;
      for(int r = 0; r < mapFile.length; r++){  //Recorre cada string del array
        if(mapFile[r].length() != numBlocksX){  //Si tiene una cantidad de carácteres diferente a la del ancho
          println("Tamaño incorrecto");
          valido = false;  //No es valido
          break;
        }
      }
      if(!valido){
        map = defaultMap;
      }else{
        println("Mapa Válido");
        for(int r = 0; r < mapFile.length; r++){
          for(int c = 0; c < mapFile[r].length(); c++){
            map[r][c] = mapFile[r].charAt(c);  //Asigna a la matriz de char 
          }
        }
        
      }
    }  //end tiene la cantidad de filas correctas
  }  //end el archivo existe
  
  
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
