abstract class Failure {
  final String message;
  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required String message}) : super(message: message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure({required String message}) : super(message: message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure({required String message}) : super(message: message);
}

class BadRequestFailure extends Failure {
  BadRequestFailure({required String message}) : super(message: message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({required String message}) : super(message: message);
}
