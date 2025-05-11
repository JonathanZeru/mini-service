import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login(String username, String password);
  Future<Either<Failure, UserModel>> register(String username, String email, String password);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserModel?>> getCurrentUser();
  Future<Either<Failure, bool>> isLoggedIn();
}
