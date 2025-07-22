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
    } on ObjectException catch(err){
      print(err);
    } catch (err) {
      print(err);
    }
  }
 
  void readMagazine(Magazine magazine) {
    try {
      magazine.readObject();
      lentMagazines.add(magazine);
    } on ObjectException catch(err) {
      print(err);
    } catch (err) {
      print(err);
    }
  }

  bool? returnBook(Book book) {
    if (lentBooks.contains(book)) {
      book.toReturn();
      return lentBooks.remove(book);
    } else {
      return null;
    }
  }

  bool? letReadMagazine(Magazine magazine) {
    if (lentBooks.contains(magazine)) {
      magazine.letReadObject();
      return lentMagazines.remove(magazine);
    } else {
      return null;
    }
  }

  void showLentBooks() {
    print('\n$name: Lent Book');
    if (lentBooks.isNotEmpty) {
      for (var lentBook in lentBooks) {
        lentBook.showInfo();
      }
    } else {
      print("\n$name: Haven't Lent Books");
    }
  }

  void showLentMagazines() {
    print('\n$name: Lent Magazines');
    if (lentMagazines.isNotEmpty) {
      for (var lentMagazine in lentMagazines) {
        lentMagazine.showInfo();
      }
    } else {
      print("\n$name: Haven't Lent Magazine");
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
