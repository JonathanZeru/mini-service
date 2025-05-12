import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/data/repositories/services_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';
import 'package:service_booking_app/domain/usecases/service/create_service.dart';
import 'package:service_booking_app/domain/usecases/category/get_categories.dart';
import 'package:service_booking_app/domain/usecases/service/get_service.dart';
import 'package:service_booking_app/domain/usecases/service/update_service.dart';
import 'package:service_booking_app/presentation/controllers/service_form_controller.dart';

class ServiceFormBinding extends Bindings {
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

    if (!Get.isRegistered<CategoriesRepository>()) {
      Get.lazyPut<CategoriesRepository>(
        () => CategoriesRepositoryImpl(
          apiProvider: Get.find<ApiProvider>(),
          endpoint: Constants.categoriesEndpoint,
        ),
      );
    }

    Get.lazyPut(() => CreateService(Get.find<ServicesRepository>()));
    Get.lazyPut(() => UpdateService(Get.find<ServicesRepository>()));
    Get.lazyPut(() => GetService(Get.find<ServicesRepository>()));
    Get.lazyPut(() => GetCategories(Get.find<CategoriesRepository>()));

    Get.lazyPut(
      () => ServiceFormController(
        createService: Get.find<CreateService>(),
        updateService: Get.find<UpdateService>(),
        getService: Get.find<GetService>(),
        getCategories: Get.find<GetCategories>(),
      ),
    );
  }
}
