class ServerException implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  String toString() {
    return 'ServerException{message: $message}';
  }
}

class DatabaseException implements Exception {
  final String message;

  const DatabaseException(this.message);

  @override
  String toString() {
    return 'DatabaseException{message: $message}';
  }
}
