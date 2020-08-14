
/*****************************************************

S = Suelo
L = Lava
1 = Posición del Jugador 1 

*****************************************************/

char [][] defaultLevel = {{'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'},
                          {'S',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                          {'S',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                          {'S',' ',' ',' ',' ',' ',' ','C',' ',' ','S',' ',' ',' ','C',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                          {'S',' ',' ',' ',' ',' ',' ','C',' ',' ','S',' ',' ',' ','C','B',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                          {'S',' ',' ',' ',' ',' ','P','P','P','P','P','P','P','P','P','P',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S'},
                          {'S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S'},
                          {'S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','P',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S'},
                          {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','P',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S'},
                          {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','P',' ',' ',' ',' ','S','S','S',' ',' ','S','S'},
                          {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','P',' ',' ',' ',' ','S','S','S',' ',' ','S','S'},
                          {'S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ','1',' ',' ',' ','X',' ',' ',' ',' ','P',' ',' ',' ',' ','S','S','S',' ',' ','S','S'},
                          {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','P',' ',' ',' ','S','S','S','S','S',' ','S','S'},
                          {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S'},
                          {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S'},
                          {'S','S','S','S','S',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','S','S','S','S','S','S','S','S'},
                          {'S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S'}};

char [][] level = new char [numAlto][numAncho];


//Configuración del nivel
void configLevel(int lvl){
  String fileNameLevel = "Level"+lvl+".txt";  //Nombre del Archivo
  String levelFile [] = new String[numAlto];  //Almacena todo lo que tenga el archivo
  
  //Comprueba que el archivo exista antes de intentar importarlo
  if(!fileExists(fileNameLevel)){  //Si no existe
    level = defaultLevel;  //El nivel es el que está por defecto
    
  }else{  //El archivo sí existe entonces lo importa
    levelFile = loadStrings(fileNameLevel);  //Carga el archivo
    
    if(levelFile.length != numAlto){  //El archivo tiene menos o más filas de la cantidad de bloques de alto
      println("Level Corrupto");
      level = defaultLevel;
    }else{  //El archivo tiene la cantidad de filas correctas
      
      boolean valido = true;
      for(int r = 0; r < levelFile.length; r++){  //Recorre cada string del array
        if(levelFile[r].length() != numAncho){  //Si tiene una cantidad de carácteres diferente a la del ancho
          println("Tamaño incorrecto");
          valido = false;  //No es valido
          break;
        }
      }
      if(!valido){
        level = defaultLevel;
      }else{
        printArray(levelFile);  //Muestra el nivel
        println("Level Válido");
        for(int r = 0; r < levelFile.length; r++){
          for(int c = 0; c < levelFile[r].length(); c++){
            level[r][c] = levelFile[r].charAt(c);  //Asigna a la matriz de char 
          }
        }
        
      }
    }  //end tiene la cantidad de filas correctas
  }  //end el archivo existe
}  //end configLevel
