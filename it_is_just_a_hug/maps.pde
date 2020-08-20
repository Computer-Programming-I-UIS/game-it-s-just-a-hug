
/*****************************************************

S = Suelo
L = Lava
1 = Posición del Jugador 1
2 = Posición del Jugador 2

*****************************************************/

char [][] defaultMap = {{'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ','S',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S',' ',' ',' ',' ',' ',' ','C',' ',' ','S',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ','S','S','S',' ','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ','S','S','S',' ','S'},
                        {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ','1',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ',' ','S','S','S',' ','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S',' ',' ',' ','S','S','S','S','S','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S'},
                        {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S'},
                        {'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'},
                        {'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'}};

char [][] map = new char [numAlto][numAncho];


//Configuración del nivel
void importMap(int numMap){
  String fileNameMap = "map"+numMap+".txt";  //Nombre del Archivo
  String mapFile [] = new String[numAlto];  //Almacena todo lo que tenga el archivo
  
  //Comprueba que el archivo exista antes de intentar importarlo
  if(!fileExists(fileNameMap)){  //Si no existe
    map = defaultMap;  //El nivel es el que está por defecto
    
  }else{  //El archivo sí existe entonces lo importa
    mapFile = loadStrings(fileNameMap);  //Carga el archivo
    
    if(mapFile.length != numAlto){  //El archivo tiene menos o más filas de la cantidad de bloques de alto
      println("Level Corrupto");
      map = defaultMap;
    }else{  //El archivo tiene la cantidad de filas correctas
      
      boolean valido = true;
      for(int r = 0; r < mapFile.length; r++){  //Recorre cada string del array
        if(mapFile[r].length() != numAncho){  //Si tiene una cantidad de carácteres diferente a la del ancho
          println("Tamaño incorrecto");
          valido = false;  //No es valido
          break;
        }
      }
      if(!valido){
        map = defaultMap;
      }else{
        printArray(mapFile);  //Muestra el mapa
        println("Mapa Válido");
        for(int r = 0; r < mapFile.length; r++){
          for(int c = 0; c < mapFile[r].length(); c++){
            map[r][c] = mapFile[r].charAt(c);  //Asigna a la matriz de char 
          }
        }
        
      }
    }  //end tiene la cantidad de filas correctas
  }  //end el archivo existe
}  //end importMap

//Configurar Bloques
