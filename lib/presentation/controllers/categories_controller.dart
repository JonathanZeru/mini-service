import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/usecases/delete_category.dart';
import 'package:service_booking_app/domain/usecases/get_categories.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class CategoriesController extends GetxController {
  final GetCategories getCategories;
  final DeleteCategory deleteCategory;

  CategoriesController({
    required this.getCategories,
    required this.deleteCategory,
  });

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<CategoryModel> filteredCategories = <CategoryModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    final result = await getCategories();
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        categories.value = data;
        filteredCategories.value = data;
      },
    );
    isLoading.value = false;
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
      title: 'Delete Category',
      message: 'Are you sure you want to delete this category? This action cannot be undone.',
      confirmText: 'Delete',
      onConfirm: () => performDeleteCategory(id),
    );
  }

  Future<void> performDeleteCategory(String id) async {
    isLoading.value = true;
    final result = await deleteCategory(id);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: failure.message,
          isError: true,
        );
      },
      (_) {
        UIHelpers.showSnackbar(
          title: 'Success',
          message: 'Category deleted successfully',
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
