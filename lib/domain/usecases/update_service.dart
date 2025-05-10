import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';

class UpdateService {
  final ServicesRepository repository;

  UpdateService(this.repository);

  Future<Either<Failure, ServiceModel>> call(String id, ServiceModel service, {File? imageFile}) async {
    return await repository.updateService(id, service, imageFile);
  }
}
