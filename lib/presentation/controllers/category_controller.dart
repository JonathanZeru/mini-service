import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/usecases/delete_category.dart';
import 'package:service_booking_app/domain/usecases/get_category.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class CategoryController extends GetxController {
  final GetCategory getCategory;
  final DeleteCategory deleteCategory;

  CategoryController({
    required this.getCategory,
    required this.deleteCategory,
  });

  final Rx<CategoryModel?> category = Rx<CategoryModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    final String categoryId = Get.arguments as String;
    fetchCategory(categoryId);
  }

  Future<void> fetchCategory(String id) async {
    isLoading.value = true;
    final result = await getCategory(id);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
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

  void goToEditCategory() {
    if (category.value != null) {
      Get.toNamed(
        Routes.editCategory,
        arguments: category.value!.id,
      );
    }
  }

  Future<void> confirmDelete() async {
    UIHelpers.showConfirmationDialog(
      title: 'Delete Category',
      message: 'Are you sure you want to delete this category? This action cannot be undone.',
      confirmText: 'Delete',
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
        Get.back(); // Go back to categories list
      },
    );
    isDeleting.value = false;
  }

  void refreshCategory() {
    if (category.value?.id != null) {
      fetchCategory(category.value!.id!);
    }
  }
}
