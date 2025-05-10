import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/usecases/delete_category.dart';
import 'package:service_booking_app/domain/usecases/get_categories.dart';
import 'package:service_booking_app/presentation/controllers/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    // You would typically use a single API provider instance throughout the app
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
    
    Get.lazyPut(
      () => CategoriesController(
        getCategories: Get.find<GetCategories>(),
        deleteCategory: Get.find<DeleteCategory>(),
      ),
    );
  }
}
