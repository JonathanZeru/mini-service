import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/usecases/delete_category.dart';
import 'package:service_booking_app/domain/usecases/get_category.dart';
import 'package:service_booking_app/presentation/controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    // Reuse the API provider if it exists
    if (!Get.isRegistered<ApiProvider>()) {
      Get.lazyPut(() => ApiProvider(baseUrl: Constants.apiBaseUrl));
    }
    
    // Reuse the repository if it exists
    if (!Get.isRegistered<CategoriesRepository>()) {
      Get.lazyPut<CategoriesRepository>(
        () => CategoriesRepositoryImpl(
          apiProvider: Get.find<ApiProvider>(),
          endpoint: Constants.categoriesEndpoint,
        ),
      );
    }
    
    Get.lazyPut(() => GetCategory(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => DeleteCategory(Get.find<CategoriesRepository>()));
    
    Get.lazyPut(
      () => CategoryController(
        getCategory: Get.find<GetCategory>(),
        deleteCategory: Get.find<DeleteCategory>(),
      ),
    );
  }
}
