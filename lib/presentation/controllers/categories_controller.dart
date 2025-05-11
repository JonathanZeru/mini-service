import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/usecases/delete_category.dart';
import 'package:service_booking_app/domain/usecases/get_categories.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class CategoriesController extends GetxController {
  final GetCategories getCategories;
  final DeleteCategory deleteCategory;
  final AuthController authController;

  CategoriesController({
    required this.getCategories,
    required this.deleteCategory,
    required this.authController,
  });

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<CategoryModel> filteredCategories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMoreCategories = true.obs;
  final RxInt currentPage = 1.obs;
  final RxString searchQuery = ''.obs;
  final int categoriesPerPage = 5;

  bool get isAdmin => authController.isAdmin;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories({bool refresh = true}) async {
    if (refresh) {
      isLoading.value = true;
      currentPage.value = 1;
      categories.clear();
      hasMoreCategories.value = true;
    }
    
    final result = await getCategories(
      page: currentPage.value,
      limit: categoriesPerPage,
    );
    
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'error'.tr,
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        if (refresh) {
          categories.value = data;
        } else {
          categories.addAll(data);
        }
        
        // Check if we've reached the end of the list
        if (data.length < categoriesPerPage) {
          hasMoreCategories.value = false;
        }
        
        filterCategories();
      },
    );
    
    if (refresh) {
      isLoading.value = false;
    } else {
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMoreCategories() async {
    if (isLoadingMore.value || !hasMoreCategories.value) return;
    
    isLoadingMore.value = true;
    currentPage.value++;
    await fetchCategories(refresh: false);
  }

  void filterCategories() {
    final query = searchQuery.value.toLowerCase();
    
    filteredCategories.value = categories.where((category) {
      return category.name.toLowerCase().contains(query) ||
          category.description.toLowerCase().contains(query);
    }).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterCategories();
  }

  void goToCategoryDetails(String id) {
    Get.toNamed(Routes.categoryDetails, arguments: id);
  }

  void goToCreateCategory() {
    Get.toNamed(Routes.createCategory);
  }

  Future<void> confirmDeleteCategory(String id) async {
    UIHelpers.showConfirmationDialog(
      title: 'delete_category'.tr,
      message: 'delete_category_confirm'.tr,
      confirmText: 'delete'.tr,
      onConfirm: () => performDeleteCategory(id),
    );
  }

  Future<void> performDeleteCategory(String id) async {
    isLoading.value = true;
    final result = await deleteCategory(id);
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
        fetchCategories();
      },
    );
    isLoading.value = false;
  }

  void refreshCategories() {
    fetchCategories();
  }
}
