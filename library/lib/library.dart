import 'data.dart';
import 'objectLibrary.dart';
import 'user.dart';
import 'magazine.dart';
import 'book.dart';
import 'error.dart';

class Library {
  List<Objectlibrary> _collection = [];
  List<User> _users = [];

  List<Objectlibrary> get collection {
    return _collection;
  }

  List<User> get user {
    return _users;
  }

  Future<void> loadInitialData() async {
    await Future.delayed(Duration(seconds: 1));
    _collection.addAll(books);
    await Future.delayed(Duration(seconds: 1));
    _collection.addAll(magazines);
  }

  void addElement(Objectlibrary object) {
    _collection.add(object);
  }

  void registerUser(User user) {
    _users.add(user);
  }

  Objectlibrary? findObjectByID(String id){
    for(var object in _collection) {
      if(object.id.toLowerCase() == id.toLowerCase()){
        return object;
      } 
    }
    return null;
  }

  Objectlibrary? findByTitle(String title){
    for(var object in _collection) {
      if(object.title.toLowerCase() == title.toLowerCase()){
        return object;
      } 
    }
    return null;
  }

  User? findUserByName(String name){
    for(var user in _users) {
      if(user.name.toLowerCase() == name.toLowerCase()){
        return user;
      } 
    }
    return null;
  }

  void showCataloge() {
    print('\nCatalogo');
    for(var element in _collection) {
      element.showInfo();
    } 
  } 
  
  void showUsers() {
    print('\nCatalogo');
    for(var user in _users) {
      user.showInfo();
    } 
  } 

  void lendBook(User userToLent, Book bookToLent){
    if(_users.contains(userToLent)){
      for(var user in _users){
        if (userToLent.id == user.id){
          userToLent.takeLendBook(bookToLent);
        }
      }
    }else{
      throw UserException('User not register');
    }
  }

  void userReadMegazine(User userToLent, Magazine magazineToLent){
    if(_users.contains(userToLent)){
      for(var user in _users){
        if (userToLent.id == user.id){
          userToLent.readMagazine(magazineToLent);
        }
      }
    }else{
      throw UserException('User not register');
    }
  }

  void userReturnBook(User user,Book book) {
    for(User userRegister in  _users){
      if(user.id == userRegister.id){
        userRegister.returnBook(book);
      }
    }
  }
  
  void userReturnMagazine(User user,Magazine magazine) {
    for(User userRegister in  _users){
      if(user.id == userRegister.id){
        userRegister.letReadMagazine(magazine);
      }
    }
  }
}