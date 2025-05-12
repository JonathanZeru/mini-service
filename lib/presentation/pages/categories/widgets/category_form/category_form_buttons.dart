import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/category_form_controller.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';

class CategoryFormButtons extends StatelessWidget {
  final CategoryFormController controller;
  final bool isEditing;

  const CategoryFormButtons({
    super.key,
    required this.controller,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Submit button
        Obx(
          () => CustomButton(
            text: isEditing ? 'update_category'.tr : 'create_category'.tr,
            isLoading: controller.isSaving.value,
            onPressed: controller.saveCategory,
            width: double.infinity,
            isEnabled:
                controller
                    .isFormValid, // Use the isFormValid property to enable/disable the button
          ),
        ),
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
