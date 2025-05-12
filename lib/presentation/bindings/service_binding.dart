import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/services_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';
import 'package:service_booking_app/domain/usecases/service/delete_service.dart';
import 'package:service_booking_app/domain/usecases/service/get_service.dart';
import 'package:service_booking_app/presentation/controllers/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiProvider>()) {
      Get.lazyPut(() => ApiProvider(baseUrl: Constants.apiBaseUrl));
    }

    if (!Get.isRegistered<ServicesRepository>()) {
      Get.lazyPut<ServicesRepository>(
        () => ServicesRepositoryImpl(
          apiProvider: Get.find<ApiProvider>(),
          endpoint: Constants.servicesEndpoint,
          baseUrl: Constants.apiBaseUrl,
        ),
      );
    }

    Get.lazyPut(() => GetService(Get.find<ServicesRepository>()));
    Get.lazyPut(() => DeleteService(Get.find<ServicesRepository>()));

    Get.lazyPut(
      () => ServiceController(
        getService: Get.find<GetService>(),
        deleteService: Get.find<DeleteService>(),
      ),
    );
  }
}
