import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/data/repositories/services_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';
import 'package:service_booking_app/domain/usecases/category/delete_category.dart';
import 'package:service_booking_app/domain/usecases/category/get_categories.dart';
import 'package:service_booking_app/domain/usecases/service/get_services.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';
import 'package:service_booking_app/presentation/controllers/theme_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiProvider>()) {
      Get.lazyPut(() => ApiProvider(baseUrl: Constants.apiBaseUrl));
    }
    
    Get.lazyPut<ServicesRepository>(
      () => ServicesRepositoryImpl(
        apiProvider: Get.find<ApiProvider>(),
        endpoint: Constants.servicesEndpoint,
        baseUrl: Constants.apiBaseUrl,
      ),
    );
    
    Get.lazyPut<CategoriesRepository>(
      () => CategoriesRepositoryImpl(
        apiProvider: Get.find<ApiProvider>(),
        endpoint: Constants.categoriesEndpoint,
      ),
    );
    
    Get.lazyPut(() => GetServices(Get.find<ServicesRepository>()));
    Get.lazyPut(() => GetCategories(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => DeleteCategory(Get.find<CategoriesRepository>()));
    
    Get.find<AuthController>();
    
    if (!Get.isRegistered<SettingsController>()) {
      Get.put(SettingsController(
        authController: Get.find<AuthController>(),
        languageController: Get.find<LanguageController>(),
        themeController: Get.find<ThemeController>(),
      ));
    }
    
    Get.lazyPut(
      () => HomeController(
        getServices: Get.find<GetServices>(),
        getCategories: Get.find<GetCategories>(),
        deleteCategory: Get.find<DeleteCategory>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
