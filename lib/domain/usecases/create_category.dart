import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';

class CreateCategory {
  final CategoriesRepository repository;

  CreateCategory(this.repository);

  Future<Either<Failure, CategoryModel>> call(CategoryModel category) async {
    return await repository.createCategory(category);
  }
}
