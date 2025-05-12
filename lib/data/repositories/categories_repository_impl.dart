import 'package:service_booking_app/core/errors/exceptions.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final ApiProvider apiProvider;
  final String endpoint;

  CategoriesRepositoryImpl({required this.apiProvider, required this.endpoint});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories({
    int? page,
    int? limit,
  }) async {
    try {
      // Build query parameters for pagination
      String queryString = '';
      if (page != null || limit != null) {
        queryString = '?';
        if (page != null) queryString += 'page=$page&';
        if (limit != null) queryString += 'limit=$limit&';
        queryString = queryString.substring(
          0,
          queryString.length - 1,
        ); // Remove trailing &
      }

      final response = await apiProvider.get('$endpoint$queryString');
      final List<dynamic> categoriesJson = response.body as List;
      final List<CategoryModel> categories =
          categoriesJson
              .map(
                (categoryJson) => CategoryModel.fromJson(
                  categoryJson as Map<String, dynamic>,
                ),
              )
              .toList();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> getCategory(String id) async {
    try {
      final response = await apiProvider.get('$endpoint/$id');
      final CategoryModel category = CategoryModel.fromJson(
        response.body as Map<String, dynamic>,
      );
      return Right(category);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> createCategory(
    CategoryModel category,
  ) async {
    try {
      // Assuming apiProvider.post returns the parsed JSON response directly
      final response = await apiProvider.post(endpoint, category.toJson());

      // Create a category model from the response
      final CategoryModel createdCategory = CategoryModel.fromJson(
        response.body as Map<String, dynamic>,
      );
      return Right(createdCategory);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> updateCategory(
    String id,
    CategoryModel category,
  ) async {
    try {
      final response = await apiProvider.put(
        '$endpoint/$id',
        category.toJson(),
      );
      final CategoryModel updatedCategory = CategoryModel.fromJson(
        response.body as Map<String, dynamic>,
      );
      return Right(updatedCategory);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory(String id) async {
    try {
      await apiProvider.delete('$endpoint/$id');
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
