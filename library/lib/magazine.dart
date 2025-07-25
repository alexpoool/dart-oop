import 'read.dart';
import 'objectLibrary.dart';

class Magazine  with Read implements Objectlibrary {
  final int number;
  final String editorial;
  @override
  String id;
  @override
  String title;
  @override
  int yearPublication;

  Magazine({
    required this.id,
    required this.title,
    required this.yearPublication,
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
