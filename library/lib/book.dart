import 'lend.dart';
import 'read.dart';
import 'objectLibrary.dart';

class Book with Lend, Read implements Objectlibrary {
  final String author;
  final String isbn;
  @override
  String id;
  @override
  String title;
  @override
  int yearPublication;

  Book({
    required this.id,
    required this.title,
    required this.yearPublication,
    required this.author,
    required this.isbn,
  });

  @override
  void showInfo() {
    print('''
      ID: $id,
      TITLE: $title,
      PUBLICATION: $yearPublication,
      AUTHOR: $author,
      ISBN: $isbn
    ''');
  }
}
