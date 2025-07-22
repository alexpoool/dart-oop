
class ObjectException implements Exception {
  final String message;
  ObjectException( this.message);

  @override
  String toString() => 'ObjectException: $message';
}

class UserException implements Exception {
  final String message;
  UserException(this.message);

  @override
  String toString() => 'UserException: $message';
}
