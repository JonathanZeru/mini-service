import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/core/local/hive_manager.dart';
import 'package:service_booking_app/data/models/user_model.dart';
import 'package:service_booking_app/domain/repositories/auth_repository.dart';
import 'package:uuid/uuid.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, UserModel>> login(String username, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, accept any username/password combination
      if (username.isEmpty || password.isEmpty) {
        return Left(BadRequestFailure(message: 'Username and password are required'));
      }
      
      // Create a mock user
      final user = UserModel(
        id: const Uuid().v4(),
        username: username,
        email: '$username@example.com',
        isAdmin: username.toLowerCase() == 'admin',
      );
      
      // Save user to local storage
      await HiveManager.saveUser(user);
      
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(String username, String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Validate inputs
      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        return Left(BadRequestFailure(message: 'All fields are required'));
      }
      
      // Create a new user
      final user = UserModel(
        id: const Uuid().v4(),
        username: username,
        email: email,
        isAdmin: false,
      );
      
      
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await HiveManager.deleteUser();
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final user = await HiveManager.getUser();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final user = await HiveManager.getUser();
      return Right(user != null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
