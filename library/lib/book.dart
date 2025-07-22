import 'lend.dart';
import 'read.dart';
import 'objectLibrary.dart';

class Book extends Objectlibrary with Lend, Read {
  final String author;
  final String isbn;

  Book({
    required super.id,
    required super.title,
    required super.yearPublication,
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
