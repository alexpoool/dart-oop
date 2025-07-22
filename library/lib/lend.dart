import 'error.dart';

mixin Lend {
  bool isLend = false;
  List<String> lendHistorial = [];

  void toLend() {
    if (isLend) {
      throw ObjectException('Object Lent');
    }
    isLend = true;
    lendHistorial.add('${DateTime.now().toIso8601String()} Object Lent ');
  }

  void toReturn() {
    isLend = false;
    lendHistorial.add('${DateTime.now()} Object Return');
  }

  void showHistorial() {
    print('\nLent Historial');
    for(var history in lendHistorial){ 
      print('- $history');
    }
  }
}
