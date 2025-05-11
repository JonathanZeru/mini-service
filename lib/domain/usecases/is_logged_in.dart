import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/domain/repositories/auth_repository.dart';

class IsLoggedIn {
  final AuthRepository repository;

  IsLoggedIn(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.isLoggedIn();
  }
}
