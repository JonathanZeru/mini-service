import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/service_model.dart';

abstract class ServicesRepository {
  Future<Either<Failure, List<ServiceModel>>> getServices({
    String? categoryId,
    double? price,
    bool? availability,
    int? duration,
    double? rating,
    int? page,
    int? limit,
  });
  Future<Either<Failure, ServiceModel>> getService(String id);
  Future<Either<Failure, ServiceModel>> createService(ServiceModel service, File? imageFile);
  Future<Either<Failure, ServiceModel>> updateService(String id, ServiceModel service, File? imageFile);
  Future<Either<Failure, bool>> deleteService(String id);
}
