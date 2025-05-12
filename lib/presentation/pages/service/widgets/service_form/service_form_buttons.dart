import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/service_form_controller.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';

class ServiceFormButtons extends StatelessWidget {
  final ServiceFormController controller;
  final bool isEditing;

  const ServiceFormButtons({
    super.key,
    required this.controller,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Submit button
        Obx(() {
          final hasCategory = controller.selectedCategory.value != null;
          final hasImage =
              controller.imageFile.value != null ||
              controller.imageUrl.value.isNotEmpty;
          final isFormComplete =
              hasCategory && hasImage && controller.isFormValid;

          return CustomButton(
            text: isEditing ? 'update_service'.tr : 'create_service'.tr,
            isLoading: controller.isSaving.value,
            onPressed: controller.saveService,
            width: double.infinity,
            isEnabled: isFormComplete,
          );
        }),

        const SizedBox(height: 16),

        // Cancel button
        CustomButton(
          text: 'cancel'.tr,
          onPressed: () => Get.back(),
          width: double.infinity,
          isOutlined: true,
        ),
      ],
    );
  }
}
