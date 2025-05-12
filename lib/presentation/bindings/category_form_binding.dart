import 'package:get/get.dart';
import 'package:service_booking_app/core/network/api_provider.dart';
import 'package:service_booking_app/core/utils/constants.dart';
import 'package:service_booking_app/data/repositories/categories_repository_impl.dart';
import 'package:service_booking_app/domain/repositories/categories_repository.dart';
import 'package:service_booking_app/domain/usecases/category/create_category.dart';
import 'package:service_booking_app/domain/usecases/category/get_category.dart';
import 'package:service_booking_app/domain/usecases/category/update_category.dart';
import 'package:service_booking_app/presentation/controllers/category_form_controller.dart';

class CategoryFormBinding extends Bindings {
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

    Get.lazyPut(() => CreateCategory(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => UpdateCategory(Get.find<CategoriesRepository>()));
    Get.lazyPut(() => GetCategory(Get.find<CategoriesRepository>()));

    Get.lazyPut(
      () => CategoryFormController(
        createCategory: Get.find<CreateCategory>(),
        updateCategory: Get.find<UpdateCategory>(),
        getCategory: Get.find<GetCategory>(),
      ),
    );
  }
}
