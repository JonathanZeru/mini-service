import 'package:dartz/dartz.dart';
import 'package:service_booking_app/core/errors/failures.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';

class DeleteService {
  final ServicesRepository repository;

  DeleteService(this.repository);

  Future<Either<Failure, bool>> call(String id) async {
    return await repository.deleteService(id);
  }
}
