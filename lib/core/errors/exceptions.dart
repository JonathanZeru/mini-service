class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException({required this.message});
}
