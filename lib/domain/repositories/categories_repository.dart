import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/category_model.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories({int? page, int? limit});
  Future<Either<Failure, CategoryModel>> getCategory(String id);
  Future<Either<Failure, CategoryModel>> createCategory(CategoryModel category);
  Future<Either<Failure, CategoryModel>> updateCategory(String id, CategoryModel category);
  Future<Either<Failure, bool>> deleteCategory(String id);
}
