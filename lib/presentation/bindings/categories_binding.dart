import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/usecases/category/delete_category.dart';
import 'package:service_booking_app/domain/usecases/category/get_categories.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiProvider>()) {
      Get.lazyPut(() => ApiProvider(baseUrl: Constants.apiBaseUrl));
    }
    
    Get.lazyPut<CategoriesRepository>(
      () => CategoriesRepositoryImpl(
        apiProvider: Get.find<ApiProvider>(),
        endpoint: Constants.categoriesEndpoint,
      ),
    );
    
    Get.lazyPut(() => GetCategories(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => DeleteCategory(Get.find<CategoriesRepository>()));
    
    Get.find<AuthController>();
    
    Get.lazyPut(
      () => CategoriesController(
        getCategories: Get.find<GetCategories>(),
        deleteCategory: Get.find<DeleteCategory>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
