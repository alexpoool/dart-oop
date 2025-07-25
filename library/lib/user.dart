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
      book.toLend();
      lentBooks.add(book);
      print('Usuario $name tiene prestado ${book.title}');
    } on ObjectException catch(err) {
      print(err);
    }
  }
 
  void readMagazine(Magazine magazine) {
    try {
      magazine.readObject();
      lentMagazines.add(magazine);
      print('Usuario $name esta leyendo ${magazine.title}');
    } on ObjectException catch(err) {
      print(err);
    } 
  }

  void returnBook(Book book) {
    if (lentBooks.contains(book)) {
      book.toReturn();
      lentBooks.remove(book);
      print('Usuario devolvio ${book.title} ');
    } else {
      print('Usuario $name no tiene este libro');
    } 
  
  }

  void letReadMagazine(Magazine magazine) {
    if (lentBooks.contains(magazine)) {
      magazine.letReadObject();
      lentMagazines.remove(magazine);
      print('Usuario $name dejo de leer ${magazine.title}');
    } else {
      print('Usuario $name no tiene esta revista');
    }
  }

  void showBooksOnLent() {
    print('$name: Libros Prestados');
    if (lentBooks.isNotEmpty) {
      for (var lentBook in lentBooks) {
        lentBook.showInfo();
      }
    } else {
      print("$name no tiene libros prestados");
    }
  }

  void showMagazinesOnReading() {
    print('$name: Revistas en Lectura');
    if (lentMagazines.isNotEmpty) {
      for (var lentMagazine in lentMagazines) {
        lentMagazine.showInfo();
      }
    } else {
      print("$name no esta leyendo revistas");
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
