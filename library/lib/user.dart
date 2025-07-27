import 'book.dart';
import 'magazine.dart';
import 'error.dart';

class User {
  final String id;
  final String name;
  final List<Book> lentBooks = [];
  final List<Magazine> lentMagazines = [];

  User({required this.id, required this.name});

  void takeLendBook(Book book) {
    try {
      book.toLend(book);
      lentBooks.add(book);
      print('Usuario $name tiene prestado ${book.title}');
    } on ObjectException catch(err) {
      print(err);
    }
  }
 
  void readMagazine(Magazine magazine) {
    try {
      magazine.readObject(magazine);
      lentMagazines.add(magazine);
      print('Usuario $name esta leyendo ${magazine.title}');
    } on ObjectException catch(err) {
      print(err);
    } 
  }

  void returnBook(Book book) {
    if (lentBooks.contains(book)) {
      book.toReturn(book);
      lentBooks.remove(book);
      print('Usuario devolvio ${book.title} ');
    } else {
      print('Usuario $name no tiene este libro');
    } 
  
  }

  void letReadMagazine(Magazine magazine) {
    if (lentMagazines.contains(magazine)) {
      magazine.letReadObject(magazine);
      if(lentMagazines.remove(magazine)){
        print('Usuario $name dejo de leer ${magazine.title}');
      } else {
        print('No se pudo devolver ${magazine.title}');
      }
    } else {
      print('Usuario $name no tiene esta revista');
    }
  }

  void showHistorial() {
    if(lentBooks.isNotEmpty){
        for(var book in lentBooks) {
          book.showLendHistorial();
        }
    } else {
      print('Usuario $name no tiene libros prestados');
    }

    if(lentMagazines.isNotEmpty) {
      for(var magazine in lentMagazines) {
          magazine.showReadHistorial();
        }
    } else {
      print('Usuario $name no esta leyendo revistas');
    }
  }

  void showInfo() {
    print(
      '''
      ID: $id,
      NAME: $name, 
      '''
    );
  }
}
