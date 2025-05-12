import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/user_model.dart';
import 'package:service_booking_app/domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<Either<Failure, UserModel>> call(String username, String email, String password) async {
    return await repository.register(username, email, password);
  }
}
