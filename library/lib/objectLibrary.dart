abstract class Objectlibrary {
  final String id;
  final String title;
  final int yearPublication;

  Objectlibrary({
    required this.id,
    required this.title,
    required this.yearPublication,
  });

  void showInfo();
}
