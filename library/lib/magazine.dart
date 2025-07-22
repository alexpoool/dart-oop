import 'read.dart';
import 'objectLibrary.dart';

class Magazine extends Objectlibrary with Read {
  final int number;
  final String editorial;

  Magazine({
    required super.id,
    required super.title,
    required super.yearPublication,
    required this.number,
    required this.editorial,
  });

  @override
  void showInfo() {
    print('''
      ID: $id,
      TITLE: $title,
      PUBLICATION: $yearPublication,
      NUMBER: $number,
      EDITORIAL: $editorial,
      ''');
  }
}
