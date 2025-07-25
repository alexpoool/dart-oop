import 'data.dart';
import 'user.dart';
import 'magazine.dart';
import 'book.dart';

class Library {
  List<Book> _bookCollection = [];
  List<Magazine> _magazineCollection = [];
  List<User> _users = [];

  List<Book> get bookCollection {
    return _bookCollection;
  }

  List<Magazine> get magazineCollection {
    return _magazineCollection;
  }

  List<User> get users {
    return _users;
  }

  Future<void> loadInitialData() async {
    await Future.delayed(Duration(seconds: 1));
    _bookCollection.addAll(books);
    await Future.delayed(Duration(seconds: 1));
    _magazineCollection.addAll(magazines);
  }

  void addBook(Book book) {
    _bookCollection.add(book);
  }

  void addMagazine(Magazine magazine) {
    _magazineCollection.add(magazine);
  }

  void addUser(User user) {
    _users.add(user);
  }

  Book? findBookByID(String id) {
    for (var book in _bookCollection) {
      if (book.id.toLowerCase() == id.toLowerCase()) {
        return book;
      }
    }
    return null;
  }

  Magazine? findMagazineByID(String id) {
    for (var magazine in _magazineCollection) {
      if (magazine.id.toLowerCase() == id.toLowerCase()) {
        return magazine;
      }
    }
    return null;
  }

  Book? findBookByTitle(String title) {
    for (var book in _bookCollection) {
      if (book.title.toLowerCase() == title.toLowerCase()) {
        return book;
      }
    }
    return null;
  }

  Magazine? findMagazineByTitle(String title) {
    for (var magazine in _magazineCollection) {
      if (magazine.title.toLowerCase() == title.toLowerCase()) {
        return magazine;
      }
    }
    return null;
  }

  User? findUserByName(String name) {
    for (var user in _users) {
      if (user.name.toLowerCase() == name.toLowerCase()) {
        return user;
      }
    }
    return null;
  }

  void showCataloge() {
    print('\nCatalogo');

    print('\nBooks');
    for (var book in _bookCollection) {
      book.showInfo();
    }

    print('\nMagazines');
    for (var magazine in _magazineCollection) {
      magazine.showInfo();
    }
  }

  void showUsers() {
    print('\nUsers');
    for (var user in _users) {
      user.showInfo();
    }
  }

  void lendBookUser(User userToLent, Book bookToLent) {
    for (var user in users) {
      if (userToLent.id == user.id) {
        userToLent.takeLendBook(bookToLent);
      }
    }
  }

  void readUserMegazine(User userToLent, Magazine magazineToLent) {
    for (var user in users) {
      if (userToLent.id == user.id) {
        userToLent.readMagazine(magazineToLent);
      }
    }
  }

  void returnUserBook(User user, Book book) {
    for (var userRegister in users) {
      if (user.id == userRegister.id) {
        userRegister.returnBook(book);
      }
    }
  }

  void returnUserMagazine(User user, Magazine magazine) {
    for (User userRegister in users) {
      if (user.id == userRegister.id) {
        userRegister.letReadMagazine(magazine);
      }
    }
  }
}
