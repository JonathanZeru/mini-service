import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/category_form_controller.dart';

class CategoryFormFields extends StatelessWidget {
  final CategoryFormController controller;

  const CategoryFormFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category name
        TextFormField(
          controller: controller.nameController,
          decoration: InputDecoration(
            labelText: 'category_name'.tr,
            hintText: 'enter_category_name'.tr,
            prefixIcon: const Icon(Icons.label),
            border: const OutlineInputBorder(),
          ),
          validator:
              (value) => controller.validateNotEmpty(value, 'category_name'.tr),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),

        // Category description
        TextFormField(
          controller: controller.descriptionController,
          decoration: InputDecoration(
            labelText: 'category_description'.tr,
            hintText: 'enter_category_description'.tr,
            prefixIcon: const Icon(Icons.description),
            border: const OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          maxLines: 5,
          validator:
              (value) =>
                  controller.validateNotEmpty(value, 'category_description'.tr),
        ),
      ],
    );
  }
}
