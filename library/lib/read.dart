import 'error.dart';

mixin Read {
  bool reading = false;
  List<String> readHistorial = [];

  void readObject() {
    if(reading){
      throw ObjectException('Objeto ya esta siendo leido');
    }
    reading = true;
    readHistorial.add('${DateTime.now()} Objeto leido');
  }

  void letReadObject() {
    reading = false;
    readHistorial.add('${DateTime.now()} Objeto se ha dejado de leer');
  }

  void showHistorial() {
    print('Historial de Lectura');
    for(var history in readHistorial){ 
      print('- $history');
    }
  }

}