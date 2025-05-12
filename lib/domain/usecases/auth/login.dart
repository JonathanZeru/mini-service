import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/user_model.dart';
import 'package:service_booking_app/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, UserModel>> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
