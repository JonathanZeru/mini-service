import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/data/repositories/services_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/repositories/services_repository.dart';
import 'package:service_booking_app/domain/usecases/delete_category.dart';
import 'package:service_booking_app/domain/usecases/get_categories.dart';
import 'package:service_booking_app/domain/usecases/get_services.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';
import 'package:service_booking_app/presentation/controllers/theme_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // You would typically use a single API provider instance throughout the app
    if (!Get.isRegistered<ApiProvider>()) {
      Get.lazyPut(() => ApiProvider(baseUrl: Constants.apiBaseUrl));
    }
    
    // Services repository
    Get.lazyPut<ServicesRepository>(
      () => ServicesRepositoryImpl(
        apiProvider: Get.find<ApiProvider>(),
        endpoint: Constants.servicesEndpoint,
        baseUrl: Constants.apiBaseUrl,
      ),
    );
    
    // Categories repository
    Get.lazyPut<CategoriesRepository>(
      () => CategoriesRepositoryImpl(
        apiProvider: Get.find<ApiProvider>(),
        endpoint: Constants.categoriesEndpoint,
      ),
    );
    
    Get.lazyPut(() => GetServices(Get.find<ServicesRepository>()));
    Get.lazyPut(() => GetCategories(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => DeleteCategory(Get.find<CategoriesRepository>()));
    
    // Make sure AuthController is available
    Get.find<AuthController>();
    
    // Make sure SettingsController is available for the settings tab
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
