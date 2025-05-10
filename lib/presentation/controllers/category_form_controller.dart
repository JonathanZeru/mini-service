import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/domain/usecases/create_category.dart';
import 'package:service_booking_app/domain/usecases/get_category.dart';
import 'package:service_booking_app/domain/usecases/update_category.dart';

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

  String? categoryId;
  bool get isEditing => categoryId != null;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      categoryId = Get.arguments as String;
      loadCategory();
    }
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
    
    // Make sure the CategoryModel constructor matches your model definition
    // Removed createdAt if it's not part of your model
    final category = CategoryModel(
      id: categoryId,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      createdAt: DateTime.now()
    );

    try {
      final result = isEditing
          ? await updateCategory(categoryId!, category)
          : await createCategory(category);
      
      result.fold(
        (failure) {
          // Show error message
          UIHelpers.showSnackbar(
            title: 'Error',
            message: failure.message,
            isError: true,
          );
        },
        (successCategory) { 
          // Show success message
          UIHelpers.showSnackbar(
            title: 'Success',
            message: isEditing
                ? 'Category updated successfully'
                : 'Category created successfully',
            isError: false,
          );
          
          // Navigate back with the created/updated category
          Get.back(result: true);
        },
      );
    } catch (e) {
      // Handle any unexpected errors
      UIHelpers.showSnackbar(
        title: 'Error',
        message: 'An unexpected error occurred: ${e.toString()}',
        isError: true,
      );
    } finally {
      isSaving.value = false;
    }
  }
}
  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
