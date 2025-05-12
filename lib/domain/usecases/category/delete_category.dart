import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';

class DeleteCategory {
  final CategoriesRepository repository;

  DeleteCategory(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    return await repository.deleteCategory(id);
  }
}
