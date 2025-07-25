import 'error.dart';

mixin Lend {
  bool isLend = false;
  List<String> lendHistorial = [];

  void toLend() {
    if (isLend) {
      throw ObjectException('Objeto ya esta prestado prestado');
    }
    isLend = true;
    lendHistorial.add('${DateTime.now().toIso8601String()} Objeto Prestado');
  }

  void toReturn() {
    isLend = false;
    lendHistorial.add('${DateTime.now()} Objeto devuelto');
  }

  void showHistorial() {
    print('Historial de prestados');
    for(var history in lendHistorial){ 
      print('- $history');
    }
  }
}
