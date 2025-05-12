import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/usecases/category/delete_category.dart';
import 'package:service_booking_app/domain/usecases/category/get_category.dart';
import 'package:service_booking_app/domain/usecases/service/get_services.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class CategoryController extends GetxController {
  final GetCategory getCategory;
  final DeleteCategory deleteCategory;
  final GetServices getServices;
  final AuthController authController;

  CategoryController({
    required this.getCategory,
    required this.deleteCategory,
    required this.getServices,
    required this.authController,
  });

  final Rx<CategoryModel?> category = Rx<CategoryModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isDeleting = false.obs;
  final RxBool isLoadingServices = false.obs;
  final RxList<ServiceModel> categoryServices = <ServiceModel>[].obs;
  final RxString categoryName = ''.obs;
  bool get isAdmin => authController.isAdmin;

  @override
  void onInit() {
    super.onInit();
    final String categoryId = Get.arguments as String;
    fetchCategory(categoryId);
    fetchCategoryServices(categoryId);
  }

  Future<void> fetchCategory(String id) async {
    isLoading.value = true;
    final result = await getCategory(id);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        category.value = data;
      },
    );
    isLoading.value = false;
  }

  Future<void> fetchCategoryServices(String categoryId) async {
    isLoadingServices.value = true;
    final result = await getServices(categoryId: categoryId);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        categoryServices.value = data;
      },
    );
    isLoadingServices.value = false;
  }

  void goToEditCategory() {
    if (category.value != null) {
      Get.toNamed(
        Routes.editCategory,
        arguments: category.value!.id,
      );
    }
  }

  void goToCreateService() {
    Get.toNamed(Routes.createService, arguments: {'preselectedCategoryId': category.value?.id});
  }

  void goToServiceDetails(String id) {
    Get.toNamed(Routes.serviceDetails, arguments: id);
  }

  Future<void> confirmDelete() async {
    UIHelpers.showConfirmationDialog(
      title: 'delete_category'.tr,
      message: 'delete_category_confirm'.tr,
      confirmText: 'delete'.tr,
      onConfirm: () => performDelete(),
    );
  }

  Future<void> performDelete() async {
    if (category.value?.id == null) return;
    
    isDeleting.value = true;
    final result = await deleteCategory(category.value!.id!);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (_) {
        UIHelpers.showSnackbar(
          title: 'success'.tr,
          message: 'category_deleted'.tr,
          isError: false,
        );
          try {
            final homeController = Get.find<HomeController>();
            homeController.fetchCategories().then((_) {
              Get.until((route) => route.settings.name == Routes.home);
            });
          } catch (e) {
            Get.until((route) => route.settings.name == Routes.home);
          }
      },
    );
    isDeleting.value = false;
  }

  void refreshCategory() {
    if (category.value?.id != null) {
      fetchCategory(category.value!.id!);
      fetchCategoryServices(category.value!.id!);
    }
  }
}
