import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/usecases/category/create_category.dart';
import 'package:service_booking_app/domain/usecases/category/get_category.dart';
import 'package:service_booking_app/domain/usecases/category/update_category.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class CategoryFormController extends GetxController {
  final CreateCategory createCategory;
  final UpdateCategory updateCategory;
  final GetCategory getCategory;

  CategoryFormController({
    required this.createCategory,
    required this.updateCategory,
    required this.getCategory,
  });

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;

  final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  String? categoryId;
  bool get isEditing => categoryId != null;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      categoryId = Get.arguments as String;
      loadCategory();
    }

    nameController.addListener(checkFormValidity);
    descriptionController.addListener(checkFormValidity);
  }

  void validateForm() {
    final formValid = formKey.currentState?.validate() ?? false;
    _isFormValid.value = formValid;
  }

  void checkFormValidity() {
    validateForm();
  }

  Future<void> loadCategory() async {
    if (categoryId == null) return;

    isLoading.value = true;
    final result = await getCategory(categoryId!);
    result.fold(
      (failure) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: failure.message,
          isError: true,
        );
      },
      (data) {
        nameController.text = data.name;
        descriptionController.text = data.description;
        checkFormValidity();
      },
    );
    isLoading.value = false;
  }

  String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  Future<void> saveCategory() async {
    if (formKey.currentState?.validate() ?? false) {
      isSaving.value = true;

      final category = CategoryModel(
        id: categoryId,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        createdAt: DateTime.now(),
      );

      try {
        final result =
            isEditing
                ? await updateCategory(categoryId!, category)
                : await createCategory(category);

        result.fold(
          (failure) {
            UIHelpers.showSnackbar(
              title: 'Error',
              message: failure.message,
              isError: true,
            );
            print('Error saving category: ${failure.message}');
          },
          (successCategory) {
            UIHelpers.showSnackbar(
              title: 'Success',
              message:
                  isEditing
                      ? 'Category updated successfully'
                      : 'Category created successfully',
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
      } catch (e) {
        UIHelpers.showSnackbar(
          title: 'Error',
          message: 'An unexpected error occurred: ${e.toString()}',
          isError: true,
        );
        print('Unexpected error: $e');
      } finally {
        isSaving.value = false;
      }
    }
  }

  @override
  void onClose() {
    nameController.removeListener(checkFormValidity);
    descriptionController.removeListener(checkFormValidity);

    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
