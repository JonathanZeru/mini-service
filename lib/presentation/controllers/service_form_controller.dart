import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/data/models/category_model.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/domain/usecases/service/create_service.dart';
import 'package:service_booking_app/domain/usecases/category/get_categories.dart';
import 'package:service_booking_app/domain/usecases/service/get_service.dart';
import 'package:service_booking_app/domain/usecases/service/update_service.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class ServiceFormController extends GetxController {
  final CreateService createService;
  final UpdateService updateService;
  final GetService getService;
  final GetCategories getCategories;

  ServiceFormController({
    required this.createService,
    required this.updateService,
    required this.getService,
    required this.getCategories,
  });

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  final RxBool availability = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final Rx<CategoryModel?> selectedCategory = Rx<CategoryModel?>(null);
  final Rx<File?> imageFile = Rx<File?>(null);
  final RxString imageUrl = ''.obs;

  String? serviceId;
  bool get isEditing => serviceId != null;

  final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  void validateForm() {
    final formValid = formKey.currentState?.validate() ?? false;
    final categoryValid = selectedCategory.value != null;
    final imageValid = imageFile.value != null || imageUrl.value.isNotEmpty;
    _isFormValid.value = formValid && categoryValid && imageValid;
  }

  void checkFormValidity() {
    validateForm();
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    if (Get.arguments != null) {
      serviceId = Get.arguments as String;
      loadService();
    }

    // Add listeners to all text controllers
    nameController.addListener(checkFormValidity);
    priceController.addListener(checkFormValidity);
    durationController.addListener(checkFormValidity);
    ratingController.addListener(checkFormValidity);

    // Add reaction to category and image changes
    ever(selectedCategory, (_) => checkFormValidity());
    ever(imageFile, (_) => checkFormValidity());
    ever(imageUrl, (_) => checkFormValidity());
  }

  @override
  void onClose() {
    // Remove listeners to prevent memory leaks
    nameController.removeListener(checkFormValidity);
    priceController.removeListener(checkFormValidity);
    durationController.removeListener(checkFormValidity);
    ratingController.removeListener(checkFormValidity);

    nameController.dispose();
    priceController.dispose();
    durationController.dispose();
    ratingController.dispose();
    super.onClose();
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
      },
    );
    isLoading.value = false;
  }

  Future<void> loadService() async {
    if (serviceId == null) return;

    isLoading.value = true;
    final result = await getService(serviceId!);
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
        priceController.text = data.price.toString();
        durationController.text = data.duration.toString();
        ratingController.text = data.rating.toString();
        availability.value = data.availability;
        imageUrl.value = data.imageUrl ?? '';

        // Find and set the selected category
        final category = categories.firstWhereOrNull(
          (c) => c.id == data.categoryId,
        );
        if (category != null) {
          selectedCategory.value = category;
        }
      },
    );
    isLoading.value = false;
  }

  void setSelectedCategory(CategoryModel category) {
    selectedCategory.value = category;
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    } catch (e) {
      UIHelpers.showSnackbar(
        title: 'Error',
        message: 'Failed to pick image: $e',
        isError: true,
      );
    }
  }

  void showImageSourceDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Get.back();
                pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }
    return null;
  }

  String? validateInteger(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    if (int.tryParse(value) == null) {
      return '$fieldName must be a valid integer';
    }
    return null;
  }

  String? validateRating(String? value) {
    if (value == null || value.isEmpty) {
      return 'Rating is required';
    }
    final rating = double.tryParse(value);
    if (rating == null) {
      return 'Rating must be a valid number';
    }
    if (rating < 0 || rating > 5) {
      return 'Rating must be between 0 and 5';
    }
    return null;
  }

  String? validateCategory() {
    if (selectedCategory.value == null) {
      return 'Please select a category';
    }
    return null;
  }

  String? validateImage() {
    if (imageFile.value == null && imageUrl.value.isEmpty) {
      return 'Please select an image';
    }
    return null;
  }

  Future<void> saveService() async {
    // Validate category selection
    final categoryError = validateCategory();
    if (categoryError != null) {
      UIHelpers.showSnackbar(
        title: 'Validation Error',
        message: categoryError,
        isError: true,
      );
      return;
    }

    // Validate image
    final imageError = validateImage();
    if (imageError != null) {
      UIHelpers.showSnackbar(
        title: 'Validation Error',
        message: imageError,
        isError: true,
      );
      return;
    }

    if (formKey.currentState?.validate() ?? false) {
      isSaving.value = true;

      final service = ServiceModel(
        id: serviceId,
        name: nameController.text.trim(),
        categoryId: selectedCategory.value!.id!,
        price: double.parse(priceController.text.trim()),
        imageUrl: imageUrl.value,
        availability: availability.value,
        duration: int.parse(durationController.text.trim()),
        rating: double.parse(ratingController.text.trim()),
        createdAt: DateTime.now(),
      );

      final result =
          isEditing
              ? await updateService(
                serviceId!,
                service,
                imageFile: imageFile.value,
              )
              : await createService(service, imageFile: imageFile.value);

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
            message:
                isEditing
                    ? 'Service updated successfully'
                    : 'Service created successfully',
            isError: false,
          );

          try {
            final homeController = Get.find<HomeController>();
            homeController.fetchServices().then((_) {
              Get.until((route) => route.settings.name == Routes.home);
            });
          } catch (e) {
            Get.until((route) => route.settings.name == Routes.home);
          }
        },
      );

      isSaving.value = false;
    }
  }
}
