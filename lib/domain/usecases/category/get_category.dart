import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';

class GetCategory {
  final CategoriesRepository repository;

  GetCategory(this.repository);

  Future<Either<Failure, CategoryModel>> call(String id) async {
    return await repository.getCategory(id);
  }
}
