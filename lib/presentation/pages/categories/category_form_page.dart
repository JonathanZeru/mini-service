import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/category_form_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_form/category_form_buttons.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_form/category_form_fields.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_detail/category_icon_section.dart';
import 'package:service_booking_app/presentation/widgets/loading_indicator.dart';

class CategoryFormPage extends GetView<CategoryFormController> {
  final bool isEditing;

  const CategoryFormPage({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'edit_category'.tr : 'add_category'.tr),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category icon (placeholder)
                const CategoryIconSection(),
                const SizedBox(height: 24),

                // Form fields
                CategoryFormFields(controller: controller),
                const SizedBox(height: 32),

                // Form buttons
                CategoryFormButtons(
                  controller: controller,
                  isEditing: isEditing,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      }),
    );
  }
}
