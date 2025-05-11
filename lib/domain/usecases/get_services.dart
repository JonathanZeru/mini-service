import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';

class GetServices {
  final ServicesRepository repository;

  GetServices(this.repository);

  Future<Either<Failure, List<ServiceModel>>> call({
    String? categoryId,
    double? price,
    bool? availability,
    int? duration,
    double? rating,
    int? page,
    int? limit,
  }) async {
    return await repository.getServices(
      categoryId: categoryId,
      price: price,
      availability: availability,
      duration: duration,
      rating: rating,
      page: page,
      limit: limit,
    );
  }
}
