import 'error.dart';
import 'objectLibrary.dart';

mixin Lend {
  bool isLend = false;
  List<String> lendHistorial = [];

  void toLend(Objectlibrary object) {
    if (isLend) {
      throw ObjectException('Objeto: ${object.title}, ya esta prestado prestado');
    }
    isLend = true;
    lendHistorial.add('${DateTime.now()} Objeto: ${object.title}, Prestado');
  }

  void toReturn(Objectlibrary object) {
    isLend = false;
    lendHistorial.add('${DateTime.now()} Objeto: ${object.title}, devuelto');
  }

  List<String> get getLendHistorial {
   return lendHistorial;
  }

  void showLendHistorial(){
    if(getLendHistorial.isNotEmpty) {
      for(var history in getLendHistorial) {
        print("- $history");
      }
    } else {
      print('HIsitorial de PRESTADOS vacio');
    }
  }
}
