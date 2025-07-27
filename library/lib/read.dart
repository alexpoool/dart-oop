import 'error.dart';
import 'objectLibrary.dart';

mixin Read {
  bool reading = false;
  List<String> readHistorial = [];

  void readObject(Objectlibrary object) {
    if(reading){
      throw ObjectException('Objeto ya esta siendo leido');
    }
    reading = true;
    readHistorial.add('${DateTime.now()} Objeto: ${object.title}, leido');
  }

  void letReadObject(Objectlibrary object) {
    reading = false;
    readHistorial.add('${DateTime.now()} Objeto: ${object.title}, se ha dejado de leer');
  }

  List<String> get getReadHistorial {
    return readHistorial;
  }

  
  void showReadHistorial(){
    if(getReadHistorial.isNotEmpty) {
      for(var history in getReadHistorial) {
        print("- $history");
      }
    } else {
      print('HIsitorial de LEIDOS vacio');
    }
  }

}