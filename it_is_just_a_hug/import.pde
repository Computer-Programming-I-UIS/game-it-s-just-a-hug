/***************************************************************************************
 Permite importar un dato de un archivo que se almacena en la carpeta "data"
 
 Referencia:
  *  https://discourse.processing.org/t/checking-if-a-file-exists-strange-runtime-error/20276
  *  https://forum.processing.org/two/discussion/23031/determining-file-existance-in-the-specified-directory
  *  https://discourse.processing.org/t/how-to-check-if-a-file-is-exist-in-data-folder-by-code/589
  *  https://es.stackoverflow.com/questions/92139/c%C3%B3mo-verificar-que-el-valor-de-una-variable-string-es-un-integer-en-java

***************************************************************************************/

boolean fileExists(String fileName){
  File dataFolder = new File(dataPath(""));
  
  for (File file : dataFolder.listFiles()) {    //Escanea todos los archivos en la carpeta data  (*Otra sintaxis de for)
    if (file.getName().equals(fileName)){    //Si el nombre del archivo es el mismo del que se necesita
      return true;
    }
  }
  return false;
}

boolean isInteger(String numero){
    try{    //Intenta combertirlo a entete
        Integer.parseInt(numero);    //Si sí se pudo es porque es entero
        return true;
    }catch(NumberFormatException e){    //Si genera error es porque no lo es
        return false;
    }
}
