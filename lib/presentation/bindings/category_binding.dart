import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/data/repositories/services_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';
import 'package:service_booking_app/domain/usecases/category/delete_category.dart';
import 'package:service_booking_app/domain/usecases/category/get_category.dart';
import 'package:service_booking_app/domain/usecases/service/get_services.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/category_controller.dart';
class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiProvider>()) {
      Get.lazyPut(() => ApiProvider(baseUrl: Constants.apiBaseUrl));
    }
    
    if (!Get.isRegistered<CategoriesRepository>()) {
      Get.lazyPut<CategoriesRepository>(
        () => CategoriesRepositoryImpl(
          apiProvider: Get.find<ApiProvider>(),
          endpoint: Constants.categoriesEndpoint,
        ),
      );
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
    
    Get.lazyPut(() => GetCategory(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => DeleteCategory(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => GetServices(Get.find<ServicesRepository>()));
    
    Get.find<AuthController>();
    
    Get.lazyPut(
      () => CategoryController(
        getCategory: Get.find<GetCategory>(),
        deleteCategory: Get.find<DeleteCategory>(),
        getServices: Get.find<GetServices>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
