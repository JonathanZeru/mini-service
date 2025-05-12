import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';

class GetCategories {
  final CategoriesRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<CategoryModel>>> call({
    int? page,
    int? limit,
  }) async {
    return await repository.getCategories(page: page, limit: limit);
  }
}
